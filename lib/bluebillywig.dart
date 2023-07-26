
import 'bluebillywig_platform_interface.dart';

class Bluebillywig {
  Future<String?> getPlatformVersion() {
    return BluebillywigPlatform.instance.getPlatformVersion();
  }
}
