import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';

class CameraWifiSettings extends CameraSettings {
  final SonyCameraWifiDevice sonyCameraWifiDevice;

  CameraWifiSettings(this.sonyCameraWifiDevice);

  @override
  Future<bool> update() async {
    await getSettings(
        WebApiVersion.V_1_4, true, sonyCameraWifiDevice); //current settings
    //camera settings?
    await sonyCameraWifiDevice.api.getFNumber();
  }

  Future<String> getSettings(WebApiVersion version, bool longPolling,
      SonyCameraWifiDevice device) async {
    var webResponse = await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.AvailableSettings,
        params: [longPolling]).send(device, timeout: 80000);
    //a list
    var jsonD = jsonDecode(webResponse.response);

    (jsonD["result"] as List<dynamic>)?.forEach((element) {
      if (element != null && !element.isEmpty) {
        String settingsIdWifiValue = element["type"];

        SettingsId settingsIdEnum =
            SettingsIdExtension.getIdFromWifi(settingsIdWifiValue);

        SettingsItem setting = getItem(settingsIdEnum);
        if (setting == null) {
          setting = new SettingsItem(settingsIdEnum);
          addItem(setting);
        }

        switch (setting.settingsId) {
          case SettingsId.FileFormat:
          case SettingsId.CameraStatus:
            //current is only named like the setting, eg: "fileFormat"
            //available list is named candidate
            getDefaultSettings(
                element, setting, settingsIdWifiValue, "candidate");
            break;
          case SettingsId.AvailableApiList:
            var availableList = element["names"];
            if (availableList != null) {
              setting.updateItem(
                  setting.value,
                  setting.subValue,
                  element["names"]
                      .map((element) => setting.fromWifi(element))
                      .toList<SettingsValue<dynamic>>(),
                  setting.supported);
            }
            break;
          case SettingsId.ImageSize:
          case SettingsId.AspectRatio:
            break;
          case SettingsId.LiveViewState:
          case SettingsId.LiveViewOrientation:
            //there is only a current value
            setting.updateItem(setting.fromWifi(element[settingsIdWifiValue]),
                setting.subValue, setting.available, setting.supported);

            break;
          case SettingsId.BeepMode:
          case SettingsId.CameraFunction:
          case SettingsId.MovieQuality:
          case SettingsId.MovieFileFormat:
          case SettingsId.FlashMode:
          case SettingsId.FocusMode:
          case SettingsId.FNumber:
          case SettingsId.ShutterSpeed:
          case SettingsId.ISO:
          default:
            //current is only named like the current setting, eg: "currentFNumber"
            //available list is named candidates like fNumberCandidates
            getDefaultSettings(
                element,
                setting,
                "current${settingsIdWifiValue.startCap}",
                "${settingsIdWifiValue.startCap}Candidates");
            break;
        }
      }
    });
  }

  Type typeOf<T>() => T;

  updateAvailable(SettingsItem settingsItem, String json) {
    if (settingsItem.runtimeType == typeOf<SettingsItem<DoubleValue>>()) {
      var jsonD = jsonDecode(json);
      var list = jsonD["result"];
      settingsItem.updateItem(
          DoubleValue(double.parse(list[0].replaceAll(",", "."))),
          settingsItem.subValue,
          (list[1] as List)
              .map((e) => DoubleValue(double.parse(e.replaceAll(",", "."))))
              .toList(),
          settingsItem.supported);
    }
  }

  updateSupported(SettingsItem settingsItem, String json) {
    //TODO
  }

  getDefaultSettings(
      json, SettingsItem setting, String currentName, String availableName) {
    setting.updateItem(
        setting.fromWifi(json[currentName]),
        setting.subValue,
        json[availableName].map((e) => setting.fromWifi(e)).toList(),
        setting.supported);
  }
}