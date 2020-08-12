import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
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
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/enums/force_update.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_api_method_set.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_service_type.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';

class SonyCameraWifiApi extends CameraApiInterface {
  SonyCameraWifiDevice get device => cameraDevice;

  SonyCameraWifiApi(SonyCameraDevice cameraDevice) : super(cameraDevice);

  @override
  Future<List<CameraImage>> capturePhoto() {
    // TODO: implement capturePhoto
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<BoolValue>> getAel() {
    // TODO: implement getAel
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<AspectRatioValue>> getAspectRatio() {
    // TODO: implement getAspectRatio
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<AutoFocusStateValue>> getAutoFocusState() {
    // TODO: implement getAutoFocusState
    throw UnimplementedError();
  }

  @override
  Future<int> getBatteryPercentage() {
    // TODO: implement getBatteryPercentage
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DriveModeValue>> getDriveMode() {
    // TODO: implement getDriveMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DroHdrValue>> getDroHdr() {
    // TODO: implement getDroHdr
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DoubleValue>> getEV() {
    // TODO: implement getEV
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getFNumber() {
    // TODO: implement getFNumber
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<BoolValue>> getFel() {
    // TODO: implement getFel
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FlashModeValue>> getFlashMode() {
    // TODO: implement getFlashMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getFlashValue() {
    // TODO: implement getFlashValue
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusAreaValue>> getFocusArea() {
    // TODO: implement getFocusArea
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<PointValue>> getFocusAreaSpot() {
    // TODO: implement getFocusAreaSpot
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DoubleValue>> getFocusMagnifier() {
    // TODO: implement getFocusMagnifier
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusMagnifierDirectionValue>>
      getFocusMagnifierDirection() {
    // TODO: implement getFocusMagnifierDirection
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusMagnifierPhaseValue>> getFocusMagnifierPhase() {
    // TODO: implement getFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusModeValue>> getFocusMode() {
    // TODO: implement getFocusMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusModeToggleValue>> getFocusModeToggle() {
    // TODO: implement getFocusModeToggle
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ImageFileFormatValue>> getImageFileFormat() {
    // TODO: implement getImageFileFormat
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ImageSizeValue>> getImageSize() {
    // TODO: implement getImageSize
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getIso() {
    // TODO: implement getIso
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<MeteringModeValue>> getMeteringMode() {
    // TODO: implement getMeteringMode
    throw UnimplementedError();
  }

  @override
  Future<bool> getPhotoAvailable() {
    // TODO: implement getPhotoAvailable
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<PictureEffectValue>> getPictureEffect() {
    // TODO: implement getPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ShootingModeValue>> getShootingMode() {
    // TODO: implement getShootingMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getShutterSpeed() {
    // TODO: implement getShutterSpeed
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceValue>> getWhiteBalance() {
    // TODO: implement getWhiteBalance
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceAbValue>> getWhiteBalanceAb() {
    // TODO: implement getWhiteBalanceAb
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getWhiteBalanceColorTemp() {
    // TODO: implement getWhiteBalanceColorTemp
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceGmValue>> getWhiteBalanceGm() {
    // TODO: implement getWhiteBalanceGm
    throw UnimplementedError();
  }

  @override
  Future<bool> pressShutter(ShutterPressType shutterPressType) {
    // TODO: implement pressShutter
    throw UnimplementedError();
  }

  @override
  Future<bool> releaseShutter(ShutterPressType shutterPressType) {
    // TODO: implement releaseShutter
    throw UnimplementedError();
  }

  @override
  Future<CameraImageRequest> requestPhotoAvailable({bool liveView = false}) {
    // TODO: implement requestPhotoAvailable
    throw UnimplementedError();
  }

  @override
  Future<bool> setAel(bool value) {
    // TODO: implement setAel
    throw UnimplementedError();
  }

  @override
  Future<bool> setAspectRatio(AspectRatioId value) {
    // TODO: implement setAspectRatio
    throw UnimplementedError();
  }

  @override
  Future<bool> setDriveMode(DriveModeId value) {
    // TODO: implement setDriveMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setDroHdr(DroHdrId value) {
    // TODO: implement setDroHdr
    throw UnimplementedError();
  }

  @override
  Future<bool> setEV(int value) {
    // TODO: implement setEV
    throw UnimplementedError();
  }

  @override
  Future<bool> setFNumber(int value) {
    // TODO: implement setFNumber
    throw UnimplementedError();
  }

  @override
  Future<bool> setFel(bool value) {
    // TODO: implement setFel
    throw UnimplementedError();
  }

  @override
  Future<bool> setFlashMode(FlashModeId value) {
    // TODO: implement setFlashMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setFlashValue(int value) {
    // TODO: implement setFlashValue
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusArea(FocusAreaId value) {
    // TODO: implement setFocusArea
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusAreaSpot(Point<num> value) {
    // TODO: implement setFocusAreaSpot
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusDistance(int value) {
    // TODO: implement setFocusDistance
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifier(double value) {
    // TODO: implement setFocusMagnifier
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps) {
    // TODO: implement setFocusMagnifierDirection
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifierPhase(FocusMagnifierPhaseId value) {
    // TODO: implement setFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMode(FocusModeId value) =>
      WifiCommand.createCommand(SonyWebApiMethod.SET, SettingsId.FocusMode)
          .send(device);

  @override
  Future<bool> setFocusModeToggle(FocusModeToggleId value) {
    // TODO: implement setFocusModeToggle
    throw UnimplementedError();
  }

  @override
  Future<bool> setImageFileFormat(ImageFileFormatId value) {
    // TODO: implement setImageFileFormat
    throw UnimplementedError();
  }

  @override
  Future<bool> setImageSize(ImageSizeId value) {
    // TODO: implement setImageSize
    throw UnimplementedError();
  }

  @override
  Future<bool> setIso(int value) =>
      WifiCommand.createCommand(SonyWebApiMethod.SET, SettingsId.ISO,
          params: [value]).send(device);

  @override
  Future<bool> setMeteringMode(MeteringModeId value) =>
      WifiCommand.createCommand(SonyWebApiMethod.SET, SettingsId.MeteringMode,
          params: [value.wifiValue]).send(device);

  @override
  Future<bool> setPictureEffect(PictureEffectId value) {
    // TODO: implement setPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<bool> setSettingsRaw(SettingsId id, int value) {
    // TODO: implement setSettingsRaw
    throw UnimplementedError();
  }

  @override
  Future<bool> setShutterSpeed(int value) =>
      WifiCommand.createCommand(SonyWebApiMethod.SET, SettingsId.ShutterSpeed,
          params: [value]).send(device);

  @override
  Future<bool> setWhiteBalance(WhiteBalanceId value) =>
      WifiCommand.createCommand(SonyWebApiMethod.SET, SettingsId.WhiteBalance,
          params: [value.wifiValue]).send(device);

  @override
  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value) {
    // TODO: implement setWhiteBalanceAb
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceColorTemp(int value) {
    // TODO: implement setWhiteBalanceColorTemp
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value) {
    // TODO: implement setWhiteBalanceGm
    throw UnimplementedError();
  }

  @override
  Future<bool> startRecordingVideo() =>
      WifiCommand.createCommand(SonyWebApiMethod.START, SettingsId.RecordVideo)
          .send(device);

  @override
  Future<bool> stopRecordingVideo() =>
      WifiCommand.createCommand(SonyWebApiMethod.STOP, SettingsId.RecordVideo)
          .send(device);

  /// This API provides a function to start audio recording.
  ///
  ///
  /// This API instructs the server side to start audio recording.
  /// When this API is called and the server starts audio recording,
  /// the camera status will change as follows.
  /// The camera status can be obtained by [EventNotificationApi.getEvent].
  ///
  ///
  /// [Client calls this]
  ///
  ///
  /// Camera status: [CameraShootingStatusParam.IDLE] <br></br>
  /// -> [CameraShootingStatusParam.AudioWaitRecStart] <br></br>
  /// -> [CameraShootingStatusParam.AudioRecording].
  ///
  ///
  /// After the recording has started, the client may stop the recording.
  /// To stop the recording, [.stopAudioRec] must be called,
  /// and the camera status will change as follows.
  ///
  ///
  /// [Client calls [.stopAudioRec]]
  ///
  ///
  /// Camera status: [CameraShootingStatusParam.AudioRecording]
  /// -> [CameraShootingStatusParam.AudioWaitRecStop]
  /// -> [CameraShootingStatusParam.AudioSaving]
  /// -> [CameraShootingStatusParam.IDLE].
  ///
  ///
  /// Note that this sequence is the example of typical case.
  ///
  ///
  /// The client should check the [EventNotificationApi.getEvent]
  /// parameter ([Event.cameraStatus]) and check if it is [CameraShootingStatusParam.IDLE]
  /// before calling this.
  ///
  ///
  /// This API is only available when the shoot mode is [ShootModeParam.Audio].
  ///
  ///
  /// Note that the server may disable the liveview function when the
  /// shoot mode is [ShootModeParam.Audio].
  /// The client should check liveview availability by [Event.liveViewStatus] of
  /// [EventNotificationApi.getEvent].
  /// The APIs availability will also be changed.
  /// The client should check the APIs availability by available API list.
  /// When the client switches the shoot mode from [ShootModeParam.Audio] to others,
  /// the client can restart the liveview by calling [LiveViewApi.startLiveView].
  ///
  ///
  /// @return see [ApiCallSet]
  @override
  Future<bool> startRecordingAudio() => WifiCommand.createCommand(
          SonyWebApiMethod.START, SettingsId.AudioRecording)
      .send(device);

  /// This API provides a function to stop audio recording.
  ///
  ///
  /// This API is only available when the shoot mode is [ShootModeParam.Audio].
  /// Even if this API is successful, the server may not be ready to start the next recording.
  /// The next recording is prohibited until the client could make sure,
  /// that the server is ready to start the next recording, through the
  /// [EventNotificationApi.getEvent] callback parameter [Event.cameraStatus].
  ///
  ///
  /// @return see [ApiCallSet]
  @override
  Future<bool> stopRecordingAudio() => WifiCommand.createCommand(
          SonyWebApiMethod.STOP, SettingsId.AudioRecording)
      .send(device);

  /// This API provides a function to set a value of audio recording setting.
  ///
  ///
  /// Even if the response is successful, the setting may not be finished on the server.
  /// Therefore, the client can check [Event.audioRecordingSetting] result in
  /// [EventNotificationApi.getEvent] callback to recognize the timing of a change
  /// in the parameter of the server.
  ///
  ///
  /// @param audioRecordingSetting Audio recording setting
  /// (See Audio recording setting parameters of Parameter description)
  /// @return see [ApiCallSet]
  @override
  Future<bool> setRecordingAudio(String audioRecordingSetting) =>
      WifiCommand.createCommand(SonyWebApiMethod.SET, SettingsId.AudioRecording,
          params: [audioRecordingSetting]).send(device);

  @override
  Future<SettingsItem<StringValue>> getRecordingAudio() {
    // TODO: implement setFocusMode
    throw UnimplementedError();
  }

  @override
  Future<RecordVideoStateValue> getRecordingVideoState(
      {update = ForceUpdate.Off}) {
    // TODO: implement getRecordingVideoState
    throw UnimplementedError();
  }

  @override
  Stream<Image> streamLiveView() {
    // TODO: implement streamLiveView
    throw UnimplementedError();
  }
//  WifiCommand.createCommand(SonyWebApiMethod.SET, SettingsId.AudioRecording,
//  params: [audioRecordingSetting]).send(device);
}
