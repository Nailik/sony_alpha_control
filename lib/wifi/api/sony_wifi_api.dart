import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
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
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.GET, SettingsId.Versions)
        .sendForResponse(device);
    //TODO
    print(json);
  }

  Future<String> getMethodTypes(
      WebApiVersion webApiVersion, SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.MethodTypes,
        params: [webApiVersion.wifiValue]).sendForResponse(device);
    //TODO
    print(json);
  }

  Future<List<MapEntry<String, SettingsId>>> getAvailableApiList(
      SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.GET, SettingsId.AvailableApiList)
        .sendForResponse(device);
    //decode
    var list = jsonDecode(json.response)["result"]["names"];
    //TODO
  }

  Future<String> getSettings(WebApiVersion version, bool longPolling,
      SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.AvailableSettings,
        params: [longPolling]).sendForResponse(device, timeout: 80000);
    //TODO
    print(json);
  }

  Future<List<String>> getSupportedFunctions(
      WebApiVersion version, SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.GET_SUPPORTED, SettingsId.CameraFunction)
        .sendForResponse(device);
    //TODO
    print(json);
  }

  Future<List<String>> getAvailableFunctions(
      WebApiVersion version, SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.GET_AVAILABLE, SettingsId.CameraFunction)
        .sendForResponse(device);
    //TODO
    print(json);
  }

  Future<List<String>> startConnection(SonyCameraWifiDevice device) async {
    var json = await WifiCommand.createCommand(
            SonyWebApiMethod.START, SettingsId.CameraSetup)
        .sendForResponse(device);
    //TODO
    print(json);
  }
}
