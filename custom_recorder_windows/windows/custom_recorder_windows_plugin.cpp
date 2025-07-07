#include "custom_recorder_windows_plugin.h"

// Standard C++ headers
#include <windows.h>
#include <mmsystem.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

#pragma comment(lib, "winmm.lib")

namespace {

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
    const auto* arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    auto path_value = arguments->find(flutter::EncodableValue("path"));
    if (path_value != arguments->end()) {
        std::string path = std::get<std::string>(path_value->second);
        std::wstring wpath = Utf8ToUtf16(path);
        mciSendString(L"open new type waveaudio alias recorder", NULL, 0, NULL);
        std::wstring command = L"record recorder " + wpath;
        mciSendString(command.c_str(), NULL, 0, NULL);
        recording_path_ = path;
    }
    result->Success();
  } else if (method_call.method_name().compare("stopRecording") == 0) {
    mciSendString(L"stop recorder", NULL, 0, NULL);
    mciSendString(L"close recorder", NULL, 0, NULL);
    result->Success(flutter::EncodableValue(recording_path_));
  }
  else {
    result->NotImplemented();
  }
}

}  // namespace custom_recorder_windows
