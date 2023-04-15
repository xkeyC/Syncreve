package main

import (
	"github.com/xkeyC/Syncreve/libsyncreve/data/db"
	"github.com/xkeyC/Syncreve/libsyncreve/service"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
)

func main() {
	err := db.Init(".")
	utils.IfPanic(err)
	service.StartGRPCService(".")
}
