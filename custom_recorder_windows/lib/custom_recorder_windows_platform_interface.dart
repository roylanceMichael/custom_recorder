import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_recorder_windows_method_channel.dart';

abstract class CustomRecorderWindowsPlatform extends PlatformInterface {
  /// Constructs a CustomRecorderWindowsPlatform.
  CustomRecorderWindowsPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomRecorderWindowsPlatform _instance = MethodChannelCustomRecorderWindows();

  /// The default instance of [CustomRecorderWindowsPlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomRecorderWindows].
  static CustomRecorderWindowsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomRecorderWindowsPlatform] when
  /// they register themselves.
  static set instance(CustomRecorderWindowsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
