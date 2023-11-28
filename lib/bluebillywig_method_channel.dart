import 'package:bluebillywig/bluebillywig_platform_interface.dart';
import 'package:flutter/services.dart';

/// An implementation of [BluebillywigPlatform] that uses method channels.
class MethodChannelBluebillywig extends BluebillywigPlatform {
  /// The method channel used to interact with the native platform.
  final methodChannel = const MethodChannel('bluebillywig');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
