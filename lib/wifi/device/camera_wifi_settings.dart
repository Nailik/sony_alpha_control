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
    //TODO camera settings? that are not initialized
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
        String settingsIdWifiValue =
            element["type"] as String; //as String because it might be an int

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
                      .map<SettingsValue<dynamic>>(
                          (element) => setting.fromWifi(element))
                      .toList(),
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

  //TODO no current = null = unsupported at the moment? (eg when flash is inside)
  updateAvailable(SettingsItem settingsItem, String json) {
    var jsonD = jsonDecode(json);
    var list = jsonD["result"];

    switch (settingsItem.settingsId) {
      case SettingsId.EV:
        //special case
        List<EvValue> listOfValues = getEvList(list[2], list[1], list[3]);
        settingsItem.updateItem(
            listOfValues.elementAt(list[0] + (list[2]).abs()),
            settingsItem.subValue,
            listOfValues,
            settingsItem.supported);
        break;
      default:
        settingsItem.updateItem(
            settingsItem.fromWifi(list[0]),
            settingsItem.subValue,
            settingsItem.createListFromWifiJson(list[1] as List),
            settingsItem.supported);
        break;
    }
  }

  updateSupported(SettingsItem settingsItem, String json) {
    var jsonD = jsonDecode(json);
    var list = jsonD["result"];

    switch (settingsItem.settingsId) {
      case SettingsId.EV:
        //special case
        //0: int[] upper limit
        //1: int[] lower limit
        //2 int[] 1: 1/3 EV  2: 1/2 EV  0: invalid
        List<EvValue> listOfValues = new List();
        for (int index = 0; index < list[2].length; index++) {
          listOfValues.addAll(
              getEvList(list[1][index], list[0][index], list[2][index]));
        }

        settingsItem.updateItem(settingsItem.value, settingsItem.subValue,
            settingsItem.available, listOfValues);
        break;
      default:
        settingsItem.updateItem(
            settingsItem.value,
            settingsItem.subValue,
            settingsItem.available,
            settingsItem.createListFromWifiJson(list[0] as List));
        break;
    }
  }

  List<EvValue> getEvList(int min, int max, int stepIndex) {
    //special case
    //0 int current index
    //1: int upper limit
    //2: int lower limit
    //3: int 1: 1/3 EV  2: 1/2 EV  0: invalid
    int z = stepIndex == 1 ? 3 : 2;
    List<EvValue> listOfValues = new List();

    //list for 1/3 ev (x = 0), list for 1/2 ev (x = 1)
    for (int i = min; i <= max; i++) {
      //lower limit to upper limit
      var num = ((i / z) * 10).toInt();
      if (num % 10 == 6) {
        //ends with a 6 should be a 7
        num++;
      }
      listOfValues.add(EvValue(i, z, num.toDouble() / 10));
    }

    return listOfValues;
  }

  getDefaultSettings(json, SettingsItem settingsItem, String currentName,
      String availableName) {
    print("getDefaultSettings json $json availableName $availableName");

    List<SettingsValue> availableList;
    SettingsValue current;

    switch (settingsItem.settingsId) {
      case SettingsId.EV:
        availableList = getEvList(
            json["minExposureCompensation"],
            json["maxExposureCompensation"],
            json["stepIndexOfExposureCompensation"]);
        current = settingsItem.fromWifi(json["currentExposureCompensation"]);
        break;
      default:
        availableList = json[availableName]
            ?.map((e) => settingsItem.fromWifi(e))
            ?.toList(); //maybe there is no candidates/available list (e.g. camera status)
        current = settingsItem.fromWifi(json[currentName]);
        break;
    }

    settingsItem.updateItem(
        current,
        settingsItem.subValue,
        availableList != null ? availableList : settingsItem.available,
        settingsItem.supported);
  }
}
