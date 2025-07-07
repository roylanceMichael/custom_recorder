import 'package:flutter_test/flutter_test.dart';
import 'package:custom_recorder_windows/custom_recorder_windows.dart';
import 'package:custom_recorder_windows/custom_recorder_windows_platform_interface.dart';
import 'package:custom_recorder_windows/custom_recorder_windows_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCustomRecorderWindowsPlatform
    with MockPlatformInterfaceMixin
    implements CustomRecorderWindowsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CustomRecorderWindowsPlatform initialPlatform = CustomRecorderWindowsPlatform.instance;

  test('$MethodChannelCustomRecorderWindows is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCustomRecorderWindows>());
  });

  test('getPlatformVersion', () async {
    CustomRecorderWindows customRecorderWindowsPlugin = CustomRecorderWindows();
    MockCustomRecorderWindowsPlatform fakePlatform = MockCustomRecorderWindowsPlatform();
    CustomRecorderWindowsPlatform.instance = fakePlatform;

    expect(await customRecorderWindowsPlugin.getPlatformVersion(), '42');
  });
}
