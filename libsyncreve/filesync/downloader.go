package filesync

import (
	"errors"
	"github.com/imroc/req/v3"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
	"os"
)

var httpClient = req.C()

func DoDownload(taskInfo FileDownloadQueueTaskData, callback req.DownloadCallback) error {
	filePath := taskInfo.SavePath + "/" + taskInfo.FileName

	if utils.FileExist(filePath) {
		return errors.New("file exist")
	}

	tempFilePath := filePath + ".syncing"
	httpClient.Headers.Set("cookie", taskInfo.Cookie)
	_, err := req.R().SetContext(taskInfo.Context).SetOutputFile(tempFilePath).SetDownloadCallback(callback).Get(taskInfo.URL)
	if err != nil {
		return err
	}
	err = os.Rename(tempFilePath, filePath)
	if err != nil {
		return err
	}
	return nil
}
