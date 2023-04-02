package filesync

import (
	"errors"
	"fmt"
	"github.com/imroc/req/v3"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
	"os"
)

var httpClient = req.C()

func init() {
	httpClient.DisableAutoDecode()
}
func DoDownload(taskInfo FileDownloadQueueTaskData, callback req.DownloadCallback) error {

	filePath := taskInfo.SavePath + "/" + taskInfo.FileName
	fmt.Println("[libsyncreve] filesync.DoDownload filePath ==", filePath)

	if utils.FileExist(filePath) {
		fmt.Println("[libsyncreve] filesync.DoDownload (error) err == file exist")
		return errors.New("file exist")
	}
	fmt.Println("[libsyncreve] filesync.DoDownload (start) url ==", taskInfo.URL)
	tempFilePath := filePath + ".syncing"
	if httpClient.Headers == nil {
		httpClient.Headers = make(map[string][]string)
	}
	httpClient.Headers.Set("cookie", taskInfo.Cookie)
	_, err := req.R().SetContext(taskInfo.Context).SetOutputFile(tempFilePath).SetDownloadCallback(callback).Get(taskInfo.URL)
	if err != nil {
		fmt.Println("[libsyncreve] filesync.DoDownload (Error) Error ==", err)
		return err
	}
	err = os.Rename(tempFilePath, filePath)
	if err != nil {
		fmt.Println("[libsyncreve] filesync.DoDownload Rename (Error) Error ==", err)
		return err
	}
	return nil
}
