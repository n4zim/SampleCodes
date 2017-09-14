package main

import (
	"fmt"
	"./helpers"
)

func main() {

	string := "This is a test string"
	fmt.Println("Original string :", string)

	// Reverse
	fmt.Println("String reverse :", helpers.StringsReverse(string))

}
