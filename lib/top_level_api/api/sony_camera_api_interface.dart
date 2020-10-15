import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_direction_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';

import 'force_update.dart';
import 'function_availability.dart';

abstract class CameraApiInterface {
  SonyCameraDevice cameraDevice;

  SonyCameraDevice get device;

  CameraApiInterface(this.cameraDevice);

  Stream<Image> streamLiveView(); //steps?

  ///usb so far
  Future<bool> setSettingsRaw(ItemId id, int value);

  ///TODO like this and read itemId and apimethod and service through annotatin (1 or mutliple)
  ///TODO FunctionAvailability checkFunctionA(Function function);
  ///server information
  /////TODO usb

  ///more detailed .. supported?
  FunctionAvailability checkFunctionAvailability(ItemId itemId, ApiMethodId apiMethodId,
      {SonyWebApiServiceTypeId service = SonyWebApiServiceTypeId.CAMERA});

  ///This method checks teh available versions for the web api
  ///serviceTypeId means for which service
  ///ForceUpdate
  ///   IfNull/Available/Supported -> if a field is null it will be read from camera
  ///   Current/On -> will load even if field is set
  ///   //TODO separate functions for availability test
  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsCamera({ForceUpdate update}) async =>
      device.cameraSettings.versionsCamera;

  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsAvContent({ForceUpdate update}) async =>
      device.cameraSettings.versionsAvContent;

  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsSystem({ForceUpdate update}) async =>
      device.cameraSettings.versionsSystem;

  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsGuide({ForceUpdate update}) async =>
      device.cameraSettings.versionsGuide;

  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsAccessControl({ForceUpdate update}) async =>
      device.cameraSettings.versionsAccessControl;

  ///This method checks the available methods for the web api
  ///serviceTypeId means for which service
  ///ForceUpdate
  ///   IfNull/Available/Supported -> if a field is null it will be read from camera
  ///   Current/On -> will load even if field is set
  ///
  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesCamera(
          {WebApiVersionId webApiVersion, ForceUpdate update}) async =>
      device.cameraSettings.methodTypesCamera;

  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesAvContent(
          {WebApiVersionId webApiVersion, ForceUpdate update}) async =>
      device.cameraSettings.methodTypesAvContent;

  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesSystem(
          {WebApiVersionId webApiVersion, ForceUpdate update}) async =>
      device.cameraSettings.methodTypesSystem;

  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesGuide(
          {WebApiVersionId webApiVersion, ForceUpdate update}) async =>
      device.cameraSettings.methodTypesGuide;

  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesAccessControl(
          {WebApiVersionId webApiVersion, ForceUpdate update}) async =>
      device.cameraSettings.methodTypesAccessControl;

  ///Available Functions

  Future<ListInfoItem<ApiFunctionValue>> getAvailableFunctions({ForceUpdate update}) async =>
      device.cameraSettings.availableFunctions;

  ///Application Info

  Future<ListInfoItem<StringValue>> getApplicationInfo({ForceUpdate update}) async =>
      device.cameraSettings.applicationInfo;

  ///Camera Function

  Future<SettingsItem<CameraFunctionValue>> getCameraFunction({ForceUpdate update}) async =>
      device.cameraSettings.cameraFunction;

  Future<bool> setCameraFunction(CameraFunctionValue value);

  ///Capture Photo

  Future<ListInfoItem<StringValue>> actCapturePhoto();

  Future<ListInfoItem<StringValue>> awaitCapturePhoto();

  ///Camera Setup

  Future<bool> startRecMode();

  Future<bool> stopRecMode();

  ///long polling:
  ///Long polling flag
  ///true: Callback when timeout or change point detection.
  ///   to get callbacks when some settings change
  ///false: Callback immediately.
  ///   (useful for initialization and then call the other get methods to receive information missin)
  Future<ListInfoItem<StringValue>> getAvailableSettings(bool longPolling, {ForceUpdate update}) async =>
      device.cameraSettings.availableSettings;

  ///Shutter

  Future<SettingsItem<ShutterSpeedValue>> getShutterSpeed({ForceUpdate update}) async =>
      device.cameraSettings.shutterSpeed;

  //value -> up and down (1 or -1)
  Future<bool> modifyShutterSpeed(int direction);

  Future<bool> setShutterSpeed(ShutterSpeedValue value);

  ///Flash Mode

  Future<SettingsItem<FlashModeValue>> getFlashMode({ForceUpdate update}) async => device.cameraSettings.flashMode;

  Future<bool> setFlashMode(FlashModeValue value);

  ///Focus Mode

  Future<SettingsItem<FocusModeValue>> getFocusMode({ForceUpdate update}) async => device.cameraSettings.focusMode;

  Future<bool> setFocusMode(FocusModeValue value);

  ///Zoom Setting

  Future<SettingsItem<ZoomSettingValue>> getZoomSetting({ForceUpdate update}) async =>
      device.cameraSettings.zoomSetting;

  Future<bool> setZoomSetting(ZoomSettingValue value);

  ///Zoom

