import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_recorder_windows_platform_interface.dart';

/// An implementation of [CustomRecorderWindowsPlatform] that uses method channels.
class MethodChannelCustomRecorderWindows extends CustomRecorderWindowsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_recorder_windows');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
