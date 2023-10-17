import Flutter
import UIKit

public class BluebillywigPlugin: NSObject, FlutterPlugin {

  public static func register(with registrar: FlutterPluginRegistrar) {
    let factory = FLBbwViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "com.bluebillywig.player/view")

    let channel = FlutterMethodChannel(name: "com.bluebillywig.player/channel", binaryMessenger: registrar.messenger())
    let instance = BluebillywigPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
  switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
