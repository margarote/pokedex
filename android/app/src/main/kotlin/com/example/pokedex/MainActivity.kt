package com.example.pokedex

import android.os.Bundle
import com.google.firebase.FirebaseApp
import com.google.firebase.analytics.FirebaseAnalytics
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private var analytics: FirebaseAnalytics? = null
    private val channelName = "com.pokedex/analytics"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (FirebaseApp.getApps(this).isNotEmpty()) {
            analytics = FirebaseAnalytics.getInstance(this)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "logEvent" -> {
                        val name = call.argument<String>("name") ?: ""
                        val params = call.argument<Map<String, Any>>("params") ?: emptyMap()
                        logEvent(name, params)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun logEvent(name: String, params: Map<String, Any>) {
        analytics?.let { fa ->
            val bundle = Bundle().apply {
                params.forEach { (key, value) ->
                    when (value) {
                        is String -> putString(key, value)
                        is Int -> putInt(key, value)
                        is Long -> putLong(key, value)
                        is Double -> putDouble(key, value)
                        is Boolean -> putBoolean(key, value)
                    }
                }
            }
            fa.logEvent(name, bundle)
        }
    }
}
