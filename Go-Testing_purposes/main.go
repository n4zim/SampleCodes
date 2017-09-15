package main

import (
	"fmt"
	"time"
	"./helpers"
	"./types"
)

var mode string

func files() {
	// Write a file with current time
	write := &types.File {
		Name: "time",
		Content: []byte("Time : " + time.Now().String()),
	}
	write.Save()

	// Read the file and display it
	read, _ := helpers.FilesLoad("time")
	fmt.Println(string(read.Content))
}

func vars() {
	string := "This is a test string"
	fmt.Println("Original string :", string)

	// Reverse
	fmt.Println("String reverse :", helpers.StringsReverse(string))
}

func main() {
	switch mode {
	case "files": files()
	case "vars": vars()
	case "": fmt.Printf("Missing or empty \"mode\" parameter")
	default: fmt.Printf("Unknown mode")
	}
}
