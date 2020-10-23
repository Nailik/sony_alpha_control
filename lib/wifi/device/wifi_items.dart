import 'dart:convert';

import 'package:sonyalphacontrol/sonyalphacontrol.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';

//when checkAvailability flag is true make call automatically
bool autoUpdate = true;

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
      print("Uninmplemented AspectRatio ImageSize");
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

  update(dynamic data, SonyCameraWifiDevice device) {
    List<Value> availableList;
    Value current;

    switch (itemId) {
      case ItemId.ImageSize:
        //"type", "checkAvailability", "currentAspect","currentSize"
        //"checkAvailability" If true, the client should check the change of
        // available parameters by calling
        // "getAvailableStillSize".
        print("Uninmplemented ImageSize");
        //TODO call if check availabilty?
        break;
      case ItemId.WhiteBalanceMode:
        //"type", "checkAvailability", "currentWhiteBalanceMode","currentColorTemperature"
        //"checkAvailability" If true, the client should check the change of
        // available parameters by calling
        // "getAvailableWhiteBalance"".
        //also sets color
        SettingsItem<WhiteBalanceModeValue> settingsItemWhiteBalance =
            device.cameraSettings.whiteBalanceMode;
        settingsItemWhiteBalance.updateCurrentItem(Value.fromWifi(itemId, data["currentWhiteBalanceMode"]));

        //colorTemperature
        SettingsItem<WhiteBalanceColorTempValue> settingsItemColorTemp =
            device.cameraSettings.whiteBalanceColorTemp;
        settingsItemColorTemp.updateCurrentItem(Value.fromWifi(itemId, data["currentColorTemperature"]));

        if(autoUpdate && data["checkAvailability"] == true){
          device.api.getWhiteBalanceMode(update: ForceUpdate.Available);
        }
        break;
      case ItemId.ExposureCompensation:
        List<EvValue> listOfValues = getEvList(
            data["minExposureCompensation"], data["maxExposureCompensation"], data["stepIndexOfExposureCompensation"]);
        updateItem((data["currentExposureCompensation"]), listOfValues, supported);
        break;
      case ItemId.MeteringMode:
        //TODO metering exposure mode
        break;
      case ItemId.ProgramShift:
        updateItem(BoolValue(data["isShifted"]), this.available, this.supported);
        break;
      case ItemId.ZoomSetting:
        availableList = createListFromWifiJson(data["candidate"]);
        current = Value.fromWifi(itemId, data["zoom"]);
        break;
      case ItemId.FlipSetting:
        availableList = createListFromWifiJson(data["candidate"]);
        current = Value.fromWifi(itemId, data["flip"]);
        break;
      case ItemId.SceneSelection:
        availableList = createListFromWifiJson(data["candidate"]);
        current = Value.fromWifi(itemId, data["scene"]);
        break;
      case ItemId.ContShootingUrlSet:
      //"type", "contShootingUrl" [{"postviewUrl" , "thumbnailUrl"}]
        break;
      case ItemId.ImageSize:
      case ItemId.ContShootingMode:
      case ItemId.ContShootingSpeed:
      case ItemId.ColorSetting:
      case ItemId.MovieFileFormat:
      case ItemId.InfraredRemoteControl:
      case ItemId.TvColorSystem:
      case ItemId.TrackingFocus:
      case ItemId.AutoPowerOff:
      case ItemId.LoopRecordingTime:
      case ItemId.AudioRecording:
      case ItemId.WindNoiseReduction:
      //"type", "stillQuality" (itemId.wifiValue), "candidate"
        availableList = createListFromWifiJson(data["candidate"]);
        current = Value.fromWifi(itemId, data[itemId.wifiValue]);
        break;
      case ItemId.BeepMode:
      case ItemId.CameraFunction:
      case ItemId.MovieQuality:
      case ItemId.SteadyMode:
      case ItemId.ViewAngle:
      case ItemId.PostViewImageSize:
      case ItemId.SelfTimer:
      case ItemId.ShootMode:
      case ItemId.FlashMode:
      case ItemId.FNumber:
      case ItemId.FocusMode:
      case ItemId.IsoSpeedRate:
      case ItemId.ShutterSpeed:
      default:
      //"type", "current"(itemId.wifiValue), (itemId.wifiValue)"Candidates"
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

extension InfoItemExtension on InfoItem {
  update(dynamic data, SonyCameraWifiDevice sonyCameraWifiDevice) {
    switch (itemId) {
      case ItemId.BatteryInfo:
        print("Uninmplemented BatteryInfo");
      //TODO
      //"type", "batteryInfo" [{"batteryID" , "status", "additionalStatus", "levelNumer", "levelDenom", "description" st}]
        break;
      case ItemId.CameraFunctionResult:
      //"cameraFunctionResult"
      //Result of setting camera function.
      // "Success" - Success.
      // "Failure" - Failed to changing function.
        updateItem(Value.fromWifi(itemId, data["cameraFunctionResult"] == "Success"));
        break;
      case ItemId.FocusState:
      //"focusStatus"
        updateItem(Value.fromWifi(itemId, data["focusStatus"]));
        break;
      case ItemId.FocusAreaSpot: //touchAFPosition
      print("Uninmplemented FocusAreaSpot");
      //"currentSet" Set or not.
      // true: Touch AF is set and focused successfully.
      // false: Touch AF is not set or failed to focus

      //"currentTouchCoordinates"
      //double-array
      // Touch coordinates.
      // This parameter is reserved and the camera will
      // return empty array.
      //TODO
        break;
      case ItemId.TrackingFocusState:
      //"trackingFocusStatus"
        updateItem(Value.fromWifi(itemId, data["trackingFocusStatus"]));
        break;
      case ItemId.IntervalTime:
      //"type", "intervalTimeSec", "candidate"
        break;
      case ItemId.RecordingTime:
      //"type", "recordingTime"
        updateItem(Value.fromWifi(itemId, data["recordingTime"]));
        break;
      case ItemId.NumberOfShots:
      //"type", "numberOfShots"
        updateItem(Value.fromWifi(itemId, data["numberOfShots"]));
        break;
    }
  }
}

extension ListInfoItemExtension on ListInfoItem {
  update(dynamic data, SonyCameraWifiDevice sonyCameraWifiDevice) {
    switch (itemId) {
      case ItemId.AvailableFunctions2:
        print("Uninmplemented AvailableFunctions2");
      //"type", names"
      //TODO
        break;
      case ItemId.CameraStatus: //"cameraStatus"
        print("Uninmplemented CameraStatus");
        break;
      case ItemId.LiveViewStatus: //"liveviewStatus"
      print("Uninmplemented LiveViewStatus");
      //TODO
      //"type", "...status"
        break;
      case ItemId.LiveViewOrientation: //"liveviewOrientation"
        print("Uninmplemented LiveViewOrientation");
      //TODO
        break;
      case ItemId.CapturePhoto: //"takePictureUrl"
        print("Uninmplemented CapturePhoto");
      //"type", "...status"
      //TODO
        break;
      case ItemId.StorageInformation:
        print("Uninmplemented StorageInformation");
      //"type", "storageID", "recordTarget", "numberOfRecordableImages" , "recordableTime","storageDescription"
      //TODO
        break;
      case ItemId.ZoomInformation:
        print("Uninmplemented ZoomInformation");
      //TODO
        break;
    }
  }
}