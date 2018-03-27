package main

import (
	"bufio"
	"crypto/tls"
	"crypto/x509"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"os/exec"
	"os/signal"
	"path/filepath"
	"strconv"
	"strings"
	"sync"
	"syscall"
	"time"
)

var app = os.Getenv("WEBSITE_SITE_NAME")
var env = os.Getenv("ENV_PROFILE")
var newline = []byte{'\n'}

const usage = `Usage: hammer [SUBCOMMAND PARAMS...]

Hammer can be configured via the following environment variables:

  HAMMER_EXIT_ON_FAILURE
  HAMMER_HTTP_SERVER_PORT       (port for dummy server which returns 200 OK for all requests)
  HAMMER_LOGSTASH_HOST          (host is always accessed over TLS)
  HAMMER_LOGSTASH_PORT
  HAMMER_LOGSTASH_SECRET_KEY    (specified as 'secret_key' in the JSON payload)
  HAMMER_WORKING_DIRECTORY
`

const version = "0.1"

type logger struct {
	host   string
	port   int
	secret string
	stream chan []byte
}

func (l *logger) Info(msg string, args ...interface{}) {
	fmt.Printf(msg+"\n", args...)
	l.Write(fmt.Sprintf(msg, args...), "info")
}

func (l *logger) Error(msg string, args ...interface{}) {
	fmt.Printf(msg+"\n", args...)
	l.Write(fmt.Sprintf(msg, args...), "error")
}

func (l *logger) Exit(msg string, args ...interface{}) {
	fmt.Printf(msg+"\n", args...)
	l.Write(fmt.Sprintf(msg, args...), "error")
	for {
		if len(l.stream) > 0 {
			time.Sleep(time.Second)
		} else {
			break
		}
	}
	os.Exit(1)
}

func (l *logger) Run() {
	var backoff time.Duration
	caPool := x509.NewCertPool()
	caPool.AppendCertsFromPEM([]byte(caCerts))
	unsent := [][]byte{}
	for {
		c, err := tls.Dial("tcp", fmt.Sprintf("%s:%d", l.host, l.port), &tls.Config{
			RootCAs: caPool,
		})
		if err == nil {
			backoff = time.Second / 2
			buf := bufio.NewWriter(c)
		sendLoop:
			for {
				unsentCount := len(unsent)
				for i := 0; i < unsentCount; i++ {
					msg := unsent[i]
					c.SetWriteDeadline(time.Now().Add(10 * time.Second))
					_, err = buf.Write(msg)
					if err != nil {
						fmt.Printf("Failed to send message to logstash: %s\n", msg)
						unsent = unsent[i:]
						break sendLoop
					}
				}
				unsent = [][]byte{}
				select {
				case msg := <-l.stream:
					c.SetWriteDeadline(time.Now().Add(10 * time.Second))
					_, err = buf.Write(msg)
					if err != nil {
						fmt.Printf("Failed to send message to logstash: %s\n", msg)
						unsent = append(unsent, msg)
						break sendLoop
					}
				case <-time.After(time.Second):
					buf.Flush()
				}
			}
		}
		fmt.Printf("Got error connecting to logstash: %s\n", err)
		backoff = backoff * 2
		if backoff > 30*time.Second {
			backoff = 30 * time.Second
		}
		time.Sleep(backoff)
	}
}

func (l *logger) Write(msg string, level string) {
	payload := map[string]string{
		"@app":         app,
		"@environment": env,
		"@level":       level,
		"@timestamp":   time.Now().UTC().Format(time.RFC3339Nano),
		"@message":     msg,
	}
	if l.secret != "" {
		payload["secret_token"] = l.secret
	}
	data, err := json.Marshal(payload)
	if err != nil {
		fmt.Printf("Error encoding JSON data to send to Logstash: %s\n", err)
	}
	l.stream <- append(data, '\n')
}

type proxy struct {
	buf   []byte
	file  *os.File
	last  time.Time
	level string
	log   *logger
	mutex sync.Mutex
	quit  chan struct{}
}

func (p *proxy) Close() {
	p.quit <- struct{}{}
}

func (p *proxy) Flush(checkTime bool) {
	p.mutex.Lock()
	if checkTime {
		if time.Since(p.last) < 5*time.Second {
			p.mutex.Unlock()
			return
		}
	}
	if len(p.buf) > 0 {
		p.log.Write(string(p.buf), p.level)
		p.buf = []byte{}
	}
	p.mutex.Unlock()
}

func (p *proxy) Run() {
mainLoop:
	for {
		select {
		case <-time.After(5 * time.Second):
			p.Flush(true)
		case <-p.quit:
			p.Flush(false)
			break mainLoop
		}
	}
}

