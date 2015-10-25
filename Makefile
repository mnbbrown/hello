VERSION = $(shell git describe --tags)

all: run

quick:
		go build -o build/hello

build: *.go
		CGO_ENABLED=0 go build -ldflags "-s -X main.version=$(VERSION)" -a -installsuffix cgo -o build/hello

deps:
		go get -t -v ./...

run: quick
		./build/hello

test:
		go test -v ./...

coverage:
		go test . -coverprofile=coverage.out
			go tool cover -html=coverage.out -o coverage.html

build-linux:
		CGO_ENABLED=0 GOOS=linux go build -ldflags "-s -X main.version=${VERSION}" -a -installsuffix cgo -o build/hello.linux

dockerize: build-linux
		sh scripts/docker.sh
