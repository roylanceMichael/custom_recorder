import 'package:custom_recorder_platform_interface/custom_recorder_platform_interface.dart';
import 'package:flutter/services.dart';

class CustomRecorderIosMacos extends CustomRecorderPlatform {
  final MethodChannel _channel = const MethodChannel('custom_recorder_ios_macos');

  static void registerWith() {
    CustomRecorderPlatform.instance = CustomRecorderIosMacos();
  }

  @override
  Future<void> startRecording({required String path}) {
    return _channel.invokeMethod('startRecording', {'path': path});
  }

  @override
  Future<String?> stopRecording() {
    return _channel.invokeMethod('stopRecording');
  }
}