package filesync

import (
	"context"
	"errors"
	"fmt"
	"github.com/imroc/req/v3"
	"github.com/xkeyC/Syncreve/libsyncreve/cloudreve"
	"github.com/xkeyC/Syncreve/libsyncreve/utils"
	"os"
	"strings"
)

func DoDownload(taskInfo *FileDownloadQueueTaskData, callback req.DownloadCallback) error {
	httpClient := req.C()
	httpClient.DisableAutoDecode()
	cloudreveClient := cloudreve.NewClient(taskInfo.WorkingUrl, taskInfo.InstanceUrl, taskInfo.Cookie)
	filePath := taskInfo.SavePath + "/" + taskInfo.FileName
	fmt.Println("[libsyncreve] filesync.DoDownload filePath ==", filePath)

	if utils.FileExist(filePath) {
		fmt.Println("[libsyncreve] filesync.DoDownload (error) err == file exist")
		return errors.New("file exist")
	}

	downloadUrl, err := cloudreveClient.GetFileDownloadUrl(taskInfo.Context, taskInfo.FileID)
	if err != nil {
		return err
	}

	if taskInfo.WorkingUrl != taskInfo.InstanceUrl && strings.HasPrefix(downloadUrl, taskInfo.InstanceUrl) {
		downloadUrl = strings.Replace(downloadUrl, taskInfo.InstanceUrl, taskInfo.WorkingUrl, 1)
	}

	fmt.Println("[libsyncreve] filesync.DoDownload (start) url ==", downloadUrl)
	tempFilePath := filePath + ".syncing"
	if httpClient.Headers == nil {
		httpClient.Headers = make(map[string][]string)
	}
	httpClient.Headers.Set("cookie", taskInfo.Cookie)
	_, err = req.R().SetOutputFile(tempFilePath).SetDownloadCallback(callback).SetContext(taskInfo.Context).Get(downloadUrl)
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

func RecursionPathFiles(ctx context.Context, c *cloudreve.Client, path string, fileTreeMap map[string]*cloudreve.DirectoryResult) error {
	directoryResult, err := c.Dir(ctx, path)
	if err != nil {
		return err
	}
	for _, fileObject := range directoryResult.Data.Objects {
		fileTreeMap[directoryResult.Path] = directoryResult
		if fileObject.Type == "dir" {
			newPathName := ""
			if strings.HasSuffix(path, "/") {
				newPathName = path + fileObject.Name
			} else {
				newPathName = path + "/" + fileObject.Name
			}
			err := RecursionPathFiles(ctx, c, newPathName, fileTreeMap)
			if err != nil {
				return err
			}
		}
	}
	return nil
}
