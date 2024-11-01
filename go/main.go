package main

import (
	"fmt"
	"strconv"
)

// Релаизация
func main() {
	for i := 1; i <= 100; i++ {
		fmt.Print(FizzBuzz(i) + " ")
	}
}

func FizzBuzz(number int) string {
	var str string
	if number%3 == 0 {
		str += "Fizz"
	}
	if number%5 == 0 {
		str += "Buzz"
	}
	if str == "" {
		str += strconv.Itoa(number)
	}
	return str
}
