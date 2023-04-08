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
	resp, err := c.reqClient.R().SetSuccessResult(&result).SetErrorResult(&result).SetContext(ctx).Get(c.WorkingUrl + "/api/v3/directory" + uPath)
	if err != nil {
		fmt.Println("[libsyncreve] cloudreveApi (", c.WorkingUrl, ") Dir ", path, "Error:", err, "Result:", result)
		return nil, err
	}
	if resp.IsSuccessState() && result.IsSuccess() {
		result.Path = path
		return &result, err
	}
	fmt.Println("[libsyncreve] cloudreveApi (", c.WorkingUrl, ") Dir:", path, "uPath:", uPath, "Error:", err, "Result:", result)
	return nil, errors.New(result.Msg)
}