  //direction: in/out  movementparameter: start, stop, 1shot -> when started, has to bee stopped with same direction param
  //maybe only provide in,out with  oneshot or floating and onther stop method (and has to be stopped before value change?)
  // (handle start stop in api)
  Future<bool> actZoom(String direction, String movementparameter);

  ///Half Press Shutter

  Future<bool> actHalfPressShutter();

  Future<bool> cancelHalfPressShutter();

  ///Self Timer

  Future<SettingsItem<IntValue>> getSelfTimer({ForceUpdate update}) async => device.cameraSettings.selfTimer;

  Future<bool> setSelfTimer(IntValue value);

  ///Metering Mode

  Future<SettingsItem<MeteringModeValue>> getMeteringMode({ForceUpdate update}) async =>
      device.cameraSettings.meteringMode;

  Future<bool> setMeteringMode(MeteringModeValue value);

  ///EV

  Future<SettingsItem<EvValue>> getExposureCompensation({ForceUpdate update}) async =>
      device.cameraSettings.exposureCompensation;

  //value -> up and down (1 or -1)
  Future<bool> modifyExposureCompensation(int direction);

  Future<bool> setExposureCompensation(EvValue value);

  ///FNumber

  Future<SettingsItem<DoubleValue>> getFNumber({ForceUpdate update}) async => device.cameraSettings.fNumber;

  //value -> up and down (1 or -1)
  Future<bool> modifyFNumber(int direction);

  //only available on wifi
  Future<bool> setFNumber(DoubleValue value);

  ///Iso

  Future<SettingsItem<IsoValue>> getIso({ForceUpdate update}) async => device.cameraSettings.iso;

  Future<bool> modifyIso(int direction);

  Future<bool> setIso(IsoValue value);

  ///Live View Size

  Future<SettingsItem<LiveViewSizeValue>> getLiveViewSize({ForceUpdate update}) async =>
      device.cameraSettings.liveViewSize;

  Future<bool> startLiveViewWithSize(LiveViewSizeValue value);

  //TODO change (stop and restart)

  ///Post View Image Size

  Future<SettingsItem<PostViewImageSizeValue>> getPostViewImageSize({ForceUpdate update}) async =>
      device.cameraSettings.postViewImageSize;

  Future<bool> setPostViewImageSize(PostViewImageSizeValue value);

  ///Program Shift

  Future<SettingsItem<IntValue>> getProgramShift({ForceUpdate update}) async => device.cameraSettings.programShift;

  Future<bool> setProgramShift(IntValue value);

  ///WhiteBalance Mode

  Future<SettingsItem<WhiteBalanceModeValue>> getWhiteBalanceMode({ForceUpdate update}) async =>
      device.cameraSettings.whiteBalanceMode;

  Future<bool> setWhiteBalanceMode(WhiteBalanceModeValue value);

  ///WhiteBalance Color Temp

  Future<SettingsItem<WhiteBalanceColorTempValue>> getWhiteBalanceColorTemp({ForceUpdate update}) async =>
      device.cameraSettings.whiteBalanceColorTemp;

  //value -> up and down (1 or -1)
  Future<bool> modifyWhiteBalanceColorTemp(int direction);

  Future<bool> setWhiteBalanceColorTemp(WhiteBalanceColorTempValue value);

  ///Image File Format

  Future<SettingsItem<ImageFileFormatValue>> getImageFileFormat({ForceUpdate update}) async =>
      device.cameraSettings.imageFileFormat;

  Future<bool> setImageFileFormat(ImageFileFormatValue value);

  ///Silent Shooting

  Future<SettingsItem<OnOffValue>> getSilentShooting({ForceUpdate update}) async =>
      device.cameraSettings.silentShooting;

  Future<bool> setSilentShooting(OnOffValue value);

  ///Shoot Mode

  Future<SettingsItem<ShootModeValue>> getShootMode({ForceUpdate update}) async => device.cameraSettings.shootMode;

  Future<bool> setShootMode(ShootModeValue value);

  ///Continuous Shooting Mode

  Future<SettingsItem<ContShootingModeValue>> getContShootingMode({ForceUpdate update}) async =>
      device.cameraSettings.contShootingMode;

  Future<bool> setContShootingMode(ContShootingModeValue value);

  ///Continuous Shooting Speed

  Future<SettingsItem<ContShootingSpeedValue>> getContShootingSpeed({ForceUpdate update}) async =>
      device.cameraSettings.contShootingSpeed;

  Future<bool> setContShootingSpeed(ContShootingSpeedValue value);

  ///Continuous Shooting

  Future<bool> startContShooting();

  Future<bool> stopContShooting();

  ///Movie Rec

  Future<bool> startMovieRecording();

  Future<bool> stopMovieRecording();

  ///Audio Rec

  Future<bool> startAudioRecording();

  Future<bool> stopAudioRecording();

  ///Interval Still Recording

  Future<bool> startIntervalStillRecording();

  Future<bool> stopIntervalStillRecording();

  ///Interval Still Recording

  Future<bool> startLoopRecording();

