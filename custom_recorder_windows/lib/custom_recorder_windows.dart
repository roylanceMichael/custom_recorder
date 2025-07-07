import 'package:custom_recorder_platform_interface/custom_recorder_platform_interface.dart';

class CustomRecorderWindows extends CustomRecorderPlatform {
  static void registerWith() {
    CustomRecorderPlatform.instance = CustomRecorderWindows();
  }

  @override
  Future<void> startRecording({required String path}) async {
    // Placeholder implementation
  }

  @override
  Future<String?> stopRecording() async {
    // Placeholder implementation
    return null;
  }
}