func (p *proxy) Write(input []byte) (n int, err error) {
	p.file.Write(input)
	p.mutex.Lock()
	buf := p.buf
	seenNewline := false
	for _, char := range input {
		if char == '\n' {
			if seenNewline {
				buf = append(buf, '\n')
			} else {
				seenNewline = true
			}
			continue
		}
		if seenNewline {
			if (len(buf) < 65536) && (char == ' ' || char == '\t') {
				buf = append(buf, '\n')
			} else {
				p.log.Write(string(buf), p.level)
				buf = []byte{}
			}
			seenNewline = false
		}
		buf = append(buf, char)
	}
	if seenNewline && len(buf) > 0 {
		p.log.Write(string(buf), p.level)
		buf = []byte{}
	}
	p.buf = buf
	p.last = time.Now()
	p.mutex.Unlock()
	return len(input), nil
}

func createLogger() *logger {
	host := getRequiredEnv("HAMMER_LOGSTASH_HOST")
	port, err := strconv.ParseInt(getRequiredEnv("HAMMER_LOGSTASH_PORT"), 10, 64)
	if err != nil {
		fmt.Println("Could not parse the HAMMER_LOGSTASH_PORT value:", err)
		os.Exit(1)
	}
	secret := os.Getenv("HAMMER_LOGSTASH_SECRET_KEY")
	log := &logger{
		host:   host,
		port:   int(port),
		secret: secret,
		stream: make(chan []byte, 1000)}
	go log.Run()
	return log
}

func getRequiredEnv(name string) string {
	value := os.Getenv(name)
	if value == "" {
		fmt.Println("The " + name + " environment variable must be set")
		os.Exit(1)
	}
	return value
}

func reapOrphans() {
	terminations := make(chan struct{}, 100)
	go func() {
		sigs := make(chan os.Signal, 100)
		signal.Notify(sigs, syscall.SIGCHLD)
		for _ = range sigs {
			select {
			case terminations <- struct{}{}:
				break
			default:
				// Skip alerting of the termination channel if it is full. The
				// child processed will be reaped the next time there's an alert
				// anyway, so it's not much of an issue.
			}
		}
	}()
	for _ = range terminations {
		for {
			var status syscall.WaitStatus
			pid, err := syscall.Wait4(-1, &status, 0, nil)
			for syscall.EINTR == err {
				pid, err = syscall.Wait4(pid, &status, 0, nil)
			}
			fmt.Printf("Cleaned up after pid %d\n", pid)
			if syscall.ECHILD == err {
				break
			}
		}
	}
}

func main() {

	args := os.Args[1:]
	if len(args) == 0 {
		fmt.Println(usage)
		os.Exit(1)
	}

	if args[0] == "-h" || args[0] == "--help" {
		fmt.Println(usage)
		os.Exit(0)
	}

	if args[0] == "-v" || args[0] == "--version" {
		fmt.Println("hammer " + version)
		os.Exit(0)
	}

	log := createLogger()

	workingDir := os.Getenv("HAMMER_WORKING_DIRECTORY")
	if workingDir == "" {
		var err error
		workingDir, err = os.Getwd()
		if err != nil {
			log.Exit("Could not lookup current working directory:", err)
		}
	}

	httpPort := os.Getenv("HAMMER_HTTP_SERVER_PORT")
	if httpPort != "" {
		port, err := strconv.ParseInt(httpPort, 10, 64)
		if err != nil {
			log.Exit("Could not parse the HAMMER_HTTP_SERVER_PORT value:", err)
		}
		http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
			fmt.Fprintf(w, "OK")
		})
		server := &http.Server{
			Addr:           ":" + httpPort,
			ReadTimeout:    10 * time.Second,
			WriteTimeout:   10 * time.Second,
			MaxHeaderBytes: 1 << 20,
		}
		go func() {
			log.Info("Running dummy HTTP server on port %d", port)
			err := server.ListenAndServe()
			if err != nil {
				log.Exit("Could not run HTTP server on port %d: %s", port, err)
			}
		}()
	}

	go reapOrphans()

	cmdPath := args[0]
	if filepath.Base(cmdPath) == cmdPath {
		if lp, err := exec.LookPath(cmdPath); err != nil {
			log.Exit("Could not find executable path for %q: %s", cmdPath, err)
		} else {
			cmdPath = lp
		}
	}

	for {
		stderr := &proxy{
			[]byte{}, os.Stderr, time.Now(),
			"error", log, sync.Mutex{}, make(chan struct{}),
		}
		go stderr.Run()
		stdout := &proxy{
			[]byte{}, os.Stdout, time.Now(),
			"info", log, sync.Mutex{}, make(chan struct{}),
		}
		go stdout.Run()
		cmd := &exec.Cmd{
			Args:   args,
			Dir:    workingDir,
			Path:   cmdPath,
			Stderr: stderr,
			Stdout: stdout,
		}
		err := cmd.Run()
		stderr.Close()
		stdout.Close()
		if err != nil {
			log.Error("Got error running: %s: %#v", strings.Join(args, " "), err)
		}
		if os.Getenv("HAMMER_EXIT_ON_FAILURE") != "" {
			log.Exit("Exiting as process died and HAMMER_EXIT_ON_FAILURE=%s", os.Getenv("HAMMER_EXIT_ON_FAILURE"))
		}
	}

}
