//store connected device
//store settings
//send things

import 'package:flutterusb/UsbDevice.dart';
import 'package:sonyalphacontrol/api/camera_settings.dart';

class SonyCamera {
  UsbDevice device;
  CameraSettings cameraSettings = new CameraSettings();

  SonyCamera(this.device);

  void updateSettings() {
    cameraSettings.update();
  }

  void startAutoUpdate() async {
    while (true) {
      await new Future.delayed(
          const Duration(milliseconds: 5000), () => cameraSettings.update());
    }
  }
}
