import 'package:flutter_test/flutter_test.dart';
import 'package:custom_recorder_ios_macos/custom_recorder_ios_macos.dart';
import 'package:custom_recorder_ios_macos/custom_recorder_ios_macos_platform_interface.dart';
import 'package:custom_recorder_ios_macos/custom_recorder_ios_macos_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCustomRecorderIosMacosPlatform
    with MockPlatformInterfaceMixin
    implements CustomRecorderIosMacosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CustomRecorderIosMacosPlatform initialPlatform = CustomRecorderIosMacosPlatform.instance;

  test('$MethodChannelCustomRecorderIosMacos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCustomRecorderIosMacos>());
  });

  test('getPlatformVersion', () async {
    CustomRecorderIosMacos customRecorderIosMacosPlugin = CustomRecorderIosMacos();
    MockCustomRecorderIosMacosPlatform fakePlatform = MockCustomRecorderIosMacosPlatform();
    CustomRecorderIosMacosPlatform.instance = fakePlatform;

    expect(await customRecorderIosMacosPlugin.getPlatformVersion(), '42');
  });
}
