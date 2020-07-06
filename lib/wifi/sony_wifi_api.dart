import 'package:sonyalphacontrol/top_level_api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';

class SonyWifiApi extends SonyApiInterface {
  @override
  Future<bool> connectCamera(SonyCameraDevice sonyCameraDevice) {
    // TODO: implement connectCamera
    throw UnimplementedError();
  }

  @override
  Future<List<SonyCameraDevice>> getAvailableCameras() async {
    // TODO: implement getAvailableCameras
    return List();
  }

  @override
  Future<bool> initialize() async{
    // TODO: implement initialize
  }

  @override
  // TODO: implement initialized
  bool get initialized => false;
}
