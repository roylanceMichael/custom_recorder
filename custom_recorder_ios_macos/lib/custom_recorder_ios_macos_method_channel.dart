import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_recorder_ios_macos_platform_interface.dart';

/// An implementation of [CustomRecorderIosMacosPlatform] that uses method channels.
class MethodChannelCustomRecorderIosMacos extends CustomRecorderIosMacosPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_recorder_ios_macos');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
