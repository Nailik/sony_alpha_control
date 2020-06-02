import 'package:sonyalphacontrol/top_level_api/api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/camera_settings.dart';

abstract class SonyCameraDevice {
  final String name;

  SonyCameraDevice(this.name, this.cameraSettings);

  InterfaceType get interfaceType;

  final CameraSettings cameraSettings;
}
