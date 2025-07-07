import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_recorder_android_platform_interface.dart';

/// An implementation of [CustomRecorderAndroidPlatform] that uses method channels.
class MethodChannelCustomRecorderAndroid extends CustomRecorderAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_recorder_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
