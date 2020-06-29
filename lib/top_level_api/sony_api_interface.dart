import 'dart:math';

import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_direction_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/top_level_api/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';

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

  ///usb so far

  Future<bool> updateSettings(SonyCameraDevice device) =>
      device.cameraSettings.update();
  Future<bool> setSettingsRaw(int id, int value, SonyCameraDevice device);

  Future<bool> capturePhoto(SonyCameraDevice device); //TODO return foto?

  Future<bool> pressShutter(ShutterPressType shutterPressType, SonyCameraDevice device); //TODO half and full
  Future<bool> releaseShutter(ShutterPressType shutterPressType, SonyCameraDevice device);

  Future<bool> startRecordingVideo(SonyCameraDevice device);
  Future<bool> stopRecordingVideo(SonyCameraDevice device);

  Future<SettingsItem<int>> getFNumber(SonyCameraDevice device);
  Future<bool> setFNumber(int value, SonyCameraDevice device);

  Future<SettingsItem<int>> getIso(SonyCameraDevice device); //TODO is auto iso?
  Future<bool> setIso(int value, SonyCameraDevice device); //TODO value or steps?


  Future<SettingsItem<int>> getShutterSpeed(SonyCameraDevice device);
  Future<bool> setShutterSpeed(int value, SonyCameraDevice device);

  Future<int> getBatteryPercentage(SonyCameraDevice device); //TODO multiple batteries

  //Auto Exposure Level (lock/unlock)
  Future<SettingsItem<bool>> getAel(SonyCameraDevice device);
  Future<bool> setAel(bool value, SonyCameraDevice device);

  //Flash Exposure Level (lock/unlock)
  Future<SettingsItem<bool>> getFel(SonyCameraDevice device);
  Future<bool> setFel(bool value, SonyCameraDevice device);

  Future<SettingsItem<FocusAreaId>> getFocusArea(SonyCameraDevice device);
  Future<bool> setFocusArea(FocusAreaId value, SonyCameraDevice device);

  Future<SettingsItem<Point>> getFocusAreaSpot(SonyCameraDevice device);
  Future<bool> setFocusAreaSpot(Point value, SonyCameraDevice device);

  Future<SettingsItem<AutoFocusStateId>> getAutoFocusState(SonyCameraDevice device);

  Future<SettingsItem<double>> getEV(SonyCameraDevice device);
  Future<bool> setEV(int value, SonyCameraDevice device);

  Future<SettingsItem<FlashModeId>> getFlashMode(SonyCameraDevice device);
  Future<bool> setFlashMode(FlashModeId value, SonyCameraDevice device);

  Future<SettingsItem<ImageFileFormatId>> getImageFileFormat(SonyCameraDevice device);
  Future<bool> setImageFileFormat(ImageFileFormatId value, SonyCameraDevice device);

  Future<SettingsItem<PictureEffectId>> getPictureEffect(SonyCameraDevice device);
  Future<bool> setPictureEffect(PictureEffectId value, SonyCameraDevice device);

  Future<SettingsItem<DroHdrId>> getDroHdr(SonyCameraDevice device);
  Future<bool> setDroHdr(DroHdrId value, SonyCameraDevice device);

  Future<SettingsItem<AspectRatioId>> getAspectRatio(SonyCameraDevice device);
  Future<bool> setAspectRatio(AspectRatioId value, SonyCameraDevice device);

  Future<SettingsItem<FocusModeId>> getFocusMode(SonyCameraDevice device);
  Future<bool> setFocusMode(FocusModeId value, SonyCameraDevice device);

// TODO: If the steps value is larger than 7 then use a loop?
  Future<bool> setFocusDistance(int value, SonyCameraDevice device);

  Future<SettingsItem<ShootingModeId>> getShootingMode(SonyCameraDevice device);

  Future<SettingsItem<WhiteBalanceId>> getWhiteBalance(SonyCameraDevice device);
  Future<bool> setWhiteBalance(WhiteBalanceId value, SonyCameraDevice device);

  Future<SettingsItem<int>> getWhiteBalanceColorTemp(SonyCameraDevice device);
  Future<bool> setWhiteBalanceColorTemp(int value, SonyCameraDevice device);

  Future<SettingsItem<WhiteBalanceAbId>> getWhiteBalanceAb(SonyCameraDevice device);
  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value, SonyCameraDevice device);

  Future<SettingsItem<WhiteBalanceGmId>> getWhiteBalanceGm(SonyCameraDevice device);
  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value, SonyCameraDevice device);

  Future<SettingsItem<DriveModeId>> getDriveMode(SonyCameraDevice device);
  Future<bool> setDriveMode(DriveModeId value, SonyCameraDevice device);

  Future<SettingsItem<MeteringModeId>> getMeteringMode(SonyCameraDevice device);
  Future<bool> setMeteringMode(MeteringModeId value, SonyCameraDevice device);

  Future<SettingsItem<FocusMagnifierDirectionId>> getFocusMagnifierDirection(SonyCameraDevice device);
  Future<bool> setFocusMagnifierDirection(FocusMagnifierDirectionId value, int steps, SonyCameraDevice device); //move with steps?

  Future<SettingsItem<FocusMagnifierPhaseId>> getFocusMagnifierPhase(SonyCameraDevice device);
  Future<bool> setFocusMagnifierPhase(FocusMagnifierPhaseId value, SonyCameraDevice device);

  Future<double> getFocusMagnifier(SonyCameraDevice device);
  Future<bool> setFocusMagnifier(double value, SonyCameraDevice device); //steps?


///wifi
/*
audio recording
audi orecording setting
auto power off
beep mode
bulb shooting
camera function
camera setuo
color setting
cont shoot mde
cont shoot speed
dare time
delete contentx
event notification
exposure compensation
exposure mode
flash mode
flip setting
f number
focus mode
half press shutter
interval still recording
interval time
irremotecontrol
iso speed rate
live view
livewviewframe
live view size
loop recording
loop recording time
movei file format
movei waulity
movie recording
post view image size
program shirft
remove plaback
scene seleciton
self timer
server information
shoot mode
shutter speed
silent shooting setting
steady mode
still caputre
still quality
still size
storage infor
touch af position
tracking focus
transferring images
tv color system
view angle
white balance
wind noise reduction
zoom
zoom setting
 */

}

enum InterfaceType { Wifi_Interface, USB_Interface }

enum CameraStatusItemType {
  Battery_Status,
}

enum CameraSettingsItemType { FNumber_Settings }

enum CameraFunctionItemType { Capture_Function }

enum ShutterPressType{ Half, Full, Both } //Any means both
