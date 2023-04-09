package cloudreve

import "github.com/imroc/req/v3"

type Client struct {
	WorkingUrl  string
	InstanceUrl string
	Cookie      string
	reqClient   *req.Client
}

func NewClient(workingUrl string, InstanceUrl string, cookie string) *Client {
	reqClient := req.C()
	if reqClient.Headers == nil {
		reqClient.Headers = make(map[string][]string)
	}
	reqClient.Headers.Set("cookie", cookie)
	c := Client{
		WorkingUrl:  workingUrl,
		InstanceUrl: InstanceUrl,
		Cookie:      cookie,
		reqClient:   reqClient,
	}
	return &c
}
