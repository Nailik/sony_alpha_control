import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/settigns_item.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';

import 'ids/aspect_ratio_ids.dart';

abstract class ApiInterface {
  bool get initialized;

  Future<bool> initialize();

  Future<List<SonyCameraDevice>> getAvailableCameras();

  Future<bool> connectToCamera(SonyCameraDevice device);

  //camera has status items we can read
  final List<CameraStatusItemType> _availableStatusItems = new List(); //TODO different for cameras?!

  List<CameraStatusItemType> get availableStatusItems => _availableStatusItems;

  //camera has settings items we can change
  final List<CameraSettingsItemType> _availableSettingsItems = new List();

  List<CameraSettingsItemType> get availableSettingsItems =>
      _availableSettingsItems;

  //camera has functions we can trigger
  final List<CameraFunctionItemType> _availableFunctionItems = new List();

  List<CameraFunctionItemType> get availableFunctionItems =>
      _availableFunctionItems;

  Future<bool> update(SonyCameraDevice device) =>
      device.cameraSettings.update();

  startUpdateLoop(SonyCameraDevice device) async {
    //TODO how to update frontend?
    while (true) {
      await new Future.delayed(const Duration(milliseconds: 5000),
          () => device.cameraSettings.update());
    }
  }

  startLiveView() {
    //TODO on usb running within update loop?
    //how to send changes?
  }

  Future<bool> setSettingsRaw(int id, int value, SonyCameraDevice device);

  Future<bool> setAspectRatio(AspectRatioId value);
  Future<SettingsItem<AutoFocusStateId>> getAutoFocusState(); //current, available, and all
  Future<bool> setDriveMode(DriveModeId value);
}

enum InterfaceType { Wifi_Interface, USB_Interface }

enum CameraStatusItemType {
  Battery_Status,
}

enum CameraSettingsItemType { FNumber_Settings }

enum CameraFunctionItemType { Capture_Function }
