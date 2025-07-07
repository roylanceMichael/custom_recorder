import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'custom_recorder_linux_platform_interface.dart';

/// An implementation of [CustomRecorderLinuxPlatform] that uses method channels.
class MethodChannelCustomRecorderLinux extends CustomRecorderLinuxPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('custom_recorder_linux');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
