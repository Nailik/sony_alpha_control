import 'package:sonyalphacontrol/top_level_api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
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

  @override
  Future<bool> connectCamera(SonyCameraDevice sonyCameraDevice) async {
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
