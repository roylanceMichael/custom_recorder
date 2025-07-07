import 'package:flutter_test/flutter_test.dart';
import 'package:custom_recorder_android/custom_recorder_android.dart';
import 'package:custom_recorder_android/custom_recorder_android_platform_interface.dart';
import 'package:custom_recorder_android/custom_recorder_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCustomRecorderAndroidPlatform
    with MockPlatformInterfaceMixin
    implements CustomRecorderAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CustomRecorderAndroidPlatform initialPlatform = CustomRecorderAndroidPlatform.instance;

  test('$MethodChannelCustomRecorderAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCustomRecorderAndroid>());
  });

  test('getPlatformVersion', () async {
    CustomRecorderAndroid customRecorderAndroidPlugin = CustomRecorderAndroid();
    MockCustomRecorderAndroidPlatform fakePlatform = MockCustomRecorderAndroidPlatform();
    CustomRecorderAndroidPlatform.instance = fakePlatform;

    expect(await customRecorderAndroidPlugin.getPlatformVersion(), '42');
  });
}
