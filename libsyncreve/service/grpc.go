package service

import (
	"fmt"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
	"google.golang.org/grpc"
	"net"
)

var grpcServer *grpc.Server

func StartGRPCService(port int) {
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", port))
	utils.IfPanic(err)
	grpcServer = grpc.NewServer()
	protos.RegisterPingServiceServer(grpcServer, &pingServerImpl{})
	protos.RegisterFileSyncServiceServer(grpcServer, &fileSyncServerImpl{})
	fmt.Println("[libsyncreve] GRPCService started port==", port)
	utils.IfPanic(grpcServer.Serve(lis))
}

func StopGRPCService() {
	grpcServer.Stop()
}
