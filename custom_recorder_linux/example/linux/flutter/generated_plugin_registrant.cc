//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <custom_recorder_linux/custom_recorder_linux_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) custom_recorder_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "CustomRecorderLinuxPlugin");
  custom_recorder_linux_plugin_register_with_registrar(custom_recorder_linux_registrar);
}
