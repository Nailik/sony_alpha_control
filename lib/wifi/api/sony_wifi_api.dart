import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_connector.dart';
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

  //{"id":1,"method":"getMethodTypes","params":["1.0"],"version":"1.0"}
  //{"id":2,"method":"getEvent","params":[false],"version":"1.0"}
  //{"id":5,"method":"getAvailableApiList","params":[],"version":"1.0"}
  //{"id":6,"method":"startRecMode","params":[],"version":"1.0"}
  //{"id":7,"method":"getVersions","params":[],"version":"1.0"}
  //{"id":9,"method":"getEvent","params":[false],"version":"1.4"}
  //TODO doesnt work when avontent is missing
  // .add(CameraApi.serverInformationApi.getVersions(SonyWebApiServiceType.AV_CONTENT))

  @override
  Future<bool> connectCamera(SonyCameraDevice sonyCameraDevice) async {
    await WifiCommand.createCommand(SonyWebApiMethod.GET, SettingsId.Versions)
        .sendForResponse(sonyCameraDevice)
        .then((value) => writeToText("Versions", value));
    await Future<void>.delayed(Duration(seconds: 1));

    await WifiCommand.createCommand(
            SonyWebApiMethod.GET, SettingsId.MethodTypes,
            params: [WebApiVersion.V_1_4.wifiValue])
        .sendForResponse(sonyCameraDevice)
        .then((value) =>
            writeToText("MethodTypes${WebApiVersion.V_1_4.wifiValue}", value));
    await Future<void>.delayed(Duration(seconds: 1));

    await WifiCommand.createCommand(
            SonyWebApiMethod.GET, SettingsId.AvailableSettings, params: [true])
        .sendForResponse(sonyCameraDevice, timeout: 80000)
        .then((value) => writeToText(
            "AvailableSettings${WebApiVersion.V_1_4.wifiValue}", value));
    await Future<void>.delayed(Duration(seconds: 1));

    await WifiCommand.createCommand(
            SonyWebApiMethod.GET_SUPPORTED, SettingsId.CameraFunction)
        .sendForResponse(sonyCameraDevice)
        .then((value) => writeToText("AvailableFunctions", value));

    await WifiCommand.createCommand(
            SonyWebApiMethod.GET_AVAILABLE, SettingsId.CameraFunction)
        .sendForResponse(sonyCameraDevice)
        .then((value) => writeToText("SupportedFunctions", value));

    await WifiCommand.createCommand(
            SonyWebApiMethod.GET, SettingsId.AvailableApiList)
        .sendForResponse(sonyCameraDevice)
        .then((value) => writeToText("AvailableApiList", value));
    await Future<void>.delayed(Duration(seconds: 1));

    await WifiCommand.createCommand(
            SonyWebApiMethod.START, SettingsId.CameraSetup)
        .sendForResponse(sonyCameraDevice)
        .then((value) => writeToText("CameraSetup", value));

    //   var versions = await sonyCameraDevice.wifiApi.

    //var sonyApiMethodSet = await sonyCameraDevice.wifiApi.serverInformationApi(
    //    WebApiVersion.V_1_0, SonyWebApiServiceType.CAMERA);
    //  print(sonyApiMethodSet);
    /*
        apiCallMulti = ApiCallMulti.create()
                .add(CameraApi.serverInformationApi.getMethodTypes(
                        WebApiVersion.V_1_0,
                        SonyWebApiServiceType.CAMERA))
                .add(CameraApi.eventNotificationApi.getEvent(WebApiVersion.V_1_0, false))

                then    startCamera(connectionCallback, cameraDevice)
                or startOpenConnectionAfterChangeCameraState
     */
    //TODO connect
    return true;
  }

  writeToText(String fileName, WifiResponse text) async {
    Directory directory = await getApplicationDocumentsDirectory();
    var file = File('${directory.path}/${fileName}_request.json');
    await file.writeAsString(text.request);
    file = File('${directory.path}/${fileName}_response.json');
    await file.writeAsString(text.response);
  }

  //special things
  Future<SonyApiMethodSet> serverInformationApi(
      WebApiVersion version, SonyWebApiServiceType serviceType) {
    // WifiCommand(SonyWebApiMethod.GET, SettingsId.Connect, SonyWebApiServiceType.CAMERA, version, null);
    /*

        apiCallMulti = ApiCallMulti.create()
                .add(CameraApi.serverInformationApi.getMethodTypes(
                        WebApiVersion.V_1_0,
                        SonyWebApiServiceType.CAMERA))
                .add(CameraApi.eventNotificationApi.getEvent(WebApiVersion.V_1_0, false))

                then    startCamera(connectionCallback, cameraDevice)
                or startOpenConnectionAfterChangeCameraState
     */
  }

  Future<SettingsItem<BoolValue>> getAvailableApiList() {
    await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.AvailableApiList)
        .sendForResponse(sonyCameraDevice)
        .then((value) => writeToText("AvailableApiList", value));
    await Future<void>.delayed(Duration(seconds: 1));
  }

  Future<SettingsItem<BoolValue>> getApplicationInfo() {
    // TODO: implement getAel
    throw UnimplementedError();
  }

  Future<SettingsItem<BoolValue>> getWebApiVersions() {
    await WifiCommand.createCommand(SonyWebApiMethod.GET, SettingsId.Versions)
        .sendForResponse(sonyCameraDevice)
        .then((value) => writeToText("Versions", value));
    await Future<void>.delayed(Duration(seconds: 1));

  }

  Future<SettingsItem<BoolValue>> getMethodTypes() {
    await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.MethodTypes,
        params: [WebApiVersion.V_1_4.wifiValue])
        .sendForResponse(sonyCameraDevice)
        .then((value) =>
        writeToText("MethodTypes${WebApiVersion.V_1_4.wifiValue}", value));
    await Future<void>.delayed(Duration(seconds: 1));
  }


  Future<SettingsItem<BoolValue>> getSupportedFunctions() {
    await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.MethodTypes,
        params: [WebApiVersion.V_1_4.wifiValue])
        .sendForResponse(sonyCameraDevice)
        .then((value) =>
        writeToText("MethodTypes${WebApiVersion.V_1_4.wifiValue}", value));
    await Future<void>.delayed(Duration(seconds: 1));
  }

}
