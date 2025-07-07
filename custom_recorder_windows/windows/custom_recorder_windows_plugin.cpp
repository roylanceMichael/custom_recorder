#include "custom_recorder_windows_plugin.h"

#include <windows.h>
#include <mmsystem.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

#pragma comment(lib, "winmm.lib")

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
        mciSendString("open new type waveaudio alias recorder", NULL, 0, NULL);
        std::string command = "record recorder " + path;
        mciSendString(command.c_str(), NULL, 0, NULL);
        recording_path_ = path;
    }
    result->Success();
  } else if (method_call.method_name().compare("stopRecording") == 0) {
    mciSendString("stop recorder", NULL, 0, NULL);
    mciSendString("close recorder", NULL, 0, NULL);
    result->Success(flutter::EncodableValue(recording_path_));
  }
  else {
    result->NotImplemented();
  }
}

}  // namespace custom_recorder_windows
