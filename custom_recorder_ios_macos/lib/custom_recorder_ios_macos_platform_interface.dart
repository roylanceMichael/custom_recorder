import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'custom_recorder_ios_macos_method_channel.dart';

abstract class CustomRecorderIosMacosPlatform extends PlatformInterface {
  /// Constructs a CustomRecorderIosMacosPlatform.
  CustomRecorderIosMacosPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomRecorderIosMacosPlatform _instance = MethodChannelCustomRecorderIosMacos();

  /// The default instance of [CustomRecorderIosMacosPlatform] to use.
  ///
  /// Defaults to [MethodChannelCustomRecorderIosMacos].
  static CustomRecorderIosMacosPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CustomRecorderIosMacosPlatform] when
  /// they register themselves.
  static set instance(CustomRecorderIosMacosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
