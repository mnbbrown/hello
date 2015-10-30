package main

import (
	"fmt"
	"github.com/labstack/echo"
	mw "github.com/labstack/echo/middleware"
	"net/http"
	"os"
)

var (
	branch = "local"
	commit = ""
	date   = ""
)

func Hello(rw http.ResponseWriter, req *http.Request) {
	hostname, err := os.Hostname()
	if err != nil {
		rw.WriteHeader(http.StatusInternalServerError)
		fmt.Fprintf(rw, "Error: %s", err.Error())
		return
	}
	fmt.Fprintf(rw, "Hello Gen from Singapore\nbranch: %s\ncommit: %s\ntimestamp: %s", hostname, branch, commit, date)
}

func main() {

	e := echo.New()
	e.Use(mw.Logger())
	e.Use(mw.Recover())

	e.Get("/", Hello)
	e.Run(":8080")

}
