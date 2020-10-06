import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
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
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_api_method_set.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';

import 'force_update.dart';

abstract class CameraApiInterface {
  SonyCameraDevice cameraDevice;

  SonyCameraDevice get device;

  CameraApiInterface(this.cameraDevice);

  Stream<Image> streamLiveView(); //steps?

  startLiveView() {
    //TODO on usb running within update loop?
    //how to send changes?
  }

  ///server information

  ///This method checks teh available versions for the web api
  ///serviceTypeId means for which service
  ///forceupdate
  ///   IfNull/Available/Supported -> if a field is null it will be read from camera
  ///   Current/On -> will load even if field is set
  ///   Off -> will only give back
  Future<SettingsItem<WebApiVersionsValue>> getWebApiVersions(
      SonyWebApiServiceTypeId serviceTypeId,
      {ForceUpdate update}) async {
    switch (serviceTypeId) {
      case SonyWebApiServiceTypeId.CAMERA:
        return device.cameraSettings.versionsCamera;
      case SonyWebApiServiceTypeId.AV_CONTENT:
        return device.cameraSettings.versionsAvContent;
      case SonyWebApiServiceTypeId.SYSTEM:
        return device.cameraSettings.versionsSystem;
      case SonyWebApiServiceTypeId.GUIDE:
        return device.cameraSettings.versionsGuide;
      case SonyWebApiServiceTypeId.Unknown:
      default:
        throw UnsupportedError;
    }
  }

  //TODO web api version id unkown sollte bei sowas einen fehler werfen

  //eine speziell web api version ...nur letzte -> selbst machen
  //alle (wenn null)
  Future<SettingsItem<WebApiMethodValue>> getMethodTypes(
          {SonyWebApiServiceTypeId serviceTypeId,
          WebApiVersionId webApiVersion,
          ForceUpdate update}) async =>
      device.cameraSettings.methodTypes;

  /*
  Future<Map<SettingsId, List<SonyWebApiMethod>>> getAvailableApiList(

  //TODO together to get functions
  Future<List<CameraFunctionValue>> getSupportedFunctions(

  getAvailableFunctions(
*/

  ///usb so far
  Future<bool> setSettingsRaw(SettingsId id, int value);

  ///FNumber
  ///
  //Wifi checked
  Future<SettingsItem<DoubleValue>> getFNumber({ForceUpdate update}) async =>
      device.cameraSettings.fNumber;

  //value -> up and down (1 or -1)
  Future<bool> modifyFNumber(int direction);

  //only available on wifi
  Future<bool> setFNumber(DoubleValue value);

  ///Iso

  Future<SettingsItem<IsoValue>> getIso({ForceUpdate update}) async =>
      device.cameraSettings.iso;

  //TODO value or steps?
  Future<bool> modifyIso(int direction);

  Future<bool> setIso(IsoValue value);

  ///Shutter

  Future<SettingsItem<ShutterSpeedValue>> getShutterSpeed(
          {ForceUpdate update}) async =>
      device.cameraSettings.shutterSpeed;

  //value -> up and down (1 or -1)
  Future<bool> modifyShutterSpeed(int direction);

  Future<bool> setShutterSpeed(ShutterSpeedValue value);

  Future<SettingsItem<EvValue>> getEV({ForceUpdate update}) async =>
      device.cameraSettings.ev;

  ///EV

  //value -> up and down (1 or -1)
  Future<bool> modifyEV(int direction);

  Future<bool> setEV(EvValue value);

  ///Flash Mode

  Future<SettingsItem<FlashModeValue>> getFlashMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.flashMode;

  Future<bool> setFlashMode(FlashModeValue value);

  ///Focus Mode

  Future<SettingsItem<FocusModeValue>> getFocusMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.focusMode;

  Future<bool> setFocusMode(FocusModeValue value);

  ///WhiteBalance Mode

  Future<SettingsItem<WhiteBalanceModeValue>> getWhiteBalanceMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.whiteBalanceMode;

  Future<bool> setWhiteBalanceMode(WhiteBalanceModeValue value);

  ///WhiteBalance Color Temp

  Future<SettingsItem<WhiteBalanceColorTempValue>> getWhiteBalanceColorTemp(
          {ForceUpdate update}) async =>
      device.cameraSettings.whiteBalanceColorTemp;

  //value -> up and down (1 or -1)
  Future<bool> modifyWhiteBalanceColorTemp(int direction);

  Future<bool> setWhiteBalanceColorTemp(WhiteBalanceColorTempValue value);

  ///unchecked (wifi) *******************************************

  Future<List<CameraImage>> capturePhoto(); //TODO return foto?
  Future<bool> getPhotoAvailable({ForceUpdate update});

  Future<CameraImageRequest> requestPhotoAvailable({bool liveView = false});

  Future<bool> pressShutter(
      ShutterPressType shutterPressType); //TODO half and full
  Future<bool> releaseShutter(ShutterPressType shutterPressType);

  Future<bool> startRecordingVideo();

