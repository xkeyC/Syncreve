package cloudreve

import "github.com/imroc/req/v3"

type Client struct {
	WorkingUrl string
	Cookie     string
	reqClient  *req.Client
}

func NewClient(workingUrl string, cookie string) *Client {
	reqClient := req.NewClient()
	if reqClient.Headers == nil {
		reqClient.Headers = make(map[string][]string)
	}
	reqClient.Headers.Set("cookie", cookie)
	c := Client{
		WorkingUrl: workingUrl,
		Cookie:     cookie,
		reqClient:  reqClient,
	}
	return &c
}
