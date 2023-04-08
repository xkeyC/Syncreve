package utils

import (
	"errors"
	"fmt"
	"os"
	"strings"
)

func FileExist(path string) bool {
	if _, err := os.Stat(path); errors.Is(err, os.ErrNotExist) {
		return false
	}
	return true
}

// GetFileSaveRelativePath
// filePath = /aaa/bbb/ccc
// sourcePath = /aaa/bbb
// GetFileSaveRelativePath return  /cc
// and
// filePath = /aaa/bbb/ccc
// sourcePath = /aaa/bb
// GetFileSaveRelativePath return  error (path error)
func GetFileSaveRelativePath(filePath string, sourcePath string) (string, error) {

	fmt.Println("[libsyncreve] GetFileSaveRelativePath filePath:", filePath, "sourcePath:", sourcePath)

	if !strings.HasSuffix(filePath, "/") {
		filePath = filePath + "/"
	}
	if !strings.HasSuffix(sourcePath, "/") {
		sourcePath = sourcePath + "/"
	}

	fmt.Println("[libsyncreve] GetFileSaveRelativePath Suffix filePath:", filePath, "sourcePath:", sourcePath)

	if strings.Contains(filePath, sourcePath) {
		relativePath := strings.Replace(filePath, sourcePath, "/", 1)
		relativePath, _ = strings.CutSuffix(relativePath, "/")
		return relativePath, nil
	}
	return "", errors.New("GetFileSaveRelativePath filePath error")
}
