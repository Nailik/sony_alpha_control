import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/ids/camera_function_id.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_connector.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_api_method_set.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';

class SonyWifiApi extends SonyApiInterface {
  var _initialized = false;

  @override
  // TODO: implement initialized
  bool get initialized => _initialized;

  @override
  Future<bool> initialize() async {
    _initialized = true;
    return _initialized;
  }

  @override
  Future<List<SonyCameraDevice>> getAvailableCameras() async {
    var list = await WifiConnector.getCamera();
    if (list != null) {
      return [list];
    }
    return List<SonyCameraDevice>();
  }

  @override
  Future<bool> connectCamera(SonyCameraDevice device) async {
    var versions = await getWebApiVersions(device);
    var methods = await getMethodTypes(WebApiVersion.V_1_4, device);

    var supported = await getSupportedFunctions(WebApiVersion.V_1_4, device);
    var available = await getAvailableFunctions(WebApiVersion.V_1_4, device);

    var functionSettings = SettingsItem<SettingsValue<CameraFunctionId>>(
        SettingsId.CameraFunction);

    functionSettings.updateItem(
        available.key, functionSettings.subValue, available.value, supported);

    //TODO wait until start content transfer / remote shooting is available

    startConnection(device);

    var apiList = await getAvailableApiList( device); //available api (all methods of this camera in current Function)
    await device.updateSettings();

    WifiCameraFunctionality(versions, methods, apiList,
        functionSettings); //TODO save in device and maybe update
    return true;
  }

  Future<List<WebApiVersion>> getWebApiVersions(
      SonyCameraWifiDevice device) async {
    var list = List<WebApiVersion>();
    await WifiCommand.createCommand(SonyWebApiMethod.GET, SettingsId.Versions)
        .send(device)
        .then((value) => (jsonDecode(value.response)["result"][0] as List)
                ?.forEach((element) {
              list.add(WebApiVersionExtension.fromWifiValue(element));
            }));
    return list;
  }

  Future<List<WebApiMethod>> getMethodTypes(
      WebApiVersion webApiVersion, SonyCameraWifiDevice device) async {
    var list = List<WebApiMethod>();
    await WifiCommand.createCommand(
            SonyWebApiMethod.GET, SettingsId.MethodTypes,
            params: [webApiVersion.wifiValue])
        .send(device)
        .then((value) =>
            (jsonDecode(value.response)["results"] as List)?.forEach((element) {
              list.add(WebApiMethod.fromJson(element as List));
            }));
    return list;
  }

  //currently available functions
  Future<Map<SettingsId, List<SonyWebApiMethod>>> getAvailableApiList(
      SonyCameraWifiDevice device) async {
    var list = Map<SettingsId, List<SonyWebApiMethod>>();
    await WifiCommand.createCommand(
            SonyWebApiMethod.GET_AVAILABLE, SettingsId.ApiList)
        .send(device)
        .then((value) => (jsonDecode(value.response)["result"][0] as List)
                ?.forEach((element) {
              MapEntry<SettingsId, SonyWebApiMethod> entry =
                  const SettingsIdConverter().fromJson(element);
              //TODO WhiteBalance means there is also WhiteBalanceColorTemp
              if (list.containsKey(entry.key)) {
                var item = list.entries
                    .firstWhere((element) => element.key == entry.key);
                item.value.add(entry.value);
                list.update(entry.key, (value) => item.value);
              } else {
                list.putIfAbsent(entry.key, () => [entry.value]);
              }
            }));
    return list;
  }

  Future<List<CameraFunctionValue>> getSupportedFunctions(
      WebApiVersion version, SonyCameraWifiDevice device) async {
    var webResponse = await WifiCommand.createCommand(
            SonyWebApiMethod.GET_SUPPORTED, SettingsId.CameraFunction)
        .send(device);
    var jsonD = jsonDecode(webResponse.response)["result"];

    var list = List<CameraFunctionValue>();
    (jsonD[0] as List<dynamic>)?.forEach((element) {
      list.add(CameraFunctionValue.fromWifiValue(element));
    });

    return list;
  }

  Future<MapEntry<CameraFunctionValue, List<CameraFunctionValue>>>
      getAvailableFunctions(
          WebApiVersion version, SonyCameraWifiDevice device) async {
    var webResponse = await WifiCommand.createCommand(
            SonyWebApiMethod.GET_AVAILABLE, SettingsId.CameraFunction)
        .send(device);
    var jsonD = jsonDecode(webResponse.response)["result"];

    var list =
        List<CameraFunctionValue>(); //TODO 0 returns "Other Function"????

    (jsonD[1] as List<dynamic>)?.forEach((element) {
      list.add(CameraFunctionValue.fromWifiValue(element));
    });

    return MapEntry(
        CameraFunctionValue.fromWifiValue(jsonD[0] as String), list);
  }

  Future<bool> startConnection(SonyCameraWifiDevice device) async {
    var webResponse = await WifiCommand.createCommand(
            SonyWebApiMethod.START, SettingsId.CameraSetup)
        .send(device);
    //[0] if success
    return jsonDecode(webResponse.response)["0"] == 0;
  }
}
