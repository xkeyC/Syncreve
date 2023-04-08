package cloudreve

import "time"

type BaseResult struct {
	Code int `json:"code"`
	Data any
	Msg  string `json:"msg"`
}

func (b *BaseResult) IsSuccess() bool {
	return b.Code == 0
}

type DownloadUrlResult struct {
	BaseResult
	Data string `json:"data"`
}

type DirectoryResult struct {
	BaseResult
	Path string `json:"path"`
	Data struct {
		Parent  string `json:"parent"`
		Objects []struct {
			Id            string    `json:"id"`
			Name          string    `json:"name"`
			Path          string    `json:"path"`
			Pic           string    `json:"pic"`
			Size          int       `json:"size"`
			Type          string    `json:"type"`
			Date          time.Time `json:"date"`
			CreateDate    time.Time `json:"create_date"`
			SourceEnabled bool      `json:"source_enabled"`
		} `json:"objects"`
	}
}
