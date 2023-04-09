package utils

import (
	"context"
	"fmt"
	"io"
	"net/http"
	"os"
	"time"
)

type FileDownloadCallback func(current int64, total int64)

func DownloadFile(ctx context.Context, filepath string, url string, cookie string, callback FileDownloadCallback, callbackUpdateTimeCount time.Duration) error {
	out, err := os.Create(filepath)
	if err != nil {
		return err
	}
	defer func() {
		_ = out.Close()
	}()

	// Create the request
	c := http.Client{
		Timeout: 0,
	}
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return err
	}

	req.Header.Set("cookie", cookie)

	var rangeSize int64 = 0
	// Set headers to enable resuming download from a partial file
	if stat, err := os.Stat(filepath); err == nil {
		rangeSize = stat.Size()
		req.Header.Set("Range", fmt.Sprintf("bytes=%d-", stat.Size()))
	}

	// Start the download
	resp, err := c.Do(req)
	if err != nil {
		return err
	}
	defer func() {
		_ = resp.Body.Close()
	}()

	// Check the server response
	if resp.StatusCode != http.StatusOK && resp.StatusCode != http.StatusPartialContent {
		return fmt.Errorf("bad status: %s", resp.Status)
	}
	// Create the progress reader
	progress := &ProgressReader{Ctx: ctx, Reader: resp.Body, Total: resp.ContentLength, Callback: callback, CallbackUpdateTimeCount: callbackUpdateTimeCount, Current: rangeSize}

	// Start the download
	_, err = io.Copy(out, progress)
	if err != nil {
		return err
	}

	return nil
}

// ProgressReader wraps an io.Reader and reports progress on each read
type ProgressReader struct {
	Ctx                     context.Context
	Reader                  io.Reader
	Total                   int64
	CallbackUpdateTimeCount time.Duration
	Callback                FileDownloadCallback
	Current                 int64
	lastCallbackUpdateTime  int64
}

func (pr *ProgressReader) Read(p []byte) (int, error) {
	if err := pr.Ctx.Err(); err != nil {
		return 0, err
	}
	n, err := pr.Reader.Read(p)
	pr.Current += int64(n)
	if pr.Callback != nil {
		if time.Now().Unix()-int64(pr.CallbackUpdateTimeCount) >= 0 {
			pr.lastCallbackUpdateTime = time.Now().Unix()
			pr.Callback(pr.Current, pr.Total)
		}
	}
	return n, err
}
