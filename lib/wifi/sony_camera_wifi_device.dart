
import 'package:sonyalphacontrol/top_level_api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/wifi/wifi_camera_xml.dart';

import 'camera_wifi_settings.dart';

class SonyCameraWifiDevice extends SonyCameraDevice {
  SonyCameraWifiDevice(String name, WifiCameraXML info)
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
