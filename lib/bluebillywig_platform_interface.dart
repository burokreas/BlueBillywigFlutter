import 'package:bluebillywig/bluebillywig_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class BluebillywigPlatform extends PlatformInterface {
  /// Constructs a BluebillywigPlatform.
  BluebillywigPlatform() : super(token: _token);

  static final Object _token = Object();

  static BluebillywigPlatform _instance = MethodChannelBluebillywig();

  /// The default instance of [BluebillywigPlatform] to use.
  ///
  /// Defaults to [MethodChannelBluebillywig].
  static BluebillywigPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BluebillywigPlatform] when
  /// they register themselves.
  static set instance(BluebillywigPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
