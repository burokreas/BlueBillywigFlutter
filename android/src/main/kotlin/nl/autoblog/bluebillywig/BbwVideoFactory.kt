package nl.autoblog.bluebillywig

import android.content.Context
import android.view.View
import androidx.annotation.IdRes
import com.bluebillywig.bbnativeplayersdk.BBNativePlayerView
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class BbwVideoFactory(private val methodChannel: MethodChannel) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    private lateinit var videoview: BbwVideo

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        videoview = BbwVideo(context, creationParams)

        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "pause" -> {
                    if (videoview != null) {
                        videoview.pauseVideo()
                    }
                    result.success(null)
                }
            }
        }



        return videoview
    }
}
