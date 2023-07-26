import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bluebillywig_platform_interface.dart';

/// An implementation of [BluebillywigPlatform] that uses method channels.
class MethodChannelBluebillywig extends BluebillywigPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bluebillywig');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
