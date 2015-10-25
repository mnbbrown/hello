package main

import (
	"fmt"
	"github.com/labstack/echo"
	mw "github.com/labstack/echo/middleware"
	"net/http"
)

func Hello(rw http.ResponseWriter, req *http.Request) {
	fmt.Fprintln(rw, "Hello")
}

func main() {

	e := echo.New()
	e.Use(mw.Logger())
	e.Use(mw.Recover())

	e.Get("/", Hello)
	e.Run(":8080")

}
