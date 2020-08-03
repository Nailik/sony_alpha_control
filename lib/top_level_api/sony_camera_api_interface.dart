import 'dart:math';

import 'package:sonyalphacontrol/top_level_api/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_direction_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/record_video_state_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/top_level_api/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/wifi/enums/force_update.dart';

import 'ids/setting_ids.dart';

abstract class CameraApiInterface {
  SonyCameraDevice cameraDevice;

  SonyCameraDevice get device;

  CameraApiInterface(this.cameraDevice);

  //camera has status items we can read
  final List<CameraStatusItemType> _availableStatusItems =
      new List(); //TODO different for cameras?!

  List<CameraStatusItemType> get availableStatusItems => _availableStatusItems;

  //camera has settings items we can change
  final List<CameraSettingsItemType> _availableSettingsItems = new List();

  List<CameraSettingsItemType> get availableSettingsItems =>
      _availableSettingsItems;

  //camera has functions we can trigger
  final List<CameraFunctionItemType> _availableFunctionItems = new List();

  List<CameraFunctionItemType> get availableFunctionItems =>
      _availableFunctionItems;

  startLiveView() {
    //TODO on usb running within update loop?
    //how to send changes?
  }

  ///usb so far
  Future<bool> setSettingsRaw(SettingsId id, int value);

  Future<List<CameraImage>> capturePhoto(); //TODO return foto?
  Future<bool> getPhotoAvailable();

  Future<CameraImageRequest> requestPhotoAvailable({bool liveView = false});

  Future<bool> pressShutter(
      ShutterPressType shutterPressType); //TODO half and full
  Future<bool> releaseShutter(ShutterPressType shutterPressType);

  Future<bool> startRecordingVideo();

  Future<bool> stopRecordingVideo();

  Future<RecordVideoStateValue> getRecordingVideoState(
      {update = ForceUpdate.Off});

  Future<bool> startRecordingAudio();

  Future<bool> stopRecordingAudio();

  Future<bool> setRecordingAudio(String audioRecordingSetting);

  Future<SettingsItem<StringValue>> getRecordingAudio();

  Future<SettingsItem<IntValue>> getFNumber();

  Future<bool> setFNumber(int value);

  Future<SettingsItem<IntValue>> getIso(); //TODO is auto iso?
  Future<bool> setIso(int value); //TODO value or steps?

  Future<SettingsItem<IntValue>> getShutterSpeed();

  Future<bool> setShutterSpeed(int value);

  Future<int> getBatteryPercentage(); //TODO multiple batteries

  //Auto Exposure Level (lock/unlock)
  Future<SettingsItem<BoolValue>> getAel();

  Future<bool> setAel(bool value);

  //Flash Exposure Level (lock/unlock)
  Future<SettingsItem<BoolValue>> getFel();

  Future<bool> setFel(bool value);

  Future<SettingsItem<FocusAreaValue>> getFocusArea();

  Future<bool> setFocusArea(FocusAreaId value);

  Future<SettingsItem<PointValue>> getFocusAreaSpot();

  Future<bool> setFocusAreaSpot(Point value);

  Future<SettingsItem<AutoFocusStateValue>> getAutoFocusState();

  Future<SettingsItem<DoubleValue>> getEV();

  Future<bool> setEV(int value);

  Future<SettingsItem<FlashModeValue>> getFlashMode();

  Future<bool> setFlashMode(FlashModeId value);

  Future<SettingsItem<IntValue>> getFlashValue();

  Future<bool> setFlashValue(int value);

  Future<SettingsItem<ImageFileFormatValue>> getImageFileFormat();

  Future<bool> setImageFileFormat(ImageFileFormatId value);

  Future<SettingsItem<PictureEffectValue>> getPictureEffect();

  Future<bool> setPictureEffect(PictureEffectId value);

  Future<SettingsItem<DroHdrValue>> getDroHdr();

  Future<bool> setDroHdr(DroHdrId value);

  Future<SettingsItem<ImageSizeValue>> getImageSize();

  Future<bool> setImageSize(ImageSizeId value);

  Future<SettingsItem<AspectRatioValue>> getAspectRatio();

  Future<bool> setAspectRatio(AspectRatioId value);

  Future<SettingsItem<FocusModeValue>> getFocusMode();

  Future<bool> setFocusMode(FocusModeId value);

  Future<SettingsItem<FocusModeToggleValue>> getFocusModeToggle();

  Future<bool> setFocusModeToggle(FocusModeToggleId value);

// TODO: If the steps value is larger than 7 then use a loop?
  Future<bool> setFocusDistance(int value);

  Future<SettingsItem<ShootingModeValue>> getShootingMode();

  Future<SettingsItem<WhiteBalanceValue>> getWhiteBalance();

  Future<bool> setWhiteBalance(WhiteBalanceId value);

  Future<SettingsItem<IntValue>> getWhiteBalanceColorTemp();

  Future<bool> setWhiteBalanceColorTemp(int value);

  Future<SettingsItem<WhiteBalanceAbValue>> getWhiteBalanceAb();

  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value);

  Future<SettingsItem<WhiteBalanceGmValue>> getWhiteBalanceGm();

  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value);

  Future<SettingsItem<DriveModeValue>> getDriveMode();

  Future<bool> setDriveMode(DriveModeId value);

  Future<SettingsItem<MeteringModeValue>> getMeteringMode();

  Future<bool> setMeteringMode(MeteringModeId value);

  Future<SettingsItem<FocusMagnifierDirectionValue>>
      getFocusMagnifierDirection();

  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps); //move with steps?

  Future<SettingsItem<FocusMagnifierPhaseValue>> getFocusMagnifierPhase();

  Future<bool> setFocusMagnifierPhase(FocusMagnifierPhaseId value);

  Future<SettingsItem<DoubleValue>> getFocusMagnifier();

  Future<bool> setFocusMagnifier(double value); //steps?

  ///when the camera is connected it's possible to read the "Available" items, this represents what the camera can do, not whats currently at the moment is supported
/*
  static List<CameraStatusItemType> get availableStatusItems =>
      api.availableStatusItems;

  static List<CameraSettingsItemType> get availableSettingsItems =>
      api.availableSettingsItems;

  static List<CameraFunctionItemType> get availableFunctionItems =>
      api.availableFunctionItems;

  static Future<bool> updateSettings() => api.updateSettings(_connectedCamera);

  ///this loop will update the camera status, current available items and current available settings
  static Future<bool> startUpdateLoop() =>
      api.startUpdateLoop(_connectedCamera);

  ///this will start live view loop
  static Future<bool> startLiveView() => api.startLiveView();
*/

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

enum ShutterPressType { Half, Full, Both } //Any means both
