package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

type reqBody struct {
	Day int `json:"day"`
}

type reqHeader struct {
	AppId  string `json:"appid"`
	AppKey string `json:"appkey"`
}

var wether = []int{0, 17, 30, 25, 27, 19, 23, 20}

func main() {
	r := gin.Default()
	r.GET("/api/getWeather", getWeather)

	if err := r.Run(":8080"); err != nil {
		log.Fatal(err.Error())
	}
}

func getWeather(c *gin.Context) {
	var header reqHeader
	var days reqBody

	if err := c.ShouldBindHeader(&header); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   true,
			"message": "invalid request header",
		})

		return
	}

	if err := c.ShouldBindJSON(&days); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   true,
			"message": "invalid request body",
		})

		return
	}

	// Validation
	isValidRequest := header.AppId != "" && header.AppKey != "" && days.Day > 0 && days.Day < 8

	if isValidRequest {
		temp := fmt.Sprint("Temp. is: ", wether[days.Day], " C")
		c.JSON(http.StatusOK, gin.H{
			"error":   false,
			"message": temp,
		})

	} else {
		c.JSON(http.StatusBadRequest, gin.H{
			"error":   true,
			"message": "invalid request",
		})
	}
}
