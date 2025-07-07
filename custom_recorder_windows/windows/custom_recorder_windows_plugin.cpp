#include "custom_recorder_windows_plugin.h"

// Standard C++ headers
#include <windows.h>
#include <mmsystem.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <iostream>

#pragma comment(lib, "winmm.lib")

namespace {

// Helper function to convert UTF-8 to UTF-16
std::wstring Utf8ToUtf16(const std::string& utf8_string) {
  if (utf8_string.empty()) {
    return std::wstring();
  }
  int target_length =
      ::MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, utf8_string.data(),
                            static_cast<int>(utf8_string.length()), nullptr, 0);
  if (target_length == 0) {
    return std::wstring();
  }
  std::wstring utf16_string;
  utf16_string.resize(target_length);
  int converted_length =
      ::MultiByteToWideChar(CP_UTF8, MB_ERR_INVALID_CHARS, utf8_string.data(),
                            static_cast<int>(utf8_string.length()),
                            utf16_string.data(), target_length);
  if (converted_length == 0) {
    return std::wstring();
  }
  return utf16_string;
}

// Helper function for logging MCI errors
void LogMciError(MCIERROR err, const char* function) {
    if (err != 0) {
        char error_text[128];
        mciGetErrorStringA(err, error_text, sizeof(error_text));
        std::stringstream ss;
        ss << "MCI Error in " << function << ": " << error_text << " (Code: " << err << ")";
        OutputDebugStringA(ss.str().c_str());
    }
}

}  // namespace

namespace custom_recorder_windows {

// static
void CustomRecorderWindowsPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "custom_recorder_windows",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<CustomRecorderWindowsPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

CustomRecorderWindowsPlugin::CustomRecorderWindowsPlugin() {}

CustomRecorderWindowsPlugin::~CustomRecorderWindowsPlugin() {}

void CustomRecorderWindowsPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("startRecording") == 0) {
    OutputDebugStringA("startRecording called\n");
    const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    auto path_value = arguments->find(flutter::EncodableValue("path"));
    if (path_value != arguments->end()) {
        std::string path = std::get<std::string>(path_value->second);
        std::stringstream ss;
        ss << "Path received: " << path;
        OutputDebugStringA(ss.str().c_str());

        std::wstring wpath = Utf8ToUtf16(path);
        
        MCIERROR err;

        err = mciSendString(L"open new type waveaudio alias recorder", NULL, 0, NULL);
        LogMciError(err, "open");

        std::wstring command = L"record recorder";
        OutputDebugStringW((L"Executing command: " + command + L"\n").c_str());
        err = mciSendString(command.c_str(), NULL, 0, NULL);
        LogMciError(err, "record");
        recording_path_ = path;
    }
    result->Success();
  } else if (method_call.method_name().compare("stopRecording") == 0) {
    OutputDebugStringA("stopRecording called\n");
    MCIERROR err;

    err = mciSendString(L"stop recorder", NULL, 0, NULL);
    LogMciError(err, "stop");

    std::wstring wpath = Utf8ToUtf16(recording_path_);
    std::wstring command = L"save recorder " + wpath;
    OutputDebugStringW((L"Executing command: " + command + L"\n").c_str());
    err = mciSendString(command.c_str(), NULL, 0, NULL);
    LogMciError(err, "save");

    err = mciSendString(L"close recorder", NULL, 0, NULL);
    LogMciError(err, "close");
    result->Success(flutter::EncodableValue(recording_path_));
  }
  else {
    result->NotImplemented();
  }
}

}  // namespace custom_recorder_windows
