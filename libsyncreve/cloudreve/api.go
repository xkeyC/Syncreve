package cloudreve

import (
	"context"
	"errors"
	"fmt"
	"net/url"
)

func (c *Client) Dir(ctx context.Context, path string) (*DirectoryResult, error) {
	uPath := url.QueryEscape(path)
	var result DirectoryResult
	response, err := c.reqClient.R().SetSuccessResult(&result).SetErrorResult(&result).SetContext(ctx).Get(c.WorkingUrl + "/api/v3/directory" + uPath)
	if err != nil {
		fmt.Println("[libsyncreve] cloudreveApi (", c.WorkingUrl, ") Dir ", path, "Error:", err, "Result:", result)
		return nil, err
	}
	if response.IsSuccessState() && result.IsSuccess() {
		result.Path = path
		return &result, err
	}
	fmt.Println("[libsyncreve] cloudreveApi (", c.WorkingUrl, ") Dir:", path, "uPath:", uPath, "Error:", err, "Result:", result)
	return nil, errors.New(result.Msg)
}

func (c *Client) GetFileDownloadUrl(ctx context.Context, fileID string) (string, error) {
	var result DownloadUrlResult
	response, err := c.reqClient.R().SetSuccessResult(&result).SetErrorResult(&result).SetContext(ctx).Put(c.WorkingUrl + "/api/v3/file/download/" + fileID)
	if err != nil {
		return "", err
	}
	if response.IsSuccessState() && result.IsSuccess() {
		return result.Data, err
	}
	return "", errors.New(result.Msg)
}
