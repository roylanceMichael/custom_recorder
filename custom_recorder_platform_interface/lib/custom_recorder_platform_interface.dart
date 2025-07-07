import 'package:plugin_platform_interface/plugin_platform_interface.dart';

abstract class CustomRecorderPlatform extends PlatformInterface {
  CustomRecorderPlatform() : super(token: _token);

  static final Object _token = Object();

  static CustomRecorderPlatform _instance = MethodChannelCustomRecorder();

  static CustomRecorderPlatform get instance => _instance;

  static set instance(CustomRecorderPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> startRecording({required String path}) {
    throw UnimplementedError('startRecording() has not been implemented.');
  }

  Future<String?> stopRecording() {
    throw UnimplementedError('stopRecording() has not been implemented.');
  }
}

class MethodChannelCustomRecorder extends CustomRecorderPlatform {}