  Future<bool> stopLoopRecording();

  ///Interval Still Recording

  Future<bool> startLiveView();

  Future<bool> stopLiveView();

  ///Image Size

  Future<SettingsItem<ImageSizeValue>> getImageSize({ForceUpdate update}) async => device.cameraSettings.imageSize;

  Future<bool> setImageSize(ImageSizeId value);

  ///Aspect Ratio

  Future<SettingsItem<AspectRatioValue>> getAspectRatio({ForceUpdate update}) async =>
      device.cameraSettings.aspectRatio;

  Future<bool> setAspectRatio(AspectRatioValue value);

  ///unchecked (wifi) *******************************************

  Future<List<CameraImage>> capturePhoto(); //TODO return foto?
  Future<bool> getPhotoAvailable({ForceUpdate update});

  Future<CameraImageRequest> requestPhotoAvailable({bool liveView = false});

  Future<bool> pressShutter(ShutterPressType shutterPressType); //TODO half and full
  Future<bool> releaseShutter(ShutterPressType shutterPressType);

  Future<RecordVideoStateValue> getRecordingVideoState({ForceUpdate update});

  Future<bool> setRecordingAudio(String audioRecordingSetting);

  Future<SettingsItem<StringValue>> getRecordingAudio({ForceUpdate update});

  Future<int> getBatteryPercentage({ForceUpdate update}); //TODO multiple batteries

  //Auto Exposure Level (lock/unlock)
  Future<SettingsItem<BoolValue>> getAel({update = ForceUpdate.IfNull}) async =>
      device.cameraSettings.aelState; //TODO differenc ael and ael state?

  Future<bool> setAel(bool value);

  //Flash Exposure Level (lock/unlock)
  Future<SettingsItem<BoolValue>> getFel({ForceUpdate update}) async => device.cameraSettings.fel;

  Future<bool> setFel(bool value);

  Future<SettingsItem<FocusAreaValue>> getFocusArea({ForceUpdate update}) async => device.cameraSettings.focusArea;

  Future<bool> setFocusArea(FocusAreaId value);

  Future<SettingsItem<PointValue>> getFocusAreaSpot({ForceUpdate update}) async => device.cameraSettings.focusAreaSpot;

  Future<bool> setFocusAreaSpot(Point value);

  Future<SettingsItem<AutoFocusStateValue>> getAutoFocusState({ForceUpdate update}) async =>
      device.cameraSettings.autoFocusState;

  Future<SettingsItem<IntValue>> getFlashValue({ForceUpdate update}) async => device.cameraSettings.flashValue;

  Future<bool> setFlashValue(int value);

  Future<SettingsItem<PictureEffectValue>> getPictureEffect({ForceUpdate update}) async =>
      device.cameraSettings.pictureEffect;

  Future<bool> setPictureEffect(PictureEffectId value);

  Future<SettingsItem<DroHdrValue>> getDroHdr({ForceUpdate update}) async => device.cameraSettings.droHdr;

  Future<bool> setDroHdr(DroHdrId value);


  Future<SettingsItem<FocusModeToggleValue>> getFocusModeToggle({ForceUpdate update}) async =>
      device.cameraSettings.focusModeToggleResponse;

  Future<bool> setFocusModeToggle(FocusModeToggleId value);

// TODO: If the steps value is larger than 7 then use a loop?
  Future<bool> setFocusDistance(int value);


  Future<SettingsItem<WhiteBalanceAbValue>> getWhiteBalanceAb({ForceUpdate update}) async =>
      device.cameraSettings.whiteBalanceAB;

  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value);

  Future<SettingsItem<WhiteBalanceGmValue>> getWhiteBalanceGm({ForceUpdate update}) async =>
      device.cameraSettings.whiteBalanceGM;

  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value);

  Future<SettingsItem<DriveModeValue>> getDriveMode({ForceUpdate update}) async => device.cameraSettings.driveMode;

  Future<bool> setDriveMode(DriveModeId value);

  Future<SettingsItem<FocusMagnifierDirectionValue>> getFocusMagnifierDirection({ForceUpdate update}) async =>
      device.cameraSettings.focusMagnifierDirection;

  Future<bool> setFocusMagnifierDirection(FocusMagnifierDirectionId value, int steps); //move with steps?

  Future<SettingsItem<FocusMagnifierPhaseValue>> getFocusMagnifierPhase({ForceUpdate update}) async =>
      device.cameraSettings.focusMagnifierPhase;

  Future<bool> setFocusMagnifierPhase(FocusMagnifierPhaseId value);

  Future<SettingsItem<DoubleValue>> getFocusMagnifier({ForceUpdate update}) async =>
      device.cameraSettings.focusMagnifier;

  Future<bool> setFocusMagnifier(double value);

  Future<ListInfoItem<StringValue>> getStorageInformation({ForceUpdate update}) async =>
      device.cameraSettings.storageInformation;
}

enum InterfaceType { Wifi_Interface, USB_Interface }

enum ShutterPressType { Half, Full, Both } //Any means both
