package db

import (
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
)

type DownloadQueueStatusType int8

const (
	DownloadQueueStatusWaiting     DownloadQueueStatusType = 0
	DownloadQueueStatusDownloading DownloadQueueStatusType = 1
	DownloadQueueStatusDone        DownloadQueueStatusType = 2
	DownloadQueueStatusError       DownloadQueueStatusType = -1
)

type DownloadQueue struct {
	BaseData
	SavePath     string                         `json:"savePath,omitempty"`
	FileName     string                         `json:"fileName,omitempty"`
	FileID       string                         `gorm:"index" json:"fileID,omitempty"`
	WorkingUrl   string                         `json:"workingUrl,omitempty"`
	InstanceUrl  string                         `json:"instanceUrl,omitempty"`
	Cookie       string                         `json:"cookie,omitempty"`
	DownLoadType protos.DownloadInfoRequestType `gorm:"index" json:"downLoadType,omitempty"`
	TotalSize    int64                          `json:"totalSize,omitempty"`
	Status       DownloadQueueStatusType        `gorm:"index" json:"status"`
	ErrorInfo    string                         `json:"errorInfo,omitempty"`
}
