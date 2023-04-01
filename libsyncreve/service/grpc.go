package service

import (
	"fmt"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
	"google.golang.org/grpc"
	"net"
)

func StartGRPCService(port int) {
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", port))
	utils.IfPanic(err)
	grpcServer := grpc.NewServer()
	protos.RegisterPingServiceServer(grpcServer, &pingServerImpl{})
	utils.IfPanic(grpcServer.Serve(lis))
}
