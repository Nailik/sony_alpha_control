import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';

extension SettingsItemExtension on SettingsItem {
  updateSupported(String json, SonyCameraWifiDevice sonyCameraWifiDevice) {
    var jsonD = jsonDecode(json);
    var list = jsonD["result"];

    switch (itemId) {
      case ItemId.ExposureCompensation:
        //special case
        //0: int[] upper limit
        //1: int[] lower limit
        //2 int[] 1: 1/3 EV  2: 1/2 EV  0: invalid
        List<EvValue> listOfValues = new List();
        for (int index = 0; index < list[2].length; index++) {
          listOfValues.addAll(getEvList(list[1][index], list[0][index], list[2][index]));
        }

        updateItem(value, available, listOfValues);
        break;
      case ItemId.WhiteBalanceMode:
        List<WhiteBalanceColorTempValue> supportedColorTempList = List<WhiteBalanceColorTempValue>();
        List<WhiteBalanceColorTempValue> availableColorTempList = List<WhiteBalanceColorTempValue>();

        //colorTemperature
        SettingsItem<WhiteBalanceColorTempValue> settingsItemColorTemp =
            sonyCameraWifiDevice.cameraSettings.whiteBalanceColorTemp;

        updateItem(
            value,
            available,
            list[0].map<WhiteBalanceModeValue>((e) {
              var value = WhiteBalanceModeValue.fromWifiValue(
                  e["whiteBalanceMode"], !(e["colorTemperatureRange"]?.isEmpty ?? true));
              if (value.hasColorTemps) {
                for (int i = e["colorTemperatureRange"][1];
                    i <= e["colorTemperatureRange"][0];
                    i += e["colorTemperatureRange"][2]) {
                  supportedColorTempList.add(WhiteBalanceColorTempValue(i, value.id));
                  if (value.id == value?.id) {
                    availableColorTempList.add(WhiteBalanceColorTempValue(i, value.id));
                  }
                }
              }
              return value;
            }).toList());

        settingsItemColorTemp.updateItem(
            settingsItemColorTemp.value, settingsItemColorTemp.available, availableColorTempList);
        break;
      case ItemId.ZoomSetting:
      case ItemId.SilentShooting:
      case ItemId.ContShootingSpeed:
      case ItemId.ContShootingMode:
        updateItem(value, available, createListFromWifiJson(list[0]["candidate"] as List));
        break;
      case ItemId.ImageSize:
      case ItemId.AspectRatio:
        updateItem(value, available, createListFromWifiJson(list[0] as List));
        break;
      default:
        updateItem(value, available, createListFromWifiJson(list[0] as List));
        break;
    }
  }

  //TODO no current = null = unsupported at the moment? (eg when flash is inside)
  updateAvailable(String json, SonyCameraWifiDevice sonyCameraWifiDevice) {
    var jsonD = jsonDecode(json);
    var list = jsonD["result"];

    switch (itemId) {
      case ItemId.ExposureCompensation:
        //special case
        List<EvValue> listOfValues = getEvList(list[2], list[1], list[3]);
        updateItem(listOfValues.elementAt(list[0] + (list[2]).abs()), listOfValues, supported);
        break;
      case ItemId.WhiteBalanceMode:
        List<WhiteBalanceColorTempValue> supportedColorTempList = List<WhiteBalanceColorTempValue>();
        List<WhiteBalanceColorTempValue> availableColorTempList = List<WhiteBalanceColorTempValue>();
        Value currentWhiteBalance =
            WhiteBalanceModeValue.fromWifiValue(list[0]["whiteBalanceMode"], list[0]["colorTemperature"] != -1);

        //colorTemperature
        SettingsItem<WhiteBalanceColorTempValue> settingsItemColorTemp =
            sonyCameraWifiDevice.cameraSettings.whiteBalanceColorTemp;

        updateItem(
            currentWhiteBalance,
            list[1].map<WhiteBalanceModeValue>((e) {
              var value = WhiteBalanceModeValue.fromWifiValue(
                  e["whiteBalanceMode"], !(e["colorTemperatureRange"]?.isEmpty ?? true));
              if (value.hasColorTemps) {
                for (int i = e["colorTemperatureRange"][1];
                    i <= e["colorTemperatureRange"][0];
                    i += e["colorTemperatureRange"][2]) {
                  supportedColorTempList.add(WhiteBalanceColorTempValue(i, value.id));
                  if (value.id == currentWhiteBalance.id) {
                    availableColorTempList.add(WhiteBalanceColorTempValue(i, value.id));
                  }
                }
              }
              return value;
            }).toList(),
            supported);

        settingsItemColorTemp.updateItem(
            WhiteBalanceColorTempValue(list[0]["colorTemperature"], currentWhiteBalance.id),
            availableColorTempList,
            settingsItemColorTemp.supported);
        break;
      case ItemId.ImageSize:
      case ItemId.AspectRatio:
        //TODO
        updateItem(Value.fromWifi(itemId, list[0]), createListFromWifiJson(list[1] as List), supported);
        break;
      case ItemId.ZoomSetting:
        updateItem(
            Value.fromWifi(itemId, list[0]["zoom"]), createListFromWifiJson(list[0]["candidate"] as List), supported);
        break;
      case ItemId.SilentShooting:
        updateItem(Value.fromWifi(itemId, list[0]["silentShooting"]),
            createListFromWifiJson(list[0]["candidate"] as List), supported);
        break;
      case ItemId.ContShootingMode:
        updateItem(Value.fromWifi(itemId, list[0]["contShootingMode"]),
            createListFromWifiJson(list[0]["candidate"] as List), supported);
        break;
      case ItemId.ContShootingSpeed:
        updateItem(Value.fromWifi(itemId, list[0]["contShootingSpeed"]),
            createListFromWifiJson(list[0]["candidate"] as List), supported);
        break;
      default:
        updateItem(Value.fromWifi(itemId, list[0]), createListFromWifiJson(list[1] as List), supported);
        break;
    }
  }

  update(dynamic data, SonyCameraWifiDevice sonyCameraWifiDevice) {
    List<Value> availableList;
    Value current;

    switch (itemId) {
      case ItemId.ExposureCompensation:
        //     availableList = getEvList(
        //       json["minExposureCompensation"], json["maxExposureCompensation"], json["stepIndexOfExposureCompensation"]);
        //     current = Value.fromWifi(settingsItem.itemId, json["currentExposureCompensation"]);
        break;
      default:
        availableList = createListFromWifiJson(data["${itemId.wifiValue}Candidates"]);
        current = Value.fromWifi(itemId, data["current${itemId.wifiValue.startCap}"]);
        break;
    }

    updateItem(current, availableList != null ? availableList : available, supported);
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
}
