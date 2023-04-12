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

func (*fileSyncServerImpl) AddDownloadTask(ctx context.Context, r *protos.DownloadTaskRequest) (*protos.DownloadTaskResult, error) {
	fmt.Println("[libsyncreve] service.AddDownloadTask")
	id, err := filesync.AddDownloadTask(ctx, r.FileInfos, r.WorkingUrl, r.InstanceUrl, r.SavePath, r.Cookie, r.DownLoadType)
	fmt.Println("[libsyncreve] service.AddDownloadTask id==", id, "err=", err)
	return &protos.DownloadTaskResult{
		Ids: id,
	}, err
}

func (*fileSyncServerImpl) AddDownloadTasksByDirPath(ctx context.Context, r *protos.DownloadDirTaskRequest) (*protos.DownloadTaskResult, error) {
	fmt.Println("[libsyncreve] service.AddDownloadTasksByDirPath")
	if r.DownLoadType == protos.DownloadInfoRequestType_All {
		return nil, errors.New("DownloadInfoRequestType_All Not Allow")
	}
	taskIDs, err := filesync.AddDownloadTasksByDirPath(ctx, r.DirPath, r.WorkingUrl, r.InstanceUrl, r.Cookie, r.SavePath, r.DownLoadType)
	if err != nil {
		return nil, err
	}
	return &protos.DownloadTaskResult{
		Ids: taskIDs,
	}, nil
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
	fmt.Println("[libsyncreve]<fileSyncServerImpl> GetDownloadInfo info ==", info, "err ==", err)
	if err != nil {
		return nil, err
	}

	return &protos.DownLoadInfoResult{Type: r.Type, Data: info}, nil
}

func (*fileSyncServerImpl) GetDownloadInfoStream(r *protos.DownloadInfoRequest, stream protos.FileSyncService_GetDownloadInfoStreamServer) error {
	fmt.Println("[libsyncreve] service.GetDownloadInfoStream")
	var id *uuid.UUID
	updateTime := 200 * time.Millisecond
	if r.UpdateTime != nil {
		updateTime = time.Duration(*r.UpdateTime)
	}

	if r.Id != nil {
		d, err := uuid.Parse(*r.Id)
		if err != nil {
			fmt.Println("[libsyncreve] service.GetDownloadInfoStream uuid error ==", err)
			return err
		}
		id = &d
	}

	for {
		select {
		case <-time.After(updateTime):
			info, err := filesync.GetDownloadInfoJson(id, r.Type)
			fmt.Println("[libsyncreve]<fileSyncServerImpl> GetDownloadInfo info ==", info, "err ==", err)
			if info == nil {
				time.Sleep(updateTime)
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
		case <-stream.Context().Done():
			fmt.Println("[libsyncreve] GetDownloadInfoStream canceled")
			return errors.New("canceled")
		}
	}
}

func (*fileSyncServerImpl) GetDownloadCountInfo(_ context.Context, _ *protos.DownloadCountRequest) (*protos.DownloadCountResult, error) {
	wl := filesync.GetWorkingTaskLen()
	l := filesync.GetTaskLen()
	return &protos.DownloadCountResult{WorkingCount: wl, Count: l}, nil
}

func (*fileSyncServerImpl) GetDownloadCountStream(_ *protos.DownloadCountRequest, stream protos.FileSyncService_GetDownloadCountStreamServer) error {
	var lastWl int64 = 0
	var lastL int64 = 0
	for {
		select {
		case <-time.After(1 * time.Second):
			wl := filesync.GetWorkingTaskLen()
			l := filesync.GetTaskLen()
			if lastWl != wl || lastL != l {
				err := stream.Send(&protos.DownloadCountResult{WorkingCount: wl, Count: l})
				if err != nil {
					return err
				}
			}
			lastWl = wl
			lastL = l
			time.Sleep(1 * time.Second)
		case <-stream.Context().Done():
			fmt.Println("[libsyncreve] GetDownloadCountStream canceled")
			return errors.New("canceled")
		}
	}
}
