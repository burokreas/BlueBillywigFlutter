package com.bluebillywig.player

import androidx.annotation.NonNull
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class BluebillywigPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {

        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.bluebillywig.player/channel")
        channel.setMethodCallHandler(this)

        flutterPluginBinding
            .platformViewRegistry
            .registerViewFactory("com.bluebillywig.player/view", BbwVideoFactory())

    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            else -> result.notImplemented()
        }
    }

}
