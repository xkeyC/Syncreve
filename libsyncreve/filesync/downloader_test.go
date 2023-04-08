package filesync

import (
	"context"
	"fmt"
	"github.com/xkeyC/Syncreve/libsyncreve/cloudreve"
	"testing"
)

const (
	workingUrl  = ""
	instanceUrl = ""
	cookie      = ""
)

func TestRecursionPathFiles(t *testing.T) {
	c := cloudreve.NewClient(workingUrl, instanceUrl, cookie)
	fileTreeMap := make(map[string]*cloudreve.DirectoryResult)
	err := RecursionPathFiles(context.Background(), c, "/", fileTreeMap)
	if err != nil {
		t.Error(err)
		return
	}
	for s, result := range fileTreeMap {
		fmt.Println("PATH ===== ", s)
		fmt.Println(*result)
	}
}

func TestDoDownloadUrl(t *testing.T) {
	c := cloudreve.NewClient(workingUrl, instanceUrl, cookie)
	downloadUrl, err := c.GetFileDownloadUrl(context.Background(), "m7Yu5")
	if err != nil {
		return
	}
	t.Log(downloadUrl)
}
