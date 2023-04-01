package libsyncreve

import "github.com/xkeyC/Syncreve/libsyncreve/service"

func StartService(port int) {
	service.StartGRPCService(port)
}
