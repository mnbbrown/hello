BRANCH = $(CI_BRANCH)
COMMIT = $(CI_COMMIT)
TIMESTAMP = $(shell /bin/date -u +%FT%TZ)
LD_FLAGS = "-s -X main.branch=${BRANCH} -X main.commit=$(COMMIT) -X main.date=$(TIMESTAMP)"

all: run

clean:
	rm -rf build

quick:
		go build -o build/hello

build: clean *.go
		CGO_ENABLED=0 go build -ldflags $(LD_FLAGS) -a -installsuffix cgo -o build/hello

deps:
		go get -t -v ./...

run: quick
		./build/hello

test:
		go test -v ./...

coverage:
		go test . -coverprofile=coverage.out
			go tool cover -html=coverage.out -o coverage.html

build-linux: clean *.go
		CGO_ENABLED=0 GOOS=linux go build -ldflags $(LD_FLAGS) -a -installsuffix cgo -o build/hello.linux

dockerize: build-linux
		sh scripts/docker.sh
