import 'package:custom_recorder_platform_interface/custom_recorder_platform_interface.dart';
import 'package:flutter/services.dart';

class CustomRecorderWindows extends CustomRecorderPlatform {
  final MethodChannel _channel = const MethodChannel('custom_recorder_windows');

  static void registerWith() {
    CustomRecorderPlatform.instance = CustomRecorderWindows();
  }

  @override
  Future<void> startRecording({required String path}) async {
    return _channel.invokeMethod('startRecording', {'path': path});
  }

  @override
  Future<String?> stopRecording() async {
    // Placeholder implementation
    return _channel.invokeMethod('stopRecording');
  }
}