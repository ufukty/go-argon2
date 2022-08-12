package main

import (
	"fmt"
	"log"

	"github.com/tvdburgt/go-argon2"
)

func main() {
	hash, err := argon2.HashEncoded(argon2.NewContext(), []byte("helloworld"), []byte("saltsalt"))
	if err != nil {
		log.Fatalln(err)
	}
	fmt.Print(hash)
}
