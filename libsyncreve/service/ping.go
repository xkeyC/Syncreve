package service

import (
	"context"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type pingServerImpl struct {
	protos.UnimplementedPingServiceServer
}

func (i *pingServerImpl) PingServer(context.Context, *protos.PingRequest) (*protos.PingResult, error) {
	return nil, status.Errorf(codes.Unimplemented, "method PingServer not implemented")
}
