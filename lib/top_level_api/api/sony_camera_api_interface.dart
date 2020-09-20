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
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/wifi/enums/force_update.dart';

import '../ids/setting_ids.dart';

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

  Stream<Image> streamLiveView(); //steps?

  startLiveView() {
    //TODO on usb running within update loop?
    //how to send changes?
  }

  ///usb so far
  Future<bool> setSettingsRaw(SettingsId id, int value);



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

  Future<SettingsItem<IntValue>> getFNumber({ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FNumber);

  //value -> up and down (1 or -1)
  Future<bool> setFNumber(int value);

  Future<SettingsItem<IntValue>> getIso({ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.ISO); //TODO is auto iso?
  Future<bool> setIso(int value); //TODO value or steps?

  Future<SettingsItem<IntValue>> getShutterSpeed({ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.ShutterSpeed);

  Future<bool> setShutterSpeed(int value);

  Future<int> getBatteryPercentage(
      {ForceUpdate update}); //TODO multiple batteries

  //Auto Exposure Level (lock/unlock)
  Future<SettingsItem<BoolValue>> getAel({update = ForceUpdate.IfNull}) async =>
      device.cameraSettings
          .getItem(SettingsId.AEL_State); //TODO differenc ael and ael state?

  Future<bool> setAel(bool value);

  //Flash Exposure Level (lock/unlock)
  Future<SettingsItem<BoolValue>> getFel({ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FEL);

  Future<bool> setFel(bool value);

  Future<SettingsItem<FocusAreaValue>> getFocusArea(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FocusArea);

  Future<bool> setFocusArea(FocusAreaId value);

  Future<SettingsItem<PointValue>> getFocusAreaSpot(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FocusAreaSpot);

  Future<bool> setFocusAreaSpot(Point value);

  Future<SettingsItem<AutoFocusStateValue>> getAutoFocusState(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.AutoFocusState);

  Future<SettingsItem<DoubleValue>> getEV({ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.EV);

  Future<bool> setEV(int value);

  Future<SettingsItem<FlashModeValue>> getFlashMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FlashMode);

  Future<bool> setFlashMode(FlashModeId value);

  Future<SettingsItem<IntValue>> getFlashValue({ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FlashValue);

  Future<bool> setFlashValue(int value);

  Future<SettingsItem<ImageFileFormatValue>> getImageFileFormat(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FileFormat);

  Future<bool> setImageFileFormat(ImageFileFormatId value);

  Future<SettingsItem<PictureEffectValue>> getPictureEffect(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.PictureEffect);

  Future<bool> setPictureEffect(PictureEffectId value);

  Future<SettingsItem<DroHdrValue>> getDroHdr({ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.DroHdr);

  Future<bool> setDroHdr(DroHdrId value);

  Future<SettingsItem<ImageSizeValue>> getImageSize(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.ImageSize);

  Future<bool> setImageSize(ImageSizeId value);

  Future<SettingsItem<AspectRatioValue>> getAspectRatio(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.AspectRatio);

  Future<bool> setAspectRatio(AspectRatioId value);

  Future<SettingsItem<FocusModeValue>> getFocusMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FocusMode);

  Future<bool> setFocusMode(FocusModeId value);

  Future<SettingsItem<FocusModeToggleValue>> getFocusModeToggle(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FocusModeToggleResponse);

  Future<bool> setFocusModeToggle(FocusModeToggleId value);

// TODO: If the steps value is larger than 7 then use a loop?
  Future<bool> setFocusDistance(int value);

  Future<SettingsItem<DriveModeValue>> getShootingMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.ShootingMode);

  Future<SettingsItem<WhiteBalanceValue>> getWhiteBalance(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.WhiteBalance);

  Future<bool> setWhiteBalance(WhiteBalanceId value);

  Future<SettingsItem<IntValue>> getWhiteBalanceColorTemp(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.WhiteBalanceColorTemp);

  Future<bool> setWhiteBalanceColorTemp(int value);

  Future<SettingsItem<WhiteBalanceAbValue>> getWhiteBalanceAb(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.WhiteBalanceAB);

  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value);

  Future<SettingsItem<WhiteBalanceGmValue>> getWhiteBalanceGm(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.WhiteBalanceGM);

  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value);

  Future<SettingsItem<DriveModeValue>> getDriveMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.DriveMode);

  Future<bool> setDriveMode(DriveModeId value);

  Future<SettingsItem<MeteringModeValue>> getMeteringMode(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.MeteringMode);

  Future<bool> setMeteringMode(MeteringModeId value);

  Future<SettingsItem<FocusMagnifierDirectionValue>> getFocusMagnifierDirection(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FocusMagnifier);

  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps); //move with steps?

  Future<SettingsItem<FocusMagnifierPhaseValue>> getFocusMagnifierPhase(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FocusMagnifierPhase);

  Future<bool> setFocusMagnifierPhase(FocusMagnifierPhaseId value);

  Future<SettingsItem<DoubleValue>> getFocusMagnifier(
          {ForceUpdate update}) async =>
      device.cameraSettings.getItem(SettingsId.FocusMagnifier);

  Future<bool> setFocusMagnifier(double value);
}

enum InterfaceType { Wifi_Interface, USB_Interface }

enum CameraStatusItemType {
  Battery_Status,
}

enum CameraSettingsItemType { FNumber_Settings }

enum CameraFunctionItemType { Capture_Function }

enum ShutterPressType { Half, Full, Both } //Any means both
