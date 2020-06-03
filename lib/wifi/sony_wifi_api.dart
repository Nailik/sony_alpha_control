import 'package:sonyalphacontrol/top_level_api/api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/wifi/sony_camera_wifi_device.dart';

class SonyWifiApi extends ApiInterface {
  var _initialized = false;

  @override
  // TODO: implement initialized
  bool get initialized => _initialized;

  @override
  Future<bool> initialize() async {
    //nothing to initialize?
    _initialized = true;
    throw UnimplementedError();
  }

  @override
  Future<List<SonyCameraWifiDevice>> getAvailableCameras() {
    // TODO: implement getAvailableCameras5
    throw UnimplementedError();
  }

  @override
  Future<bool> connectToCamera(SonyCameraDevice device) {
    // TODO: implement connectToCamera
    throw UnimplementedError();
  }

  @override
  Future<bool> setSettingsRaw(int id, int value, SonyCameraDevice device) {
    //i need:
    //value: as string eventually also version and api Group
    //id: as string

    throw UnimplementedError();
  }
}
