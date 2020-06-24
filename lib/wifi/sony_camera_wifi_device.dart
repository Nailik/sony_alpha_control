
import 'package:sonyalphacontrol/top_level_api/sony_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';

import 'camera_wifi_settings.dart';

class SonyCameraWifiDevice extends SonyCameraDevice {
  SonyCameraWifiDevice(String name, WifiCameraInfo info)
      : super(name, new CameraWifiSettings());

  @override
  InterfaceType get interfaceType => InterfaceType.Wifi_Interface;
}

class WifiCameraInfo {
  String usn;
  String uuid;
  String location;
  String server;
  String st;

  WifiCameraInfo(this.usn, this.uuid, this.location, this.server, this.st);
}
