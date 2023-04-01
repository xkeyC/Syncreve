package service

import (
	"context"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
)

type pingServerImpl struct {
	protos.UnimplementedPingServiceServer
}

func (i *pingServerImpl) PingServer(context.Context, *protos.PingRequest) (*protos.PingResult, error) {
	return &protos.PingResult{Pong: "pong"}, nil
}
