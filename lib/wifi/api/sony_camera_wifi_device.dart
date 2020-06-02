import 'package:sonyalphacontrol/top_level_api/api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/wifi/api/camera_wifi_settings.dart';

class SonyCameraWifiDevice extends SonyCameraDevice {
  SonyCameraWifiDevice(String name) : super(name, new CameraWifiSettings());

  @override
  InterfaceType get interfaceType => InterfaceType.Wifi_Interface;
}
