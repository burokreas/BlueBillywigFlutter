package com.bluebillywig.player

import android.content.Context
import android.graphics.Color
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import com.bluebillywig.bbnativeplayersdk.BBNativePlayer
import com.bluebillywig.bbnativeplayersdk.BBNativePlayerView
import com.bluebillywig.bbnativeplayersdk.BBNativePlayerViewDelegate
import com.bluebillywig.bbnativeshared.enums.ApiMethod
import com.bluebillywig.player.R.layout.player_container
import io.flutter.plugin.platform.PlatformView

internal class BbwVideo(context: Context, creationParams: Map<String?, Any?>?) : PlatformView, BBNativePlayerViewDelegate {
    private var playerContainer: LinearLayout
    private lateinit var playerView: BBNativePlayerView

    override fun getView(): View {
        return playerContainer
    }

    override fun dispose() {
        playerView.destroy()
    }

    init {
        val inflater =
            context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        playerContainer = inflater.inflate(player_container, null, false) as LinearLayout

        val url = creationParams?.get("url")
        if (url is String) {

            // val playerOptions = mapOf("noChromeCast" to true, "allowCollapseExpand" to true)
            playerView = BBNativePlayer.createPlayerView(
                context,
                url,
                // playerOptions
            )

            playerContainer.addView(playerView)

            val width: Int = context.getResources().getDisplayMetrics().widthPixels
            val height: Int = (width * 9 / 16).toInt()

            val params = playerView.getLayoutParams()
            params.width = width
            params.height = height
            playerView.layoutParams = params
            playerContainer.layoutParams = ViewGroup.LayoutParams(width, height)

        }
    }


    override fun didRequestExpand(playerView: BBNativePlayerView) {
        Log.d("BBWPLUGIN", "Expand requested")
    }

}
