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

func (*fileSyncServerImpl) AddDownloadTask(_ context.Context, r *protos.DownloadTaskRequest) (*protos.DownloadTaskResult, error) {
	fmt.Println("[libsyncreve] service.AddDownloadTask")
	if r.DownLoadType == protos.DownloadInfoRequestType_All {
		return nil, errors.New("DownloadInfoRequestType_All Not Allow")
	}
	id, err := filesync.AddDownloadTask(r.Url, r.SavePath, r.FileName, r.Cookie, r.DownLoadType)
	fmt.Println("[libsyncreve] service.AddDownloadTask id==", id, "err=", err)
	return &protos.DownloadTaskResult{
		Id: id.String(),
	}, err
}

func (*fileSyncServerImpl) CancelDownloadTask(_ context.Context, r *protos.DownloadTaskCancelRequest) (*protos.DownloadTaskCancelResult, error) {
	id, err := uuid.Parse(r.Id)
	if err != nil {
		return nil, err
	}
	err = filesync.CancelDownloadTask(id)
	if err != nil {
		return nil, err
	}
	return &protos.DownloadTaskCancelResult{
		Status: "ok",
	}, nil
}

func (*fileSyncServerImpl) GetDownloadInfo(_ context.Context, r *protos.DownloadInfoRequest) (*protos.DownLoadInfoResult, error) {
	info, err := filesync.GetDownloadInfoJson(nil, r.Type)
	if err != nil {
		return nil, err
	}
	return &protos.DownLoadInfoResult{Type: r.Type, Data: info}, nil
}

func (*fileSyncServerImpl) GetDownloadInfoStream(r *protos.DownloadInfoRequest, stream protos.FileSyncService_GetDownloadInfoStreamServer) error {
	fmt.Println("[libsyncreve] service.GetDownloadInfoStream")
	var id *uuid.UUID

	if r.Id != nil {
		d, err := uuid.Parse(*r.Id)
		if err != nil {
			fmt.Println("[libsyncreve] service.GetDownloadInfoStream uuid error ==", err)
			return err
		}
		id = &d
	}

	for {
		info, err := filesync.GetDownloadInfoJson(id, r.Type)
		if info == nil {
			time.Sleep(200 * time.Millisecond)
			continue
		}
		if err != nil {
			fmt.Println("[libsyncreve] service.GetDownloadInfoStream GetDownloadInfoJson error ==", err)
			return err
		}
		err = stream.Send(&protos.DownLoadInfoResult{
			Type: r.Type,
			Data: info,
		})
		if err != nil {
			fmt.Println("[libsyncreve] service.GetDownloadInfoStream stream.Send error ==", err)
			return err
		}
		time.Sleep(200 * time.Millisecond)
	}
}
