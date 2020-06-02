import 'package:flutterusb/UsbDevice.dart';
import 'package:sonyalphacontrol/top_level_api/api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/api/camera_usb_settings.dart';

class SonyCameraUsbDevice extends SonyCameraDevice {
  final UsbDevice device;

  SonyCameraUsbDevice(this.device)
      : super(device.name, new CameraUsbSettings());

  @override
  InterfaceType get interfaceType => InterfaceType.USB_Interface;
}
