import 'package:flutter_usb/UsbDevice.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';

import 'camera_usb_settings.dart';

class SonyCameraUsbDevice extends SonyCameraDevice {
  final UsbDevice device;

  SonyCameraUsbDevice(this.device)
      : super(device.name, new CameraUsbSettings());

  @override
  InterfaceType get interfaceType => InterfaceType.USB_Interface;
}
