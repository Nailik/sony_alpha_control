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
  Future<bool> update() {
    getSettings(
        WebApiVersion.V_1_4, true, sonyCameraWifiDevice); //current settings
    //camera settings?
  }

  Future<String> getSettings(WebApiVersion version, bool longPolling,
      SonyCameraWifiDevice device) async {
    var webResponse = await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.AvailableSettings,
        params: [longPolling]).send(device, timeout: 80000);
    //a list
    var jsonD = jsonDecode(webResponse.response);

    (jsonD["result"] as List<dynamic>)?.forEach((element) {
      if (element != null) {
        var settingsIdWifiValue = element["type"];

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
              setting.available.clear();
              availableList.forEach((item) {
                setting.available.add(setting.fromWifi(item));
              });
            }
            break;
          case SettingsId.ImageSize:
          case SettingsId.AspectRatio:
            break;
          case SettingsId.LiveViewState:
          case SettingsId.LiveViewOrientation:
            //there is only a current value
            setting.value = setting.fromWifi(element[settingsIdWifiValue]);
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

  updateAvailable(SettingsId settingsId, String json) {
    //TODO
  }

  updateSupported(SettingsId settingsId, String json) {
    //TODO
  }

  getDefaultSettings(
      json, SettingsItem setting, String currentName, String availableName) {
    setting.value = setting.fromWifi(json[currentName]);
    var availableList = json[availableName];

    if (availableList != null) {
      setting.available.clear();
      availableList.forEach((item) {
        setting.available.add(setting.fromWifi(item));
      });
    }
  }
}