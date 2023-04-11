package filesync

import (
	"context"
	"github.com/xkeyC/Syncreve/libsyncreve/data/db"
	"github.com/xkeyC/Syncreve/libsyncreve/protos"
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
			Status:       db.DownloadQueueStatusWaiting,
			ErrorInfo:    "",
		}
		err := db.DB.WithContext(ctx).Create(&queueData).Error
		if err != nil {
			return nil, err
		}
		ids = append(ids, queueData.ID.String())
	}
	go UpdateWorkingTask()
	return ids, nil
}

//	func AddDownloadTasksByDirPath(ctx context.Context, dirPath string, workingUrl string, instanceUrl string, cookie string, savePath string, downLoadType protos.DownloadInfoRequestType) ([]string, error) {
//		if downLoadType == protos.DownloadInfoRequestType_Temp {
//			return nil, errors.New("can't ues temp type to download dir")
//		}
//		c := cloudreve.NewClient(workingUrl, instanceUrl, cookie)
//		fileTreeMap := make(map[string]*cloudreve.DirectoryResult)
//		err := RecursionPathFiles(ctx, c, dirPath, fileTreeMap)
//		if err != nil {
//			return nil, err
//		}
//
//		var taskIDs []string
//		dirPathSplit := strings.Split(dirPath, "/")
//		dirPathName := dirPathSplit[len(dirPathSplit)-1]
//		for path, directoryResult := range fileTreeMap {
//			rPath, err := utils.GetFileSaveRelativePath(path, dirPath)
//			if err != nil {
//				return nil, err
//			}
//			fileSavePath := savePath + "/" + dirPathName + "/" + rPath
//			err = os.MkdirAll(fileSavePath, os.ModePerm)
//			if err != nil {
//				return nil, err
//			}
//			for _, fileObject := range directoryResult.Data.Objects {
//				if fileObject.Type == "file" {
//					var fileInfo []*protos.DownloadTaskRequestFileInfo
//					fileInfo = append(fileInfo, &protos.DownloadTaskRequestFileInfo{
//						FileID:   fileObject.Id,
//						FileName: fileObject.Name,
//					})
//					taskID, err := AddDownloadTask(fileInfo, workingUrl, instanceUrl, fileSavePath, cookie, downLoadType)
//					if err != nil {
//						fmt.Println("[libsyncreve] AddDownloadTasksByDirPath Task Error ==", err)
//						continue
//					}
//					fmt.Println("[libsyncreve] AddDownloadTasksByDirPath Task ID ==", taskID)
//					taskIDs = append(taskIDs, taskID[0])
//				}
//			}
//		}
//		return taskIDs, nil
//	}
//
//	func CancelDownloadTask(id uuid.UUID) error {
//		fileDownloadQueues.mutex.Lock()
//		defer fileDownloadQueues.mutex.Unlock()
//		task := fileDownloadQueues.queuesMap[id]
//		if task != nil {
//			task.CancelFunc()
//			fmt.Println("[libsyncreve] filesync.CancelDownloadTask id ==", id)
//		} else {
//			fmt.Println("[libsyncreve] filesync.CancelDownloadTask error ==", "task not found")
//		}
//		return nil
//	}
//
//	func GetTaskData(id uuid.UUID) *FileDownloadQueueTaskData {
//		fileDownloadQueues.mutex.RLock()
//		defer fileDownloadQueues.mutex.RUnlock()
//		return fileDownloadQueues.queuesMap[id]
//	}
//
//	func GetTaskLen() int64 {
//		fileDownloadQueues.mutex.RLock()
//		defer fileDownloadQueues.mutex.RUnlock()
//		return fileDownloadQueues.queueLen
//	}
//
//	func GetWorkingTaskLen() int64 {
//		fileDownloadQueues.mutex.RLock()
//		defer fileDownloadQueues.mutex.RUnlock()
//		return fileDownloadQueues.workingLen
//	}
func UpdateWorkingTask() {
	var queueItems []db.DownloadQueue

	db.DB.Where(&queueItems, "DownLoadType")
	//fileDownloadQueues.mutex.Lock()
	//defer fileDownloadQueues.mutex.Unlock()
	//for k := range fileDownloadQueues.queuesMap {
	//	queueInfo := fileDownloadQueues.queuesMap[k]
	//	if queueInfo.Status == FileDownloadQueueStatusDownloading {
	//		continue
	//	}
	//
	//	if queueInfo.DownLoadType == protos.DownloadInfoRequestType_Temp {
	//		queueInfo.Status = FileDownloadQueueStatusDownloading
	//		go downloadAndListen(k)
	//		fileDownloadQueues.workingLen++
	//		continue
	//	}
	//
	//	if fileDownloadQueues.workingLen >= MaxWorkingTaskNumber {
	//		return
	//	}
	//
	//	queueInfo.Status = FileDownloadQueueStatusDownloading
	//	go downloadAndListen(k)
	//	fileDownloadQueues.workingLen++
	//}
}

