import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_connector.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
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
      return {list}.toList();
    }
    return List<SonyCameraDevice>();
  }

  @override
  Future<bool> connectCamera(SonyCameraDevice device) async {
    getWebApiVersions(device);
    await Future<void>.delayed(Duration(seconds: 1));

    getMethodTypes(WebApiVersion.V_1_4, device);
    await Future<void>.delayed(Duration(seconds: 1));

    getSettings(WebApiVersion.V_1_4, true, device);
    await Future<void>.delayed(Duration(seconds: 1));

    getSupportedFunctions(WebApiVersion.V_1_4, device);
    await Future<void>.delayed(Duration(seconds: 1));

    getAvailableFunctions(WebApiVersion.V_1_4, device);
    await Future<void>.delayed(Duration(seconds: 1));

    getAvailableApiList(device);
    await Future<void>.delayed(Duration(seconds: 1));

    startConnection(device);
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

  Future<String> getMethodTypes(
      WebApiVersion webApiVersion, SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.MethodTypes,
        params: [webApiVersion.wifiValue]).send(device);
    //TODO
    print(json);
  }

  Future<List<MapEntry<String, SettingsId>>> getAvailableApiList(
      SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.GET, SettingsId.AvailableApiList)
        .send(device);
    //decode
    print(json);
    //TODO
  }

  Future<String> getSettings(WebApiVersion version, bool longPolling,
      SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.AvailableSettings,
        params: [longPolling]).send(device, timeout: 80000);
    //TODO
    print(json);
  }

  Future<List<String>> getSupportedFunctions(
      WebApiVersion version, SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.GET_SUPPORTED, SettingsId.CameraFunction)
        .send(device);
    //TODO
    print(json);
  }

  Future<List<String>> getAvailableFunctions(
      WebApiVersion version, SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.GET_AVAILABLE, SettingsId.CameraFunction)
        .send(device);
    //TODO
    print(json);
  }

  Future<List<String>> startConnection(SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.START, SettingsId.CameraSetup)
        .send(device);
    //TODO
    print(json);
  }
}
