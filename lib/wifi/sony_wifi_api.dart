import 'dart:math';

import 'package:cross_connectivity/cross_connectivity.dart';
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
import 'package:sonyalphacontrol/top_level_api/sony_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/wifi/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/wifi_connector.dart';

class SonyWifiApi extends ApiInterface {
  var _initialized = false;

  @override
  // TODO: implement initialized
  bool get initialized => _initialized;

  @override
  Future<bool> initialize() async {
    //nothing to initialize?
    _initialized = true;
    return _initialized;
  }

  @override
  Future<List<SonyCameraWifiDevice>> getAvailableCameras() async {
    var connectivityStatus = await Connectivity().checkConnectivity();
   // if(connectivityStatus == ConnectivityStatus.wifi){
    SonyCameraWifiDevice ionfo = await WifiConnector.getCamera();
      //we now its wifi so there can be some cameras
      //ping the device and check if it's there
  //  }
    return new List<SonyCameraWifiDevice>();
  }

  @override
  Future<bool> connectToCamera(SonyCameraDevice device) {
    // TODO: implement connectToCamera
    throw UnimplementedError();
  }

  @override
  Future<bool> capturePhoto(SonyCameraDevice device) {
    // TODO: implement capturePhoto
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<bool>> getAel(SonyCameraDevice device) {
    // TODO: implement getAel
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<AspectRatioId>> getAspectRatio(SonyCameraDevice device) {
    // TODO: implement getAspectRatio
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<AutoFocusStateId>> getAutoFocusState(
      SonyCameraDevice device) {
    // TODO: implement getAutoFocusState
    throw UnimplementedError();
  }

  @override
  Future<int> getBatteryPercentage(SonyCameraDevice device) {
    // TODO: implement getBatteryPercentage
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DriveModeId>> getDriveMode(SonyCameraDevice device) {
    // TODO: implement getDriveMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DroHdrId>> getDroHdr(SonyCameraDevice device) {
    // TODO: implement getDroHdr
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<double>> getEV(SonyCameraDevice device) {
    // TODO: implement getEV
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<int>> getFNumber(SonyCameraDevice device) {
    // TODO: implement getFNumber
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<bool>> getFel(SonyCameraDevice device) {
    // TODO: implement getFel
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FlashModeId>> getFlashMode(SonyCameraDevice device) {
    // TODO: implement getFlashMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusAreaId>> getFocusArea(SonyCameraDevice device) {
    // TODO: implement getFocusArea
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<Point<num>>> getFocusAreaSpot(SonyCameraDevice device) {
    // TODO: implement getFocusAreaSpot
    throw UnimplementedError();
  }

  @override
  Future<double> getFocusMagnifier(SonyCameraDevice device) {
    // TODO: implement getFocusMagnifier
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusMagnifierDirectionId>> getFocusMagnifierDirection(
      SonyCameraDevice device) {
    // TODO: implement getFocusMagnifierDirection
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusMagnifierPhaseId>> getFocusMagnifierPhase(
      SonyCameraDevice device) {
    // TODO: implement getFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusModeId>> getFocusMode(SonyCameraDevice device) {
    // TODO: implement getFocusMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ImageFileFormatId>> getImageFileFormat(
      SonyCameraDevice device) {
    // TODO: implement getImageFileFormat
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<int>> getIso(SonyCameraDevice device) {
    // TODO: implement getIso
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<MeteringModeId>> getMeteringMode(
      SonyCameraDevice device) {
    // TODO: implement getMeteringMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<PictureEffectId>> getPictureEffect(
      SonyCameraDevice device) {
    // TODO: implement getPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ShootingModeId>> getShootingMode(
      SonyCameraDevice device) {
    // TODO: implement getShootingMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<int>> getShutterSpeed(SonyCameraDevice device) {
    // TODO: implement getShutterSpeed
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceId>> getWhiteBalance(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalance
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceAbId>> getWhiteBalanceAb(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceAb
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<int>> getWhiteBalanceColorTemp(SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceColorTemp
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceGmId>> getWhiteBalanceGm(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceGm
    throw UnimplementedError();
  }

  @override
  Future<bool> pressShutter(
      ShutterPressType shutterPressType, SonyCameraDevice device) {
    // TODO: implement pressShutter
    throw UnimplementedError();
  }

  @override
  Future<bool> releaseShutter(
      ShutterPressType shutterPressType, SonyCameraDevice device) {
    // TODO: implement releaseShutter
    throw UnimplementedError();
  }

  @override
  Future<bool> setAel(bool value, SonyCameraDevice device) {
    // TODO: implement setAel
    throw UnimplementedError();
  }

  @override
  Future<bool> setAspectRatio(AspectRatioId value, SonyCameraDevice device) {
    // TODO: implement setAspectRatio
    throw UnimplementedError();
  }

  @override
  Future<bool> setDriveMode(DriveModeId value, SonyCameraDevice device) {
    // TODO: implement setDriveMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setDroHdr(DroHdrId value, SonyCameraDevice device) {
    // TODO: implement setDroHdr
    throw UnimplementedError();
  }

  @override
  Future<bool> setEV(int value, SonyCameraDevice device) {
    // TODO: implement setEV
    throw UnimplementedError();
  }

  @override
  Future<bool> setFNumber(int value, SonyCameraDevice device) {
    // TODO: implement setFNumber
    throw UnimplementedError();
  }

  @override
  Future<bool> setFel(bool value, SonyCameraDevice device) {
    // TODO: implement setFel
    throw UnimplementedError();
  }

  @override
  Future<bool> setFlashMode(FlashModeId value, SonyCameraDevice device) {
    // TODO: implement setFlashMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusArea(FocusAreaId value, SonyCameraDevice device) {
    // TODO: implement setFocusArea
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusAreaSpot(Point<num> value, SonyCameraDevice device) {
    // TODO: implement setFocusAreaSpot
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusDistance(int value, SonyCameraDevice device) {
    // TODO: implement setFocusDistance
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifier(double value, SonyCameraDevice device) {
    // TODO: implement setFocusMagnifier
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps, SonyCameraDevice device) {
    // TODO: implement setFocusMagnifierDirection
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifierPhase(
      FocusMagnifierPhaseId value, SonyCameraDevice device) {
    // TODO: implement setFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMode(FocusModeId value, SonyCameraDevice device) {
    // TODO: implement setFocusMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setImageFileFormat(
      ImageFileFormatId value, SonyCameraDevice device) {
    // TODO: implement setImageFileFormat
    throw UnimplementedError();
  }

  @override
  Future<bool> setIso(int value, SonyCameraDevice device) {
    // TODO: implement setIso
    throw UnimplementedError();
  }

  @override
  Future<bool> setMeteringMode(MeteringModeId value, SonyCameraDevice device) {
    // TODO: implement setMeteringMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setPictureEffect(
      PictureEffectId value, SonyCameraDevice device) {
    // TODO: implement setPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<bool> setSettingsRaw(int id, int value, SonyCameraDevice device) {
    // TODO: implement setSettingsRaw
    throw UnimplementedError();
  }

  @override
  Future<bool> setShutterSpeed(int value, SonyCameraDevice device) {
    // TODO: implement setShutterSpeed
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalance(WhiteBalanceId value, SonyCameraDevice device) {
    // TODO: implement setWhiteBalance
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceAb(
      WhiteBalanceAbId value, SonyCameraDevice device) {
    // TODO: implement setWhiteBalanceAb
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceColorTemp(int value, SonyCameraDevice device) {
    // TODO: implement setWhiteBalanceColorTemp
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceGm(
      WhiteBalanceGmId value, SonyCameraDevice device) {
    // TODO: implement setWhiteBalanceGm
    throw UnimplementedError();
  }

  @override
  Future<bool> startRecordingVideo(SonyCameraDevice device) {
    // TODO: implement startRecordingVideo
    throw UnimplementedError();
  }

  @override
  Future<bool> stopRecordingVideo(SonyCameraDevice device) {
    // TODO: implement stopRecordingVideo
    throw UnimplementedError();
  }
}