//
//func GetDownloadInfoJson(id *uuid.UUID, t protos.DownloadInfoRequestType) ([]byte, error) {
//	fileDownloadingInfo.Mutex.RLock()
//	defer fileDownloadingInfo.Mutex.RUnlock()
//	var info FileDownloadingInfo
//	if id != nil {
//		data := fileDownloadingInfo.InfoMap[*id]
//		if data == nil {
//			return nil, nil
//		}
//		newMap := map[uuid.UUID]*FileDownloadingInfoItemData{}
//		newMap[*id] = data
//		info = FileDownloadingInfo{
//			InfoMap:    newMap,
//			QueueLen:   GetTaskLen(),
//			WorkingLen: GetWorkingTaskLen(),
//		}
//	} else {
//		newMap := map[uuid.UUID]*FileDownloadingInfoItemData{}
//		for u, data := range fileDownloadingInfo.InfoMap {
//			if t == protos.DownloadInfoRequestType_All || data.DownLoadType == t {
//				newMap[u] = data
//			}
//		}
//		if len(newMap) == 0 {
//			return nil, nil
//		}
//		info = FileDownloadingInfo{
//			InfoMap:    newMap,
//			QueueLen:   GetTaskLen(),
//			WorkingLen: GetWorkingTaskLen(),
//		}
//	}
//	bytes, err := json.Marshal(&info)
//	return bytes, err
//}
//
//func addTaskToList(queueData *FileDownloadQueueTaskData) error {
//	fileDownloadQueues.mutex.Lock()
//	defer fileDownloadQueues.mutex.Unlock()
//	if fileDownloadQueues.queuesMap[queueData.ID] != nil {
//		return errors.New("task ID already used")
//	}
//	fileDownloadQueues.queuesMap[queueData.ID] = queueData
//	fileDownloadQueues.queueLen++
//	go UpdateWorkingTask()
//	go updateDownloadInfo(queueData.ID, *queueData, nil, nil, FileDownloadQueueStatusWaiting, "")
//	return nil
//}
//
//func downloadAndListen(k uuid.UUID) {
//	taskInfo := GetTaskData(k)
//	if taskInfo == nil {
//		return
//	}
//	go updateDownloadInfo(k, *taskInfo, nil, nil, FileDownloadQueueStatusDownloading, "")
//	err := DoDownload(taskInfo, func(current int64, total int64) {
//		go updateDownloadInfo(k, *taskInfo, &current, &total, FileDownloadQueueStatusDownloading, "")
//	})
//
//	// download complete remove Queue
//	fmt.Println("[libsyncreve] filesync.downloadAndListen complete,err ==", err)
//	fileDownloadQueues.mutex.Lock()
//	defer fileDownloadQueues.mutex.Unlock()
//	delete(fileDownloadQueues.queuesMap, k)
//	fileDownloadQueues.workingLen--
//	fileDownloadQueues.queueLen--
//	fmt.Println("[libsyncreve] filesync.downloadAndListen fileDownloadQueues mutex updated")
//
//	if err != nil {
//		go updateDownloadInfo(k, *taskInfo, nil, nil, FileDownloadQueueStatusError, err.Error())
//	} else {
//		go updateDownloadInfo(k, *taskInfo, nil, nil, FileDownloadQueueStatusDone, "")
//	}
//	go UpdateWorkingTask()
//}
//
//func updateDownloadInfo(k uuid.UUID, taskInfo FileDownloadQueueTaskData, downloadedSize *int64, totalSize *int64, status FileDownloadQueueStatusType, errorInfo string) {
//	//fmt.Println("[libsyncreve] filesync.updateDownloadInfo ID == ", taskInfo.ID, "Status==", taskInfo.Status, "errorInfo==", errorInfo)
//	// update download info
//	fileDownloadingInfo.Mutex.Lock()
//	defer fileDownloadingInfo.Mutex.Unlock()
//
//	if fileDownloadingInfo.InfoMap[k] == nil {
//		// first download create new
//		downloadInfo := &FileDownloadingInfoItemData{
//			ID:           taskInfo.ID,
//			WorkingUrl:   taskInfo.WorkingUrl,
//			FileID:       taskInfo.FileID,
//			SavePath:     taskInfo.SavePath,
//			FileName:     taskInfo.FileName,
//			Cookie:       taskInfo.Cookie,
//			DownLoadType: taskInfo.DownLoadType,
//			Status:       status,
//			ErrorInfo:    errorInfo,
//		}
//		if downloadedSize != nil {
//			downloadInfo.DownloadedSize = *downloadedSize
//		}
//		if totalSize != nil {
//			downloadInfo.ContentLength = *totalSize
//		}
//
//		fileDownloadingInfo.InfoMap[k] = downloadInfo
//	} else {
//		// update progress only
//		downloadInfo := fileDownloadingInfo.InfoMap[k]
//		if downloadedSize != nil {
//			downloadInfo.DownloadedSize = *downloadedSize
//		}
//		if totalSize != nil {
//			downloadInfo.ContentLength = *totalSize
//		}
//		if downloadInfo.Status != FileDownloadQueueStatusDone && downloadInfo.Status != FileDownloadQueueStatusError {
//			downloadInfo.Status = status
//		}
//		downloadInfo.ErrorInfo = errorInfo
//	}
//	fileDownloadingInfo.QueueLen = GetTaskLen()
//	fileDownloadingInfo.WorkingLen = GetWorkingTaskLen()
//}
