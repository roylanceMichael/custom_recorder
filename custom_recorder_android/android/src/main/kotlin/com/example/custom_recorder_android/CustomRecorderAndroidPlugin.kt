package com.example.custom_recorder_android

import android.media.MediaRecorder
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.IOException

/** CustomRecorderAndroidPlugin */
class CustomRecorderAndroidPlugin: FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var mediaRecorder: MediaRecorder? = null
    private var recordingPath: String? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "custom_recorder_android")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "startRecording" -> {
                val path = call.argument<String>("path")
                if (path == null) {
                    result.error("INVALID_ARGUMENTS", "Path is required", null)
                    return
                }
                startRecording(path, result)
            }
            "stopRecording" -> stopRecording(result)
            else -> result.notImplemented()
        }
    }

    private fun startRecording(path: String, result: Result) {
        mediaRecorder = MediaRecorder().apply {
            setAudioSource(MediaRecorder.AudioSource.MIC)
            setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
            setAudioEncoder(MediaRecorder.AudioEncoder.AAC)
            setOutputFile(path)
            recordingPath = path
            try {
                prepare()
                start()
                result.success(null)
            } catch (e: IOException) {
                result.error("RECORDING_ERROR", "Failed to start recording", e.localizedMessage)
            }
        }
    }

    private fun stopRecording(result: Result) {
        mediaRecorder?.apply {
            stop()
            release()
        }
        mediaRecorder = null
        result.success(recordingPath)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
