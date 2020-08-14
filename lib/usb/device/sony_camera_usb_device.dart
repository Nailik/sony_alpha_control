import 'package:flutter_usb/UsbDevice.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';

import 'camera_usb_settings.dart';

class SonyCameraUsbDevice extends SonyCameraDevice<CameraUsbSettings> {
  final UsbDevice device;

  SonyCameraUsbDevice(this.device) : super(device.name);

  @override
  InterfaceType get interfaceType => InterfaceType.USB_Interface;

  @override
  CameraUsbSettings createSettings() => CameraUsbSettings();
}
