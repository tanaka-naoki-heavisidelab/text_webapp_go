#!/bin/bash

MODULE_NAME=$(basename $(pwd))
go mod init $MODULE_NAME 
go get github.com/go-sql-driver/mysql 
mkdir -p bin/
CGO_ENABLED=0 GOOS=linux go build -v -o bin/myapp
