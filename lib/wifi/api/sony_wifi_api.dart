import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/usb/commands/downloader.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_connector.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_api_method_set.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_function_type.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_service_type.dart';
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
      return {list}.toList();
    }
    return List<SonyCameraDevice>();
  }

  @override
  Future<bool> connectCamera(SonyCameraDevice device) async {
    var versions = await getWebApiVersions(device);
    var methods = await getMethodTypes(WebApiVersion.V_1_4, device);
    var supported = await getSupportedFunctions(WebApiVersion.V_1_4, device);
    var available = await getAvailableFunctions(WebApiVersion.V_1_4, device);

    //TODO wait until start content transfer / remote shooting is available

    startConnection(device);

    var apiList = await getAvailableApiList(device); //available api (all methods of this camera in current Function)
    await device.updateSettings();

    WifiCameraFunctionality(versions, methods, apiList, supported, available); //TODO save in device and maybe update
    return true;
  }

  Future<List<WebApiVersion>> getWebApiVersions(
      SonyCameraWifiDevice device) async {
    var list = List<WebApiVersion>();
    await WifiCommand.createCommand(SonyWebApiMethod.GET, SettingsId.Versions)
        .send(device)
        .then((value) => (jsonDecode(value.response)["result"][0] as List)
                .forEach((element) {
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
            (jsonDecode(value.response)["results"] as List).forEach((element) {
              list.add(WebApiMethod.fromJson(element as List));
            }));
    return list;
  }

  //currently available functions
  //TODO SettingsId.AvailableApiList
  Future<Map<SettingsId, List<SonyWebApiMethod>>> getAvailableApiList(
      SonyCameraWifiDevice device) async {
    var list = Map<SettingsId, List<SonyWebApiMethod>>();
    await WifiCommand.createCommand(
            SonyWebApiMethod.GET, SettingsId.AvailableApiList)
        .send(device)
        .then((value) => (jsonDecode(value.response)["result"][0] as List)
                .forEach((element) {
              MapEntry<SettingsId, SonyWebApiMethod> entry =
                  const SettingsIdConverter().fromJson(element);
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

  //TODO SettingsId.AvailableApiList
  Future<MapEntry<SonyWebApiFunctionType, List<SonyWebApiFunctionType>>> getSupportedFunctions(
      WebApiVersion version, SonyCameraWifiDevice device) async {

    var webResponse = await WifiCommand.createCommand(
            SonyWebApiMethod.GET_SUPPORTED, SettingsId.CameraFunction)
        .send(device);
    var jsonD = jsonDecode(webResponse.response)["result"];

    var list = List<SonyWebApiFunctionType>();
    (jsonD[1] as List<dynamic>).forEach((element) {
      list.add(SonyWebApiFunctionTypeExtension.fromWifiValue(element));
    });

    return MapEntry(SonyWebApiFunctionTypeExtension.fromWifiValue(jsonD[0] as String), list);
  }

  //TODO also gives current
  Future<MapEntry<SonyWebApiFunctionType, List<SonyWebApiFunctionType>>> getAvailableFunctions(
      WebApiVersion version, SonyCameraWifiDevice device) async {

    var webResponse = await WifiCommand.createCommand(
        SonyWebApiMethod.GET_AVAILABLE, SettingsId.CameraFunction)
        .send(device);
    var jsonD = jsonDecode(webResponse.response)["result"];

    var list = List<SonyWebApiFunctionType>();
    (jsonD[1] as List<dynamic>).forEach((element) {
      list.add(SonyWebApiFunctionTypeExtension.fromWifiValue(element));
    });

    return MapEntry(SonyWebApiFunctionTypeExtension.fromWifiValue(jsonD[0] as String), list);
  }

  Future<List<String>> startConnection(SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.START, SettingsId.CameraSetup)
        .send(device);
    //TODO
    print(json);
  }
}
