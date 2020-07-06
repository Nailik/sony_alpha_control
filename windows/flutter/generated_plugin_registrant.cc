//
//  Generated file. Do not edit.
//

#include "generated_plugin_registrant.h"

#include <file_chooser_plugin.h>
#include <flutter_usb_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FileChooserPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FileChooserPlugin"));
  FlutterUsbPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterUsbPlugin"));
}
