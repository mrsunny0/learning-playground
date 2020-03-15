package main

import (
	"flag"
	"fmt"
	"log"
	_ "net/http"

	"github.com/gin-gonic/gin"

	"main/test"
)

var input = flag.String("input", "HELLO", "basic input")

func main() {
	r := gin.Default()
	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message" : "pong",
		})
	})
	r.Run()
}

func xxx() {
	flag.Parse()

	fmt.Println("THIS IS SOMETHING")
	log.Println("THIS IS A LOG")
	log.Println(*input)

	fmt.Println(test.HelloWorld())
	fmt.Println(test.GoodBye())
}
