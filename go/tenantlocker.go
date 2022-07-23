package isuports

import (
	"strconv"
	"sync"

	cmap "github.com/orcaman/concurrent-map/v2"
)

type TenantLocker struct {
	m cmap.ConcurrentMap[sync.RWMutex]
}

func NewTenantLocker() *TenantLocker {
	return &TenantLocker{
		m: cmap.New[sync.RWMutex](),
	}
}

func (l *TenantLocker) Lock(tenantId int64) {
	k := int64S(tenantId)
	l.m.SetIfAbsent(k, sync.RWMutex{})
	v, _ := l.m.Get(k)
	v.Lock()
}

func (l *TenantLocker) Unlock(tenantId int64) {
	k := int64S(tenantId)
	v, _ := l.m.Get(k)
	v.Unlock()
}

func (l *TenantLocker) RLock(tenantId int64) {
	k := int64S(tenantId)
	l.m.SetIfAbsent(k, sync.RWMutex{})
	v, _ := l.m.Get(k)
	v.RLock()
}

func (l *TenantLocker) RUnlock(tenantId int64) {
	k := int64S(tenantId)
	l.m.SetIfAbsent(k, sync.RWMutex{})
	v, _ := l.m.Get(k)
	v.RUnlock()
}

func int64S(i int64) string {
	return strconv.FormatInt(i, 16)
}
