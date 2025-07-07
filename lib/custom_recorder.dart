import 'package:custom_recorder_platform_interface/custom_recorder_platform_interface.dart';

class CustomRecorder {
  Future<void> startRecording({required String path}) {
    return CustomRecorderPlatform.instance.startRecording(path: path);
  }

  Future<String?> stopRecording() {
    return CustomRecorderPlatform.instance.stopRecording();
  }
}
