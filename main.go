package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "Hello, World!")
}

func main() {
    http.HandleFunc("/", handler)
    port := "8080"
    fmt.Println("Server is listening on port", port)
    http.ListenAndServe(":"+port, nil)
}