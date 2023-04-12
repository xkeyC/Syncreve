package filesync

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/google/uuid"
	"github.com/xkeyC/Syncreve/libsyncreve/cloudreve"
	"github.com/xkeyC/Syncreve/libsyncreve/data/db"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
	"os"
	"strings"
)

func AddDownloadTask(ctx context.Context, infos []*protos.DownloadTaskRequestFileInfo, workingUrl string, instanceUrl string, savePath string, cookie string, downLoadType protos.DownloadInfoRequestType) ([]string, error) {
	var ids []string
	for _, i := range infos {
		queueData := db.DownloadQueue{
			SavePath:     savePath,
			FileName:     i.FileName,
			FileID:       i.FileID,
			WorkingUrl:   workingUrl,
			InstanceUrl:  instanceUrl,
			Cookie:       cookie,
			DownLoadType: downLoadType,
			TotalSize:    0,
			Status:       db.DownloadQueueStatusWaiting,
			ErrorInfo:    "",
		}
		err := db.DB.WithContext(ctx).Save(&queueData).Error
		if err != nil {
			return nil, err
		}
		ids = append(ids, queueData.ID.String())
	}
	return ids, UpdateWorkingTask()
}

func AddDownloadTasksByDirPath(ctx context.Context, dirPath string, workingUrl string, instanceUrl string, cookie string, savePath string, downLoadType protos.DownloadInfoRequestType) ([]string, error) {
	if downLoadType == protos.DownloadInfoRequestType_Temp {
		return nil, errors.New("can't ues temp type to download dir")
	}
	c := cloudreve.NewClient(workingUrl, instanceUrl, cookie)
	fileTreeMap := make(map[string]*cloudreve.DirectoryResult)
	err := RecursionPathFiles(ctx, c, dirPath, fileTreeMap)
	if err != nil {
		return nil, err
	}

	var taskIDs []string
	dirPathSplit := strings.Split(dirPath, "/")
	dirPathName := dirPathSplit[len(dirPathSplit)-1]
	for path, directoryResult := range fileTreeMap {
		rPath, err := utils.GetFileSaveRelativePath(path, dirPath)
		if err != nil {
			return nil, err
		}
		fileSavePath := savePath + "/" + dirPathName + "/" + rPath
		err = os.MkdirAll(fileSavePath, os.ModePerm)
		if err != nil {
			return nil, err
		}
		for _, fileObject := range directoryResult.Data.Objects {
			if fileObject.Type == "file" {
				var fileInfo []*protos.DownloadTaskRequestFileInfo
				fileInfo = append(fileInfo, &protos.DownloadTaskRequestFileInfo{
					FileID:   fileObject.Id,
					FileName: fileObject.Name,
				})
				taskID, err := AddDownloadTask(ctx, fileInfo, workingUrl, instanceUrl, fileSavePath, cookie, downLoadType)
				if err != nil {
					fmt.Println("[libsyncreve] AddDownloadTasksByDirPath Task Error ==", err)
					continue
				}
				fmt.Println("[libsyncreve] AddDownloadTasksByDirPath Task ID ==", taskID)
				taskIDs = append(taskIDs, taskID[0])
			}
		}
	}
	return taskIDs, nil
}

func CancelDownloadTask(id uuid.UUID) error {
	task := DownloadingTaskMapData.Get(id.String())
	if task != nil {
		task.CancelFunc()
		fmt.Println("[libsyncreve] filesync.CancelDownloadTask id ==", id)
	} else {
		fmt.Println("[libsyncreve] filesync.CancelDownloadTask error ==", "task not found")
		return errors.New("task not found")
	}
	return nil
}
func GetTaskData(id uuid.UUID) (*db.DownloadQueue, error) {
	var queueInfo db.DownloadQueue
	return &queueInfo, db.DB.Find(&queueInfo, "id =?", id).Error
}

func GetTaskLen() int64 {
	var size int64
	err := db.DB.Model(db.DownloadQueue{}).Where("down_load_type = ? AND status = ?", protos.DownloadInfoRequestType_Queue, db.DownloadQueueStatusWaiting).Count(&size).Error
	if err != nil {
		return 0
	}
	return size
}

func GetWorkingTaskLen() int64 {
	return DownloadingTaskMapData.Len()
}
func UpdateWorkingTask() error {
	/// download Temp First
	var tempQueueItems []db.DownloadQueue
	err := db.DB.Find(&tempQueueItems, "down_load_type = ? AND status = ?", protos.DownloadInfoRequestType_Temp, db.DownloadQueueStatusWaiting).Error
	if err != nil {
		return err
	}
	for _, queueInfo := range tempQueueItems {
		err := db.DB.Model(queueInfo).Update("status", db.DownloadQueueStatusDownloading).Error
		if err != nil {
			return err
		}
		go downloadAndListen(queueInfo.ID)
		continue
	}

	/// check downloading count
	var downloadingCount int64
	err = db.DB.Model(&db.DownloadQueue{}).Where("status = ?", db.DownloadQueueStatusDownloading).Count(&downloadingCount).Error
	if err != nil {
		return err
	}
	/// queue busy, skip download
	if downloadingCount >= MaxWorkingTaskNumber {
		return nil
	}

	/// then check download Queue
	var queueItems []db.DownloadQueue
	err = db.DB.Find(&queueItems, "down_load_type = ? AND status = ?", protos.DownloadInfoRequestType_Queue, db.DownloadQueueStatusWaiting).Error
	if err != nil {
		fmt.Println("Find queueItems Error")
		return err
	}

	for _, queueInfo := range queueItems {
		if downloadingCount >= MaxWorkingTaskNumber {
			return nil
		}
		downloadingCount++
		go downloadAndListen(queueInfo.ID)
	}
	return nil
}

