import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_recorder_linux_method_channel.dart';

abstract class CustomRecorderLinuxPlatform extends PlatformInterface {
  /// Constructs a CustomRecorderLinuxPlatform.
  CustomRecorderLinuxPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomRecorderLinuxPlatform _instance = MethodChannelCustomRecorderLinux();

  /// The default instance of [CustomRecorderLinuxPlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomRecorderLinux].
  static CustomRecorderLinuxPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomRecorderLinuxPlatform] when
  /// they register themselves.
  static set instance(CustomRecorderLinuxPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
