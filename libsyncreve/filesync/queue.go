package filesync

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/google/uuid"
	"github.com/imroc/req/v3"
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
	URL          string                         `json:"URL,omitempty"`
	SavePath     string                         `json:"savePath,omitempty"`
	FileName     string                         `json:"fileName,omitempty"`
	Cookie       string                         `json:"cookie,omitempty"`
	DownLoadType protos.DownloadInfoRequestType `json:"downLoadType,omitempty"`
	Status       FileDownloadQueueStatusType    `json:"status,omitempty"`
	CancelFunc   context.CancelFunc
}

type FileDownloadQueues struct {
	mutex      sync.RWMutex
	queuesMap  map[uuid.UUID]*FileDownloadQueueTaskData
	queueLen   int
	workingLen int
}

type FileDownloadingInfoItemData struct {
	ID             uuid.UUID                      `json:"ID,omitempty"`
	URL            string                         `json:"URL,omitempty"`
	SavePath       string                         `json:"savePath,omitempty"`
	FileName       string                         `json:"fileName,omitempty"`
	Cookie         string                         `json:"cookie,omitempty"`
	DownLoadType   protos.DownloadInfoRequestType `json:"downLoadType,omitempty"`
	Status         FileDownloadQueueStatusType    `json:"status,omitempty"`
	DownloadedSize int64                          `json:"downloadedSize,omitempty"`
	ContentLength  int64                          `json:"contentLength,omitempty"`
	ErrorInfo      string                         `json:"errorInfo,omitempty"`
}

var fileDownloadingInfo FileDownloadingInfo

type FileDownloadingInfo struct {
	Mutex      sync.RWMutex                               `json:"-"`
	InfoMap    map[uuid.UUID]*FileDownloadingInfoItemData `json:"infoMap,omitempty"`
	QueueLen   int                                        `json:"queueLen,omitempty"`
	WorkingLen int                                        `json:"workingLen,omitempty"`
}

func init() {
	fileDownloadQueues.queuesMap = make(map[uuid.UUID]*FileDownloadQueueTaskData)
	fileDownloadingInfo.InfoMap = make(map[uuid.UUID]*FileDownloadingInfoItemData)
}

func AddDownloadTask(url string, savePath string, fileName string, cookie string, downLoadType protos.DownloadInfoRequestType) (uuid.UUID, error) {
	id := uuid.New()
	c, cancel := context.WithCancel(context.Background())
	queueData := &FileDownloadQueueTaskData{
		ID:           id,
		Context:      c,
		CancelFunc:   cancel,
		URL:          url,
		SavePath:     savePath,
		FileName:     fileName,
		Cookie:       cookie,
		DownLoadType: downLoadType,
		Status:       FileDownloadQueueStatusWaiting,
	}
	err := addTaskToList(queueData)
	return id, err
}

func CancelDownloadTask(id uuid.UUID) error {
	fileDownloadQueues.mutex.Lock()
	defer fileDownloadQueues.mutex.Unlock()
	task := fileDownloadQueues.queuesMap[id]
	if task != nil {
		task.CancelFunc()
		fmt.Println("[libsyncreve] filesync.CancelDownloadTask id ==", id)
	} else {
		fmt.Println("[libsyncreve] filesync.CancelDownloadTask error ==", "task not found")
	}
	return nil
}

func addTaskToList(queueData *FileDownloadQueueTaskData) error {
	fileDownloadQueues.mutex.Lock()
	defer fileDownloadQueues.mutex.Unlock()
	if fileDownloadQueues.queuesMap[queueData.ID] != nil {
		return errors.New("task ID already used")
	}
	fileDownloadQueues.queuesMap[queueData.ID] = queueData
	fileDownloadQueues.queueLen++
	go UpdateWorkingTask()
	return nil
}

func GetTaskData(id uuid.UUID) *FileDownloadQueueTaskData {
	fileDownloadQueues.mutex.RLock()
	defer fileDownloadQueues.mutex.RUnlock()
	return fileDownloadQueues.queuesMap[id]
}

func GetTaskLen() int {
	fileDownloadQueues.mutex.RLock()
	defer fileDownloadQueues.mutex.RUnlock()
	return fileDownloadQueues.queueLen
}

func GetWorkingTaskLen() int {
	fileDownloadQueues.mutex.RLock()
	defer fileDownloadQueues.mutex.RUnlock()
	return fileDownloadQueues.workingLen
}

