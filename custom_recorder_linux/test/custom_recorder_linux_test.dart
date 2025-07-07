import 'package:flutter_test/flutter_test.dart';
import 'package:custom_recorder_linux/custom_recorder_linux.dart';
import 'package:custom_recorder_linux/custom_recorder_linux_platform_interface.dart';
import 'package:custom_recorder_linux/custom_recorder_linux_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCustomRecorderLinuxPlatform
    with MockPlatformInterfaceMixin
    implements CustomRecorderLinuxPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CustomRecorderLinuxPlatform initialPlatform = CustomRecorderLinuxPlatform.instance;

  test('$MethodChannelCustomRecorderLinux is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCustomRecorderLinux>());
  });

  test('getPlatformVersion', () async {
    CustomRecorderLinux customRecorderLinuxPlugin = CustomRecorderLinux();
    MockCustomRecorderLinuxPlatform fakePlatform = MockCustomRecorderLinuxPlatform();
    CustomRecorderLinuxPlatform.instance = fakePlatform;

    expect(await customRecorderLinuxPlugin.getPlatformVersion(), '42');
  });
}
