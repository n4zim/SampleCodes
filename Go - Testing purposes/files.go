package main

import (
	"fmt"
	"time"
	"./types"
	"./helpers"
)

func main() {

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
