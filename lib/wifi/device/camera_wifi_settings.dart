import 'dart:collection';
import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';

class CameraWifiSettings extends CameraSettings {
  final SonyCameraWifiDevice sonyCameraWifiDevice;

  CameraWifiSettings(this.sonyCameraWifiDevice);

  @override
  Future<bool> update() async {
    await getSettings(
        WebApiVersionId.V_1_4, true, sonyCameraWifiDevice); //current settings
    //TODO camera settings? that are not initialized
  }

  //TODO machen
  Future<String> getSettings(WebApiVersionId version, bool longPolling,
      SonyCameraWifiDevice device) async {
    var webResponse = await WifiCommand.createCommand(
        ApiMethodId.GET, ItemId.AvailableSettings,
        params: [longPolling]).send(device, timeout: 80000);
    //a list
    var jsonD = jsonDecode(webResponse.response);

    (jsonD["result"] as List<dynamic>)?.forEach((element) {
      if (element != null && !element.isEmpty) {
        if (element is LinkedHashMap) {
          //probably storage information
          return;
        }

        String settingsIdWifiValue =
            element["type"] as String; //as String because it might be an int

        ItemId settingsIdEnum =
            SettingsIdExtension.getIdFromWifi(settingsIdWifiValue);

        SettingsItem setting = getItem(settingsIdEnum);
        if (setting == null) {
          print("ERROR ******");
        }

        switch (setting.itemId) {
          case ItemId.ImageFileFormat:
          case ItemId.CameraStatus:
            //current is only named like the setting, eg: "fileFormat"
            //available list is named candidate
            getDefaultSettings(
                element, setting, settingsIdWifiValue, "candidate");
            break;
          case ItemId.ApiList:
            var availableList = element["names"];
            if (availableList != null) {
              setting.updateItem(
                  setting.value,
                  element["names"]
                      .map<Value<dynamic>>(
                          (element) => Value.fromWifi(setting.itemId, element))
                      .toList(),
                  setting.supported);
            }
            break;
          case ItemId.ImageSize:
          case ItemId.AspectRatio:
            break;
          case ItemId.LiveViewState:
          case ItemId.LiveViewOrientation:
            //there is only a current value
            setting.updateItem(
                Value.fromWifi(setting.itemId, element[settingsIdWifiValue]),
                setting.available,
                setting.supported);
            break;
          case ItemId.WhiteBalanceMode:
            //   setting.updateItem(setting.fromWifi(element[settingsIdWifiValue]),
            //   setting.subValue, setting.available, setting.supported); //TODO
            break;
          case ItemId.BeepMode:
          case ItemId.CameraFunction:
          case ItemId.MovieQuality:
          case ItemId.MovieFileFormat:
          case ItemId.FlashMode:
          case ItemId.FocusMode:
          case ItemId.FNumber:
          case ItemId.ShutterSpeed:
          case ItemId.ISO:
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
  updateAvailable(SettingsItem settingsItem, String json) async {
    var jsonD = jsonDecode(json);
    var list = jsonD["result"];

    switch (settingsItem.itemId) {
      case ItemId.EV:
        //special case
        List<EvValue> listOfValues = getEvList(list[2], list[1], list[3]);
        settingsItem.updateItem(
            listOfValues.elementAt(list[0] + (list[2]).abs()),
            listOfValues,
            settingsItem.supported);
        break;
      case ItemId.WhiteBalanceMode:
        List<WhiteBalanceColorTempValue> supportedColorTempList =
            List<WhiteBalanceColorTempValue>();
        List<WhiteBalanceColorTempValue> availableColorTempList =
            List<WhiteBalanceColorTempValue>();
        Value currentWhiteBalance = WhiteBalanceModeValue.fromWifiValue(
            list[0]["whiteBalanceMode"], list[0]["colorTemperature"] != -1);

        //colorTemperature
        SettingsItem<WhiteBalanceColorTempValue> settingsItemColorTemp =
            sonyCameraWifiDevice.cameraSettings
                .getItem<WhiteBalanceColorTempValue>(
                    ItemId.WhiteBalanceColorTemp);

        settingsItem.updateItem(
            currentWhiteBalance,
            list[1].map<WhiteBalanceModeValue>((e) {
              var value = WhiteBalanceModeValue.fromWifiValue(
                  e["whiteBalanceMode"],
                  !(e["colorTemperatureRange"]?.isEmpty ?? true));
              if (value.hasColorTemps) {
                for (int i = e["colorTemperatureRange"][1];
                    i <= e["colorTemperatureRange"][0];
                    i += e["colorTemperatureRange"][2]) {
                  supportedColorTempList
                      .add(WhiteBalanceColorTempValue(i, value.id));
                  if (value.id == currentWhiteBalance.id) {
                    availableColorTempList
                        .add(WhiteBalanceColorTempValue(i, value.id));
                  }
                }
              }
              return value;
            }).toList(),
            settingsItem.supported);

        settingsItemColorTemp.updateItem(
            WhiteBalanceColorTempValue(
                list[0]["colorTemperature"], currentWhiteBalance.id),
            availableColorTempList,
            settingsItemColorTemp.supported);
        break;
      default:
        settingsItem.updateItem(
            Value.fromWifi(settingsItem.itemId, list[0]),
            settingsItem.createListFromWifiJson(list[1] as List),
            settingsItem.supported);
        break;
    }
  }

  updateSupported(SettingsItem settingsItem, String json) async {
    var jsonD = jsonDecode(json);
    var list = jsonD["result"];

    switch (settingsItem.itemId) {
      case ItemId.EV:
        //special case
        //0: int[] upper limit
        //1: int[] lower limit
        //2 int[] 1: 1/3 EV  2: 1/2 EV  0: invalid
        List<EvValue> listOfValues = new List();
        for (int index = 0; index < list[2].length; index++) {
          listOfValues.addAll(
              getEvList(list[1][index], list[0][index], list[2][index]));
        }

        settingsItem.updateItem(
            settingsItem.value, settingsItem.available, listOfValues);
        break;
      case ItemId.WhiteBalanceMode:
        List<WhiteBalanceColorTempValue> supportedColorTempList =
            List<WhiteBalanceColorTempValue>();
        List<WhiteBalanceColorTempValue> availableColorTempList =
            List<WhiteBalanceColorTempValue>();

        //colorTemperature
        SettingsItem<WhiteBalanceColorTempValue> settingsItemColorTemp =
            sonyCameraWifiDevice.cameraSettings
                .getItem<WhiteBalanceColorTempValue>(
                    ItemId.WhiteBalanceColorTemp);

        settingsItem.updateItem(
            settingsItem.value,
            settingsItem.available,
            list[0].map<WhiteBalanceModeValue>((e) {
              var value = WhiteBalanceModeValue.fromWifiValue(
                  e["whiteBalanceMode"],
                  !(e["colorTemperatureRange"]?.isEmpty ?? true));
              if (value.hasColorTemps) {
                for (int i = e["colorTemperatureRange"][1];
                    i <= e["colorTemperatureRange"][0];
                    i += e["colorTemperatureRange"][2]) {
                  supportedColorTempList
                      .add(WhiteBalanceColorTempValue(i, value.id));
                  if (value.id == settingsItem.value?.id) {
                    availableColorTempList
                        .add(WhiteBalanceColorTempValue(i, value.id));
                  }
                }
              }
              return value;
            }).toList());

        settingsItemColorTemp.updateItem(settingsItemColorTemp.value,
            settingsItemColorTemp.available, availableColorTempList);
        break;
      default:
        settingsItem.updateItem(settingsItem.value, settingsItem.available,
            settingsItem.createListFromWifiJson(list[0] as List));
        break;
    }
  }

  getDefaultSettings(json, SettingsItem settingsItem, String currentName,
      String availableName) {
    print("getDefaultSettings json $json availableName $availableName");

    List<Value> availableList;
    Value current;

    switch (settingsItem.itemId) {
      case ItemId.EV:
        availableList = getEvList(
            json["minExposureCompensation"],
            json["maxExposureCompensation"],
            json["stepIndexOfExposureCompensation"]);
        current = Value.fromWifi(
            settingsItem.itemId, json["currentExposureCompensation"]);
        break;
      default:
        availableList = json[availableName]
            ?.map((e) => Value.fromWifi(settingsItem.itemId, e))
            ?.toList(); //maybe there is no candidates/available list (e.g. camera status)
        current = Value.fromWifi(settingsItem.itemId, json[currentName]);
        break;
    }

    settingsItem.updateItem(
        current,
        availableList != null ? availableList : settingsItem.available,
        settingsItem.supported);
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

  updateListInfoItem(ListInfoItem listInfoItem, String json,
      {WebApiVersionId webApiVersion}) {
    var jsonD = jsonDecode(json);
    var list = jsonD["result"];
    switch (listInfoItem.itemId) {
      case ItemId.Versions:
        var itemsList = listInfoItem.createListFromWifiJson(list[0] as List);
        listInfoItem.updateItem(itemsList);
        break;
      case ItemId.MethodTypes:
        list = jsonD["results"];
        var itemsList = listInfoItem.createListFromWifiJson(list as List);
        List<WebApiMethodValue> newList =
            new List<WebApiMethodValue>.from(listInfoItem.values);

        itemsList.forEach((element) {
          if (!listInfoItem.values.contains(element)) {
            newList.add(element);
          }
        });

        listInfoItem.updateItem(newList);
        break;
      case ItemId.AvailableSettings: //TODO for now only strings
        listInfoItem.updateItem(listInfoItem.createListFromWifiJson(list));
        break;
      case ItemId.ApplicationInfo:
      default:
        listInfoItem.updateItem(listInfoItem.createListFromWifiJson(list));
        break;
    }
  }
}
