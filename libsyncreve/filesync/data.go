package filesync

import (
	"context"
	"github.com/google/uuid"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
	"sync"
)

var fileDownloadQueues = FileDownloadQueues{}

type FileDownloadQueueStatusType int32

const (
	FileDownloadQueueStatusWaiting     FileDownloadQueueStatusType = 0
	FileDownloadQueueStatusDownloading FileDownloadQueueStatusType = 1
	FileDownloadQueueStatusDone        FileDownloadQueueStatusType = 2
	FileDownloadQueueStatusError       FileDownloadQueueStatusType = -1
)

type FileDownloadQueueTaskData struct {
	ID           uuid.UUID                      `json:"ID,omitempty"`
	Context      context.Context                `json:"-"`
	SavePath     string                         `json:"savePath,omitempty"`
	FileName     string                         `json:"fileName,omitempty"`
	WorkingUrl   string                         `json:"workingUrl,omitempty"`
	InstanceUrl  string                         `json:"instanceUrl,omitempty"`
	FileID       string                         `json:"fileID,omitempty"`
	Cookie       string                         `json:"cookie,omitempty"`
	DownLoadType protos.DownloadInfoRequestType `json:"downLoadType,omitempty"`
	Status       FileDownloadQueueStatusType    `json:"status"`
	CancelFunc   context.CancelFunc
}

type FileDownloadQueues struct {
	mutex      sync.RWMutex
	queuesMap  map[uuid.UUID]*FileDownloadQueueTaskData
	queueLen   int64
	workingLen int64
}

type FileDownloadingInfoItemData struct {
	ID             uuid.UUID                      `json:"ID,omitempty"`
	SavePath       string                         `json:"savePath,omitempty"`
	FileName       string                         `json:"fileName,omitempty"`
	FileID         string                         `json:"fileID,omitempty"`
	WorkingUrl     string                         `json:"workingUrl,omitempty"`
	InstanceUrl    string                         `json:"instanceUrl,omitempty"`
	Cookie         string                         `json:"cookie,omitempty"`
	DownLoadType   protos.DownloadInfoRequestType `json:"downLoadType,omitempty"`
	Status         FileDownloadQueueStatusType    `json:"status"`
	DownloadedSize int64                          `json:"downloadedSize,omitempty"`
	ContentLength  int64                          `json:"contentLength,omitempty"`
	ErrorInfo      string                         `json:"errorInfo,omitempty"`
}

var fileDownloadingInfo FileDownloadingInfo

type FileDownloadingInfo struct {
	Mutex      sync.RWMutex                               `json:"-"`
	InfoMap    map[uuid.UUID]*FileDownloadingInfoItemData `json:"infoMap,omitempty"`
	QueueLen   int64                                      `json:"queueLen,omitempty"`
	WorkingLen int64                                      `json:"workingLen,omitempty"`
}

func init() {
	fileDownloadQueues.queuesMap = make(map[uuid.UUID]*FileDownloadQueueTaskData)
	fileDownloadingInfo.InfoMap = make(map[uuid.UUID]*FileDownloadingInfoItemData)
}
