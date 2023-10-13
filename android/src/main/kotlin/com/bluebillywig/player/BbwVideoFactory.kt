package com.bluebillywig.player

import android.content.Context
import android.view.View
import androidx.annotation.IdRes
import com.bluebillywig.bbnativeplayersdk.BBNativePlayerView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class BbwVideoFactory() : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private lateinit var videoview: BbwVideo

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        videoview = BbwVideo(context, creationParams)

        return videoview
    }
}
