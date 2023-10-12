package nl.autoblog.bluebillywig

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
import nl.autoblog.bluebillywig.R.layout.player_container
import io.flutter.plugin.platform.PlatformView

internal class BbwVideo(context: Context, creationParams: Map<String?, Any?>?) : PlatformView, BBNativePlayerViewDelegate {
    private var playerContainer: LinearLayout
    private lateinit var playerView: BBNativePlayerView

    override fun getView(): View {
        return playerContainer
    }

    public fun pauseVideo(): Boolean {
        if ( playerView != null ) {
            playerView.callApiMethod(ApiMethod.pause, null)
        }
        return true
    }

    override fun dispose() {
        playerView.destroy()
    }

    init {
        val inflater =
            context.getSystemService(Context.LAYOUT_INFLATER_SERVICE) as LayoutInflater
        playerContainer = inflater.inflate(player_container, null, false) as LinearLayout
        playerContainer.setBackgroundColor(Color.RED)
        val width: Int? = creationParams?.get("width") as Int
        val height: Int? = creationParams?.get("height") as Int
        if (height != null && width != null) {
            Log.d("DHEIGHT", height.toString())
            val params: ViewGroup.LayoutParams = playerContainer.layoutParams
            params.height = height
            params.width = width
            playerContainer.layoutParams = params
        }

        val url = creationParams?.get("url")
        if (url is String) {

            val playerOptions = mapOf("noChromeCast" to true)
            playerView = BBNativePlayer.createPlayerView(
                context,
                // test url is "https://demo.bbvms.com/p/native_sdk_inoutview/c/4256635.json",
                url,
                playerOptions
            )

            // playerContainer.addView(playerView)
        }
    }
}
