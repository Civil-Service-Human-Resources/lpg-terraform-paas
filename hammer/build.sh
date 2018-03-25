#! /usr/bin/env bash

GOOS=linux go build -o hammer -ldflags=-s hammer.go cacerts.go
