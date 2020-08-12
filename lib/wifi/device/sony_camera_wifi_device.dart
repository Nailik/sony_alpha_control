import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_service_type.dart';
import 'package:sonyalphacontrol/wifi/xml/camera_web_api_service.dart';
import 'package:sonyalphacontrol/wifi/xml/wifi_camera_xml.dart';

import 'camera_wifi_settings.dart';

class SonyCameraWifiDevice extends SonyCameraDevice {
  WifiCameraXML info;

  SonyCameraWifiDevice(String name, this.info)
      : super(name, new CameraWifiSettings());

  @override
  InterfaceType get interfaceType => InterfaceType.Wifi_Interface;

  CameraWebApiService getWebApiService(SonyWebApiServiceType service) =>
      info.scalarWebApiDeviceInfo.serviceList.services
          .firstWhere((element) => element.type == service.wifiValue);
}

class WifiCameraInfo {
  String usn;
  String uuid;
  String location;
  String server;
  String st;

  WifiCameraInfo(this.usn, this.uuid, this.location, this.server, this.st);
}