  Future<bool> stopRecordingVideo();

  Future<RecordVideoStateValue> getRecordingVideoState({ForceUpdate update});

  Future<bool> startRecordingAudio();

  Future<bool> stopRecordingAudio();

  Future<bool> setRecordingAudio(String audioRecordingSetting);

  Future<SettingsItem<StringValue>> getRecordingAudio({ForceUpdate update});

  Future<SettingsItem<MeteringModeValue>> getMeteringMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.meteringMode;

  Future<bool> setMeteringMode(MeteringModeValue value);

  Future<int> getBatteryPercentage(
      {ForceUpdate update}); //TODO multiple batteries

  //Auto Exposure Level (lock/unlock)
  Future<SettingsItem<BoolValue>> getAel({update = ForceUpdate.IfNull}) async =>
      device.cameraSettings.aelState; //TODO differenc ael and ael state?

  Future<bool> setAel(bool value);

  //Flash Exposure Level (lock/unlock)
  Future<SettingsItem<BoolValue>> getFel({ForceUpdate update}) async =>
      device.cameraSettings.fel;

  Future<bool> setFel(bool value);

  Future<SettingsItem<FocusAreaValue>> getFocusArea(
          {ForceUpdate update}) async =>
      device.cameraSettings.focusArea;

  Future<bool> setFocusArea(FocusAreaId value);

  Future<SettingsItem<PointValue>> getFocusAreaSpot(
          {ForceUpdate update}) async =>
      device.cameraSettings.focusAreaSpot;

  Future<bool> setFocusAreaSpot(Point value);

  Future<SettingsItem<AutoFocusStateValue>> getAutoFocusState(
          {ForceUpdate update}) async =>
      device.cameraSettings.autoFocusState;

  Future<SettingsItem<IntValue>> getFlashValue({ForceUpdate update}) async =>
      device.cameraSettings.flashValue;

  Future<bool> setFlashValue(int value);

  Future<SettingsItem<ImageFileFormatValue>> getImageFileFormat(
          {ForceUpdate update}) async =>
      device.cameraSettings.imageFileFormat;

  Future<bool> setImageFileFormat(ImageFileFormatValue value);

  Future<SettingsItem<PictureEffectValue>> getPictureEffect(
          {ForceUpdate update}) async =>
      device.cameraSettings.pictureEffect;

  Future<bool> setPictureEffect(PictureEffectId value);

  Future<SettingsItem<DroHdrValue>> getDroHdr({ForceUpdate update}) async =>
      device.cameraSettings.droHdr;

  Future<bool> setDroHdr(DroHdrId value);

  Future<SettingsItem<ImageSizeValue>> getImageSize(
          {ForceUpdate update}) async =>
      device.cameraSettings.imageSize;

  Future<bool> setImageSize(ImageSizeId value);

  Future<SettingsItem<AspectRatioValue>> getAspectRatio(
          {ForceUpdate update}) async =>
      device.cameraSettings.aspectRatio;

  Future<bool> setAspectRatio(AspectRatioId value);

  Future<SettingsItem<FocusModeToggleValue>> getFocusModeToggle(
          {ForceUpdate update}) async =>
      device.cameraSettings.focusModeToggleResponse;

  Future<bool> setFocusModeToggle(FocusModeToggleId value);

// TODO: If the steps value is larger than 7 then use a loop?
  Future<bool> setFocusDistance(int value);

  Future<SettingsItem<DriveModeValue>> getShootingMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.shootingMode;

  Future<SettingsItem<WhiteBalanceAbValue>> getWhiteBalanceAb(
          {ForceUpdate update}) async =>
      device.cameraSettings.whiteBalanceAB;

  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value);

  Future<SettingsItem<WhiteBalanceGmValue>> getWhiteBalanceGm(
          {ForceUpdate update}) async =>
      device.cameraSettings.whiteBalanceGM;

  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value);

  Future<SettingsItem<DriveModeValue>> getDriveMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem<DriveModeValue>(SettingsId.DriveMode);

  Future<bool> setDriveMode(DriveModeId value);

  Future<SettingsItem<FocusMagnifierDirectionValue>> getFocusMagnifierDirection(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem<FocusMagnifierDirectionValue>(
          SettingsId.FocusMagnifierDirection);

  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps); //move with steps?

  Future<SettingsItem<FocusMagnifierPhaseValue>> getFocusMagnifierPhase(
          {ForceUpdate update}) async =>
      device.cameraSettings
          .getItem<FocusMagnifierPhaseValue>(SettingsId.FocusMagnifierPhase);

  Future<bool> setFocusMagnifierPhase(FocusMagnifierPhaseId value);

  Future<SettingsItem<DoubleValue>> getFocusMagnifier(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem<DoubleValue>(SettingsId.FocusMagnifier);

  Future<bool> setFocusMagnifier(double value);
}

enum InterfaceType { Wifi_Interface, USB_Interface }

enum ShutterPressType { Half, Full, Both } //Any means both
