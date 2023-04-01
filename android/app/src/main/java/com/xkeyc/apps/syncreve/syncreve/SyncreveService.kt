package com.xkeyc.apps.syncreve.syncreve

import android.app.Service
import android.content.Intent
import android.os.IBinder
import libsyncreve.Libsyncreve

class SyncreveService : Service() {

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    override fun onCreate() {
        Libsyncreve.startService(39399)
        super.onCreate()
    }

    override fun onDestroy() {
        super.onDestroy()
    }

}