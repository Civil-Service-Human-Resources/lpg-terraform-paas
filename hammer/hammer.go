package main

import (
	"bufio"
	"bytes"
	"crypto/tls"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"os/exec"
	"path/filepath"
	"strconv"
	"strings"
	"time"
)

var app = os.Getenv("ENV_APP")
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
	for {
		c, err := tls.Dial("tcp", fmt.Sprintf("%s:%d", l.host, l.port), nil)
		if err == nil {
			backoff = time.Second / 2
			buf := bufio.NewWriter(c)
		sendLoop:
			for {
				select {
				case msg := <-l.stream:
					_, err = c.Write(msg)
					if err != nil {
						fmt.Printf("Failed to send message to logstash: %s\n", msg)
						break
					}
					_, err = c.Write(newline)
					if err != nil {
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
	data, err := json.Marshal(payload)
	if err != nil {
		fmt.Printf("Error encoding JSON data to send to Logstash: %s", err)
	}
	l.stream <- data
}

type proxy struct {
	buf   []byte
	file  *os.File
	level string
	log   *logger
}

func (p *proxy) Write(data []byte) (n int, err error) {
	p.file.Write(data)
	idx := bytes.Index(data, newline)
	if idx == -1 {
		p.buf = append(p.buf, data...)
		return len(data), nil
	}
	msg := append(p.buf, data[:idx]...)
	if len(data) > idx+1 {
		p.buf = data[idx+1:]
	}
	p.log.Write(string(msg), p.level)
	return len(data), nil
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

	cmdPath := args[0]
	if filepath.Base(cmdPath) == cmdPath {
		if lp, err := exec.LookPath(cmdPath); err != nil {
			log.Exit("Could not find executable path for %q: %s", cmdPath, err)
		} else {
			cmdPath = lp
		}
	}

	for {
		cmd := &exec.Cmd{
			Args:   args,
			Dir:    workingDir,
			Path:   cmdPath,
			Stderr: &proxy{[]byte{}, os.Stderr, "error", log},
			Stdout: &proxy{[]byte{}, os.Stderr, "info", log},
		}
		err := cmd.Run()
		if err != nil {
			log.Error("Got error running: %s: %#v", strings.Join(args, " "), err)
		}
		if os.Getenv("HAMMER_EXIT_ON_FAILURE") != "" {
			log.Exit("Exiting as process died and HAMMER_EXIT_ON_FAILURE=%s", os.Getenv("HAMMER_EXIT_ON_FAILURE"))
		}
	}

}
