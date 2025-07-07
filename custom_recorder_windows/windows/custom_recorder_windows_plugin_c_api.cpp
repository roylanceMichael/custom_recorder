#include "include/custom_recorder_windows/custom_recorder_windows_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "custom_recorder_windows_plugin.h"

void CustomRecorderWindowsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  custom_recorder_windows::CustomRecorderWindowsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
