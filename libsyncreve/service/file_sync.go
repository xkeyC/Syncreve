package service

import (
	"context"
	"errors"
	"fmt"
	"github.com/google/uuid"
	"github.com/xkeyC/Syncreve/libsyncreve/filesync"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
	"time"
)

type fileSyncServerImpl struct {
	protos.UnimplementedFileSyncServiceServer
}

func (*fileSyncServerImpl) AddDownloadTask(_ context.Context, req *protos.DownloadTaskRequest) (*protos.DownloadTaskResult, error) {
	fmt.Println("[libsyncreve] service.AddDownloadTask")
	if req.DownLoadType == protos.DownloadInfoRequestType_All {
		return nil, errors.New("DownloadInfoRequestType_All Not Allow")
	}
	id, err := filesync.AddDownloadTask(req.Url, req.SavePath, req.FileName, req.Cookie, req.DownLoadType)
	fmt.Println("[libsyncreve] service.AddDownloadTask id==", id, "err=", err)
	return &protos.DownloadTaskResult{
		Id: id.String(),
	}, err
}
func (*fileSyncServerImpl) GetDownloadInfoStream(req *protos.DownloadInfoRequest, stream protos.FileSyncService_GetDownloadInfoStreamServer) error {
	fmt.Println("[libsyncreve] service.GetDownloadInfoStream")
	var id *uuid.UUID

	if req.Id != nil {
		d, err := uuid.Parse(*req.Id)
		if err != nil {
			fmt.Println("[libsyncreve] service.GetDownloadInfoStream uuid error ==", err)
			return err
		}
		id = &d
	}

	for {
		info, err := filesync.GetDownloadInfoJson(id, req.Type)
		if info == nil {
			time.Sleep(1 * time.Second)
			continue
		}
		if err != nil {
			fmt.Println("[libsyncreve] service.GetDownloadInfoStream GetDownloadInfoJson error ==", err)
			return err
		}
		err = stream.Send(&protos.DownLoadInfoResult{
			Type: req.Type,
			Data: info,
		})
		if err != nil {
			fmt.Println("[libsyncreve] service.GetDownloadInfoStream stream.Send error ==", err)
			return err
		}
		time.Sleep(1 * time.Second)
	}

}
