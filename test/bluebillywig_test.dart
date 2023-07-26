import 'package:flutter_test/flutter_test.dart';
import 'package:bluebillywig/bluebillywig.dart';
import 'package:bluebillywig/bluebillywig_platform_interface.dart';
import 'package:bluebillywig/bluebillywig_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBluebillywigPlatform
    with MockPlatformInterfaceMixin
    implements BluebillywigPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BluebillywigPlatform initialPlatform = BluebillywigPlatform.instance;

  test('$MethodChannelBluebillywig is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBluebillywig>());
  });

  test('getPlatformVersion', () async {
    Bluebillywig bluebillywigPlugin = Bluebillywig();
    MockBluebillywigPlatform fakePlatform = MockBluebillywigPlatform();
    BluebillywigPlatform.instance = fakePlatform;

    expect(await bluebillywigPlugin.getPlatformVersion(), '42');
  });
}
