import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/usb/api/sony_camera_usb_api.dart';
import 'package:sonyalphacontrol/wifi/api/sony_camera_wifi_api.dart';

import 'camera_settings.dart';

abstract class SonyCameraDevice<T extends CameraSettings> {
  final String? name;

  SonyCameraWifiApi? _wifiApi;
  SonyCameraUsbApi? _usbApi;

  get wifiApi => _wifiApi;

  get usbApi => _usbApi;

  SonyCameraDevice(this.name) {
    this.cameraSettings = createSettings();
  }

  T createSettings();

  InterfaceType get interfaceType;

  late T cameraSettings;

  //TODO mode (important)

  //TODO get transfer

//  CameraTransferInterface get content{

  //}

  CameraApiInterface? get api {
    switch (interfaceType) {
      case InterfaceType.Wifi_Interface:
        if (_wifiApi == null) {
          _wifiApi = SonyCameraWifiApi(this);
        }
        return _wifiApi;
      case InterfaceType.USB_Interface:
        if (_usbApi == null) {
          _usbApi = SonyCameraUsbApi(this);
        }
        return _usbApi;
      default:
        return null;
    }
  }

  Future<bool> updateSettings() => cameraSettings.update();

  startUpdateLoop() async {
    //TODO how to update frontend?
    while (true) {
      await new Future.delayed(
          const Duration(milliseconds: 5000), () => cameraSettings.update());
    }
  }
}
