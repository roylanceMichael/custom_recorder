import Flutter
import UIKit
import AVFoundation

public class CustomRecorderIosMacosPlugin: NSObject, FlutterPlugin, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder?
    var recordingPath: String?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "custom_recorder_ios_macos", binaryMessenger: registrar.messenger())
        let instance = CustomRecorderIosMacosPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startRecording":
            guard let args = call.arguments as? [String: Any],
                  let path = args["path"] as? String else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Path is required", details: nil))
                return
            }
            startRecording(path: path, result: result)
        case "stopRecording":
            stopRecording(result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func startRecording(path: String, result: @escaping FlutterResult) {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            let url = URL(fileURLWithPath: path)
            recordingPath = path
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            result(nil)
        } catch {
            result(FlutterError(code: "RECORDING_ERROR", message: error.localizedDescription, details: nil))
        }
    }

    private func stopRecording(result: @escaping FlutterResult) {
        audioRecorder?.stop()
        audioRecorder = nil
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(false)
        } catch {
            // Handle error
        }
        result(recordingPath)
    }
}
