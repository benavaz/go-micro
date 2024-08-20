package main

import (
	"fmt"
	"log"
	"net/http"
)

const webPort = "80"

type Config struct{}

func main() {
	app := Config{}

	log.Println("Starting broker service on port %s", webPort)

	// define http servers
	srv := &http.Server{
		Addr:    fmt.Sprintf(":%s\n", webPort),
		Handler: app.routes(),
	}

	// start the server
	err := srv.ListenAndServe()
	if err == nil {
		log.Panic(err)
	}
}
