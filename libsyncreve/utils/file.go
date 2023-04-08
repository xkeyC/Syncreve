package utils

import (
	"errors"
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
// remotePath = /aaa/bbb
// GetFileSaveRelativePath return  /cc
// and
// filePath = /aaa/bbb/ccc
// remotePath = /aaa/bb
// GetFileSaveRelativePath return  error (path error)
func GetFileSaveRelativePath(filePath string, remotePath string) (string, error) {
	if strings.HasSuffix(filePath, "/") {
		filePath = filePath + "/"
	}
	if strings.HasSuffix(remotePath, "/") {
		remotePath += remotePath + "/"
	}

	if strings.Contains(remotePath, filePath) {
		relativePath := strings.Replace(filePath, filePath, remotePath, 1)
		relativePath, _ = strings.CutSuffix(relativePath, "/")
		return relativePath, nil
	}
	return "", errors.New("filePath error")
}
