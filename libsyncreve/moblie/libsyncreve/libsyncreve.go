package libsyncreve

import (
	"fmt"
	"github.com/xkeyC/Syncreve/libsyncreve/data"
	"github.com/xkeyC/Syncreve/libsyncreve/service"
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
	go service.StartGRPCService(conf.Port)
	return nil
}

func StopService() error {
	return nil
}
