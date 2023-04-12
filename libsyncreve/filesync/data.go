package filesync

import (
	"context"
	"github.com/google/uuid"
	"github.com/xkeyC/Syncreve/libsyncreve/data/db"
	"sync"
)

var DownloadingTaskMapData = DownloadingTaskMap{}

func init() {
	DownloadingTaskMapData.dataMap = make(map[string]*DownloadingTaskMapItem)
}

type DownloadingTaskMap struct {
	dataMap map[string]*DownloadingTaskMapItem
	mutex   sync.RWMutex
}

func (m *DownloadingTaskMap) Set(id string, item *DownloadingTaskMapItem) {
	m.mutex.Lock()
	defer m.mutex.Unlock()
	m.dataMap[id] = item
}
func (m *DownloadingTaskMap) Get(id string) *DownloadingTaskMapItem {
	m.mutex.RLock()
	defer m.mutex.RUnlock()
	return m.dataMap[id]
}
func (m *DownloadingTaskMap) Del(id string) {
	m.mutex.Lock()
	defer m.mutex.Unlock()
	delete(m.dataMap, id)
}

func (m *DownloadingTaskMap) Len() int64 {
	m.mutex.RLock()
	defer m.mutex.RUnlock()
	return int64(len(m.dataMap))
}

type DownloadingTaskMapItem struct {
	CancelFunc     context.CancelFunc
	DownloadedSize int64
}

type FileDownloadingInfoMap struct {
	InfoMap    map[uuid.UUID]FileDownloadingInfo `json:"infoMap"`
	QueueLen   int64                             `json:"queueLen"`
	WorkingLen int64                             `json:"workingLen"`
}
type FileDownloadingInfo struct {
	*db.DownloadQueue
	DownloadedSize int64 `json:"downloadedSize"`
}
