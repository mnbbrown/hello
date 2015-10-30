package main

import (
	"fmt"
	"github.com/labstack/echo"
	mw "github.com/labstack/echo/middleware"
	"net/http"
	"os"
)

var (
	version = "0.0.1"
)

func Hello(rw http.ResponseWriter, req *http.Request) {
	hostname, err := os.Hostname()
	if err != nil {
		rw.WriteHeader(http.StatusInternalServerError)
		fmt.Fprintf(rw, "Error: %s", err.Error())
		return
	}
	fmt.Fprintf(rw, "Hello from %s", hostname)
}

func main() {

	e := echo.New()
	e.Use(mw.Logger())
	e.Use(mw.Recover())

	e.Get("/", Hello)
	e.Run(":8080")

}