func UpdateWorkingTask() {
	fileDownloadQueues.mutex.Lock()
	defer fileDownloadQueues.mutex.Unlock()
	for k := range fileDownloadQueues.queuesMap {
		queueInfo := fileDownloadQueues.queuesMap[k]
		if queueInfo.Status == FileDownloadQueueStatusDownloading {
			continue
		}

		if queueInfo.DownLoadType == protos.DownloadInfoRequestType_Temp {
			queueInfo.Status = FileDownloadQueueStatusDownloading
			go downloadAndListen(k)
			fileDownloadQueues.workingLen++
			continue
		}

		if fileDownloadQueues.workingLen >= MaxWorkingTaskNumber {
			return
		}

		queueInfo.Status = FileDownloadQueueStatusDownloading
		go downloadAndListen(k)
		fileDownloadQueues.workingLen++
	}
}

func downloadAndListen(k uuid.UUID) {
	taskInfo := GetTaskData(k)
	if taskInfo == nil {
		return
	}
	err := DoDownload(taskInfo, func(info req.DownloadInfo) {
		if info.Response.Response == nil {
			return
		}
		go updateDownloadInfo(k, *taskInfo, &info, FileDownloadQueueStatusDownloading, "")
	})

	taskInfo.CancelFunc()
	// download complete remove Queue
	fmt.Println("[libsyncreve] filesync.downloadAndListen complete,err ==", err)
	fileDownloadQueues.mutex.Lock()
	defer fileDownloadQueues.mutex.Unlock()
	delete(fileDownloadQueues.queuesMap, k)
	fileDownloadQueues.workingLen--
	fileDownloadQueues.queueLen--
	fmt.Println("[libsyncreve] filesync.downloadAndListen fileDownloadQueues mutex updated")

	if err != nil {
		go updateDownloadInfo(k, *taskInfo, nil, FileDownloadQueueStatusError, err.Error())
	} else {
		go updateDownloadInfo(k, *taskInfo, nil, FileDownloadQueueStatusDone, "")
	}
	go UpdateWorkingTask()
}

func updateDownloadInfo(k uuid.UUID, taskInfo FileDownloadQueueTaskData, info *req.DownloadInfo, status FileDownloadQueueStatusType, errorInfo string) {
	fmt.Println("[libsyncreve] filesync.updateDownloadInfo ID == ", taskInfo.ID, "Status==", taskInfo.Status, "errorInfo==", errorInfo)
	// update download info
	fileDownloadingInfo.Mutex.Lock()
	defer fileDownloadingInfo.Mutex.Unlock()

	if fileDownloadingInfo.InfoMap[k] == nil {
		// first download create new
		downloadInfo := &FileDownloadingInfoItemData{
			ID:           taskInfo.ID,
			URL:          taskInfo.URL,
			SavePath:     taskInfo.SavePath,
			FileName:     taskInfo.FileName,
			Cookie:       taskInfo.Cookie,
			DownLoadType: taskInfo.DownLoadType,
			Status:       status,
			ErrorInfo:    errorInfo,
		}
		if info != nil {
			downloadInfo.DownloadedSize = info.DownloadedSize
			downloadInfo.ContentLength = info.Response.ContentLength
		}
		fileDownloadingInfo.InfoMap[k] = downloadInfo
	} else {
		// update progress only
		downloadInfo := fileDownloadingInfo.InfoMap[k]
		if info != nil {
			downloadInfo.DownloadedSize = info.DownloadedSize
			downloadInfo.ContentLength = info.Response.ContentLength
		}
		downloadInfo.Status = status
		downloadInfo.ErrorInfo = errorInfo
	}
	fileDownloadingInfo.QueueLen = GetTaskLen()
	fileDownloadingInfo.WorkingLen = GetWorkingTaskLen()
}

func GetDownloadInfoJson(id *uuid.UUID, t protos.DownloadInfoRequestType) ([]byte, error) {
	fileDownloadingInfo.Mutex.RLock()
	defer fileDownloadingInfo.Mutex.RUnlock()
	var info FileDownloadingInfo
	if id != nil {
		data := fileDownloadingInfo.InfoMap[*id]
		if data == nil {
			return nil, nil
		}
		newMap := map[uuid.UUID]*FileDownloadingInfoItemData{}
		newMap[*id] = data
		info = FileDownloadingInfo{
			InfoMap:    newMap,
			QueueLen:   GetTaskLen(),
			WorkingLen: GetWorkingTaskLen(),
		}
	} else {
		newMap := map[uuid.UUID]*FileDownloadingInfoItemData{}
		for u, data := range fileDownloadingInfo.InfoMap {
			if t == protos.DownloadInfoRequestType_All || data.DownLoadType == t {
				newMap[u] = data
			}
		}
		if len(newMap) == 0 {
			return nil, nil
		}
		info = FileDownloadingInfo{
			InfoMap:    newMap,
			QueueLen:   GetTaskLen(),
			WorkingLen: GetWorkingTaskLen(),
		}
	}
	bytes, err := json.Marshal(&info)
	return bytes, err
}
