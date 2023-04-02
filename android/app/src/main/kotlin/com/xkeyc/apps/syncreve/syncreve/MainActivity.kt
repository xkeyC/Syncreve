package com.xkeyc.apps.syncreve.syncreve

import android.Manifest
import android.content.Intent
import android.os.Build
import androidx.activity.result.contract.ActivityResultContracts
import com.xkeyc.apps.syncreve.syncreve.service.SyncreveService
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

    companion object {
        const val CHANNEL_NAME = "Syncreve/ServiceChannel"
    }

    private var launchServiceResult: MethodChannel.Result? = null
    private var launchServicePath: String? = null

    private val requestPermissionLauncher = registerForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { _: Boolean ->
        launchServiceResult?.success("ok")
        launchServiceResult = null
        startService(launchServicePath)
        launchServicePath = null
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        setupFlutterChannel(flutterEngine)
    }

    private fun setupFlutterChannel(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_NAME
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startService" -> {
                    try {
                        val confPath = call.argument<String>("confPath")
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                            requestPermissionLauncher.launch(
                                Manifest.permission.POST_NOTIFICATIONS
                            )
                            launchServiceResult = result
                            launchServicePath = confPath
                            return@setMethodCallHandler
                        }
                        startService(confPath)
                        result.success("ok")
                    } catch (e: Error) {
                        result.error("500", "startServiceError:$e", null)
                    }
                }
                "stopService" -> {
                    try {
                        stopService()
                        result.success("ok")
                    } catch (e: Error) {
                        result.error("500", "startServiceError:$e", null)
                    }
                }
            }
        }
    }

    private fun startService(confPath: String?) {
        val intent = Intent(applicationContext, SyncreveService::class.java)
        intent.putExtra("confPath", confPath)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            applicationContext.startForegroundService(intent)
        } else {
            applicationContext.startService(intent)
        }
    }

    private fun stopService() {
        val intent = Intent(this, SyncreveService::class.java)
        stopService(intent)
    }
}
