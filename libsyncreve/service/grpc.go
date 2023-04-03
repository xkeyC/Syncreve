package service

import (
	"fmt"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
	"google.golang.org/grpc"
	"net"
	"os"
)

var grpcServer *grpc.Server

func StartGRPCService(workingDir string) {
	var sockPath = workingDir + "/syncreve_grpc.sock"
	if utils.FileExist(sockPath) {
		utils.IfPanic(os.Remove(sockPath))
	}
	serverAddress, err := net.ResolveUnixAddr("unix", sockPath)
	utils.IfPanic(err)
	listen, err := net.ListenUnix("unix", serverAddress)
	utils.IfPanic(err)
	grpcServer = grpc.NewServer()
	protos.RegisterPingServiceServer(grpcServer, &pingServerImpl{})
	protos.RegisterFileSyncServiceServer(grpcServer, &fileSyncServerImpl{})
	fmt.Println("[libsyncreve] GRPCService started with unix socket", sockPath)
	utils.IfPanic(grpcServer.Serve(listen))
}

func StopGRPCService() {
	grpcServer.Stop()
}
