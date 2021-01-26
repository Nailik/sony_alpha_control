//import 'package:flutter_usb/UsbDevice.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/api/sony_camera_usb_api.dart';

import 'camera_usb_settings.dart';

class SonyCameraUsbDevice extends SonyCameraDevice<CameraUsbSettings> {
  //final UsbDevice device;

  SonyCameraUsbApi? _wifiApi;

  CameraApiInterface get api => _wifiApi ??= new SonyCameraUsbApi(this);

  SonyCameraUsbDevice(/*this.device*/) : super("fakename");

  @override
  InterfaceType get interfaceType => InterfaceType.USB_Interface;

  @override
  CameraUsbSettings createSettings() => CameraUsbSettings();
}
