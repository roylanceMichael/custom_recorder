import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:custom_recorder_windows/custom_recorder_windows.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isRecording = false;
  String? _recordingPath;
  final _customRecorder = CustomRecorderWindows();

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final path = await _customRecorder.stopRecording();
      setState(() {
        _isRecording = false;
        _recordingPath = path;
      });
    } else {
      final directory = await getApplicationDocumentsDirectory();
      final path = '${directory.path}\recording.wav';
      await _customRecorder.startRecording(path: path);
      setState(() {
        _isRecording = true;
        _recordingPath = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _toggleRecording,
                child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
              ),
              if (_recordingPath != null)
                Text('Recording saved to: $_recordingPath'),
            ],
          ),
        ),
      ),
    );
  }
}
