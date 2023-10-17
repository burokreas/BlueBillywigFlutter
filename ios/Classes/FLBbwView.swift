import BBNativePlayerKit
import bbnativeshared
import Flutter

class FLBbwViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return FLBbwView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class FLBbwView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var bbPlayerView: BBNativePlayerView? = nil
    private var url: String = ""
    private var rect = CGRect(x: 0, y: 0, width: 375, height: 210)
    private var h: Int = 0
    private var w: Int = 0

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        if let argums = args as? [String: Any?] {
            if let hs = argums["height"] as? Int { h = Int(hs) }
            print("bbw height: " + String(h))
            if let ws = argums["width"] as? Int { w = Int(ws) }
            print("bbw width: " + String(w))
            if let urls = argums["url"] as? String {
                let urlcleanup = URL(string: urls)!
                url = urlcleanup.absoluteString
                print("bbw url: " + url)
            }
        }

        rect = CGRect(x: 0, y: 0, width: w, height: h)
        _view = UIView(frame: rect)

        super.init()

//        if (messenger != nil ) {
//            let channel = FlutterMethodChannel(name: "com.opacha.autoblog/videoplayer", binaryMessenger: messenger!)
//
//             channel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
//                 switch(call.method) {
//                 case "BBWPauseVideo":
//                     if ( self != nil && self!.bbPlayerView != nil ) {
//                         self!.bbPlayerView?.player.pause()
//                     }
//                     result(nil)
//                 default:
//                     result(FlutterMethodNotImplemented)
//                 }
//             })
//        }
  
        createNativeView(view: _view, url: url, frame: _view.frame)
    }

    func view() -> UIView {
        return _view
    }

    func createNativeView(view _view: UIView, url: String, frame: CGRect) {
        if url.isEmpty {
            return
        }

        // create player view using the embed url
        bbPlayerView = BBNativePlayer.createPlayerView(
            uiViewController: _view.findViewController(),
            frame: frame,
            jsonUrl: url,
            options: [
                "noChromeCast": true,
                "commercials": true
            ]
        )

        bbPlayerView?.delegate = self

        // add player to the view
        _view.addSubview(bbPlayerView!)

        // use constraints to place and size the player view
        bbPlayerView?.translatesAutoresizingMaskIntoConstraints = false
        bbPlayerView?.leftAnchor.constraint(equalTo: view().leftAnchor).isActive = true
        bbPlayerView?.topAnchor.constraint(equalTo: view().topAnchor, constant: 0 ).isActive = true
        bbPlayerView?.widthAnchor.constraint(equalTo: view().widthAnchor).isActive = true
        bbPlayerView?.heightAnchor.constraint(equalTo: view().heightAnchor).isActive = true
    }
}

extension FLBbwView: BBNativePlayerViewDelegate {
    func bbNativePlayerView(didTriggerPlaying playerView: BBNativePlayerView) {
        print("BBW: didTriggerPlaying")
    }

    func bbNativePlayerView(didTriggerPause playerView: BBNativePlayerView) {
        print("BBW: didTriggerPause")
    }

    func bbNativePlayerView(didSetupWithJsonUrl playerView: BBNativePlayerView) {
        print("BBW: didSetupWithJsonUrl")
    }

    func bbNativePlayerView(didFailWithError playerView: BBNativePlayerView, error: String?) {
        print("BBW: didFailWithError")
        if (error != nil) {
            print(error!)
        }
    }
}

extension UIView {
    func findViewController() -> UIViewController {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return UIViewController()
        }
    }
}
