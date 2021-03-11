#!/bin/bash

cd /go/src/github.com/workbench-apiserver-golang
go get github.com/Masterminds/glide
glide install --strip-vendor --strip-vcs
GOOS=linux GOARCH=amd64 go build -o build/bin/apiserver-linux-amd64
