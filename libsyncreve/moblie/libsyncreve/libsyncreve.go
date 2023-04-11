package libsyncreve

import (
	"fmt"
	"github.com/xkeyC/Syncreve/libsyncreve/data"
	"github.com/xkeyC/Syncreve/libsyncreve/data/db"
	"github.com/xkeyC/Syncreve/libsyncreve/service"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
	"gopkg.in/yaml.v3"
	"os"
)

func StartService(confPath string) error {
	fmt.Println("[libsyncreve] StartService confPath ==", confPath)
	bytesData, err := os.ReadFile(confPath)
	if err != nil {
		return err
	}
	var conf = data.ServiceConfData{}
	err = yaml.Unmarshal(bytesData, &conf)
	if err != nil {
		return err
	}
	fmt.Println("[libsyncreve] StartService yamlData ==", conf)
	err = db.Init(conf.WorkingDir)
	fmt.Println("db.Init Error", err)
	utils.IfPanic(err)
	go service.StartGRPCService(conf.WorkingDir)
	return nil
}

func StopService() error {
	fmt.Println("[libsyncreve] StopService")
	service.StopGRPCService()
	return nil
}
