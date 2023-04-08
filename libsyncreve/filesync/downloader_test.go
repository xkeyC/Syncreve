package filesync

import (
	"context"
	"fmt"
	"github.com/xkeyC/Syncreve/libsyncreve/cloudreve"
	"testing"
)

func TestRecursionPathFiles(t *testing.T) {
	c := cloudreve.NewClient("", "")
	fileTreeMap := make(map[string]*cloudreve.DirectoryResult)
	err := RecursionPathFiles(context.Background(), c, "/", fileTreeMap)
	if err != nil {
		t.Error(err)
		return
	}
	printTreeMap(fileTreeMap)
}

func printTreeMap(m map[string]*cloudreve.DirectoryResult) {
	for s, result := range m {
		fmt.Println("PATH ===== ", s)
		fmt.Println(*result)
	}
}
