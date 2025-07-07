import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_recorder_android_method_channel.dart';

abstract class CustomRecorderAndroidPlatform extends PlatformInterface {
  /// Constructs a CustomRecorderAndroidPlatform.
  CustomRecorderAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomRecorderAndroidPlatform _instance = MethodChannelCustomRecorderAndroid();

  /// The default instance of [CustomRecorderAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomRecorderAndroid].
  static CustomRecorderAndroidPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomRecorderAndroidPlatform] when
  /// they register themselves.
  static set instance(CustomRecorderAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
