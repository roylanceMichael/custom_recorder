#ifndef FLUTTER_PLUGIN_CUSTOM_RECORDER_WINDOWS_PLUGIN_H_
#define FLUTTER_PLUGIN_CUSTOM_RECORDER_WINDOWS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace custom_recorder_windows {

class CustomRecorderWindowsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  CustomRecorderWindowsPlugin();

  virtual ~CustomRecorderWindowsPlugin();

  // Disallow copy and assign.
  CustomRecorderWindowsPlugin(const CustomRecorderWindowsPlugin&) = delete;
  CustomRecorderWindowsPlugin& operator=(const CustomRecorderWindowsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace custom_recorder_windows

#endif  // FLUTTER_PLUGIN_CUSTOM_RECORDER_WINDOWS_PLUGIN_H_