func GetDownloadInfoJson(id *uuid.UUID, t protos.DownloadInfoRequestType) ([]byte, error) {
	var info FileDownloadingInfoMap
	if id != nil {
		taskInfo, err := GetTaskData(*id)
		if err != nil {
			return nil, err
		}
		newMap := make(map[uuid.UUID]FileDownloadingInfo)
		var downloadedSize int64 = 0
		fmt.Println("[libsyncreve] GetDownloadInfoJson downloadingTaskMap.Load")
		downloadingData := DownloadingTaskMapData.Get(id.String())
		if downloadingData != nil {
			downloadedSize = downloadingData.DownloadedSize
		} else {
			fmt.Println("[libsyncreve] GetDownloadInfoJson  downloadingTaskMap.Load error")
		}
		fmt.Println("[libsyncreve] GetDownloadInfoJson  downloadedSize == ", downloadedSize)
		newMap[taskInfo.ID] = FileDownloadingInfo{
			taskInfo, downloadedSize,
		}
		info = FileDownloadingInfoMap{
			InfoMap:    newMap,
			QueueLen:   GetTaskLen(),
			WorkingLen: GetWorkingTaskLen(),
		}
	} else {
		var queues []db.DownloadQueue
		var err error
		newMap := make(map[uuid.UUID]FileDownloadingInfo)
		if t == protos.DownloadInfoRequestType_All {
			err = db.DB.Find(&queues).Error
		} else {
			err = db.DB.Find(&queues, "down_load_type = ?", t).Error
		}

		if err == nil {
			for _, taskInfo := range queues {
				var downloadedSize int64 = 0
				downloadingData := DownloadingTaskMapData.Get(taskInfo.ID.String())
				if downloadingData != nil {
					downloadedSize = downloadingData.DownloadedSize
				}
				newMap[taskInfo.ID] = FileDownloadingInfo{
					&taskInfo, downloadedSize,
				}
			}
		}

		info = FileDownloadingInfoMap{
			InfoMap:    newMap,
			QueueLen:   GetTaskLen(),
			WorkingLen: GetWorkingTaskLen(),
		}
	}
	bytes, err := json.Marshal(&info)
	return bytes, err
}

func downloadAndListen(k uuid.UUID) {
	taskInfo, err := GetTaskData(k)
	if taskInfo == nil || err != nil {
		fmt.Println("downloadAndListen Error:", err)
		return
	}
	ctx, cancelFunc := context.WithCancel(context.Background())
	DownloadingTaskMapData.Set(k.String(), &DownloadingTaskMapItem{
		cancelFunc, 0,
	})
	if err := updateDownloadInfo(k, taskInfo, nil, nil, db.DownloadQueueStatusDownloading, ""); err != nil {
		fmt.Println("[libsyncreve] downloadAndListen updateDownloadInfo(Init) Error", err)
		return
	}
	err = DoDownload(ctx, taskInfo, func(current int64, total int64) {
		_ = updateDownloadInfo(k, taskInfo, &current, &total, db.DownloadQueueStatusDownloading, "")
	})

	// download complete remove Queue
	fmt.Println("[libsyncreve] filesync.downloadAndListen complete,err ==", err)

	if err != nil {
		_ = updateDownloadInfo(k, taskInfo, nil, nil, db.DownloadQueueStatusError, err.Error())
	} else {
		_ = updateDownloadInfo(k, taskInfo, nil, nil, db.DownloadQueueStatusDone, "")
	}
	go func() {
		_ = UpdateWorkingTask()
	}()
}

func updateDownloadInfo(k uuid.UUID, taskInfo *db.DownloadQueue, downloadedSize *int64, totalSize *int64, status db.DownloadQueueStatusType, errorInfo string) error {
	//fmt.Println("[libsyncreve] filesync.updateDownloadInfo ID == ", taskInfo.ID, "Status==", taskInfo.Status, "errorInfo==", errorInfo)

	// remove working map when done or error
	if status == db.DownloadQueueStatusDone || status == db.DownloadQueueStatusError {
		DownloadingTaskMapData.Del(k.String())
	}

	// update download status
	if taskInfo.Status != status {
		if taskInfo.Status == db.DownloadQueueStatusDone || taskInfo.Status == db.DownloadQueueStatusError {
			// skip
		} else {
			if err := db.DB.Model(&taskInfo).Update("status", status).Error; err != nil {
				return err
			}
		}
	}

	// update TotalSize
	if totalSize != nil {
		if taskInfo.TotalSize != *totalSize {
			if err := db.DB.Model(&taskInfo).Update("total_size", *totalSize).Error; err != nil {
				return err
			}
		}
	}
	// update downloadedSize
	if downloadedSize != nil {
		v := DownloadingTaskMapData.Get(k.String())
		if v != nil {
			item := *v
			if v.DownloadedSize != *downloadedSize {
				item.DownloadedSize = *downloadedSize
				DownloadingTaskMapData.Set(k.String(), &item)
			}
		} else {
			fmt.Println("[libsyncreve] updateDownloadInfo  downloadingTaskMap.Load error")
		}
	}

	// update error
	if errorInfo != "" {
		if err := db.DB.Model(&taskInfo).Update("error_info", errorInfo).Error; err != nil {
			return err
		}
	}
	return nil
}
