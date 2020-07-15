import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_service_type.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';
import 'package:sonyalphacontrol/wifi/wifi_commands.dart';
import 'package:sonyalphacontrol/wifi/wifi_connector.dart';

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
  @override
  Future<bool> connectCamera(SonyCameraDevice sonyCameraDevice) async {
    //SonyWebApiMethod GET
    //SettingsId versions
    //ServiceType -> für url
    //WebApiVersion  1.0
    //params []
    WifiCommand.createCommand(SonyWebApiMethod.GET, SettingsId.Versions,
        SonyWebApiServiceType.CAMERA, WebApiVersion.V_1_0, []).send(sonyCameraDevice)
        .then((value) => print(value));
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
}
