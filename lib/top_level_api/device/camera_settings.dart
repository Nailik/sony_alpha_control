import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';

abstract class CameraSettings extends ChangeNotifier {
  Future<bool> update();

  SettingsItem<DoubleValue> fNumber = SettingsItem<DoubleValue>(ItemId.FNumber);
  SettingsItem<IsoValue> iso = SettingsItem<IsoValue>(ItemId.IsoSpeedRate);
  SettingsItem<ShutterSpeedValue> shutterSpeed = SettingsItem<ShutterSpeedValue>(ItemId.ShutterSpeed);
  SettingsItem<EvValue> exposureCompensation = SettingsItem<EvValue>(ItemId.ExposureCompensation);
  SettingsItem<FlashModeValue> flashMode = SettingsItem<FlashModeValue>(ItemId.FlashMode);
  SettingsItem<FocusModeValue> focusMode = SettingsItem<FocusModeValue>(ItemId.FocusMode);
  SettingsItem<WhiteBalanceModeValue> whiteBalanceMode = SettingsItem<WhiteBalanceModeValue>(ItemId.WhiteBalanceMode);
  SettingsItem<WhiteBalanceColorTempValue> whiteBalanceColorTemp =
      SettingsItem<WhiteBalanceColorTempValue>(ItemId.WhiteBalanceColorTemp);
  SettingsItem<BoolValue> aelState = SettingsItem<BoolValue>(ItemId.AEL_State);
  SettingsItem<BoolValue> fel = SettingsItem<BoolValue>(ItemId.FEL);
  SettingsItem<FocusAreaValue> focusArea = SettingsItem<FocusAreaValue>(ItemId.FocusArea);
  SettingsItem<PointValue> focusAreaSpot = SettingsItem<PointValue>(ItemId.FocusAreaSpot);
  SettingsItem<IntValue> flashValue = SettingsItem<IntValue>(ItemId.FlashValue);
  SettingsItem<ImageFileFormatValue> imageFileFormat = SettingsItem<ImageFileFormatValue>(ItemId.ImageFileFormat);
  SettingsItem<PictureEffectValue> pictureEffect = SettingsItem<PictureEffectValue>(ItemId.PictureEffect);
  SettingsItem<DroHdrValue> droHdr = SettingsItem<DroHdrValue>(ItemId.DroHdr);
  SettingsItem<RecordVideoStateValue> recordVideoState = SettingsItem<RecordVideoStateValue>(ItemId.RecordVideoState);
  SettingsItem<BoolValue> photoTransferQueue = SettingsItem<BoolValue>(ItemId.PhotoTransferQueue);
  SettingsItem<ImageSizeValue> imageSize = SettingsItem<ImageSizeValue>(ItemId.ImageSize);
  SettingsItem<AspectRatioValue> aspectRatio = SettingsItem<AspectRatioValue>(ItemId.AspectRatio);
  SettingsItem<MovieFileFormatValue> movieFileFormat = SettingsItem<MovieFileFormatValue>(ItemId.MovieFileFormat);
  SettingsItem<MovieQualityValue> movieQuality = SettingsItem<MovieQualityValue>(ItemId.MovieQuality);
  SettingsItem<OnOffValue> steadyMode = SettingsItem<OnOffValue>(ItemId.SteadyMode);
  SettingsItem<IntValue> viewAngle = SettingsItem<IntValue>(ItemId.ViewAngle);
  SettingsItem<SceneSelectionValue> sceneSelection = SettingsItem<SceneSelectionValue>(ItemId.SceneSelection);
  SettingsItem<ColorSettingValue> colorSetting = SettingsItem<ColorSettingValue>(ItemId.ColorSetting);
  SettingsItem<StringValue> intervalTime = SettingsItem<StringValue>(ItemId.IntervalTime);
  SettingsItem<StringValue> loopRecordingTime = SettingsItem<StringValue>(ItemId.LoopRecordingTime);
  SettingsItem<OnOffValue> windNoiseReduction = SettingsItem<OnOffValue>(ItemId.WindNoiseReduction);
  SettingsItem<OnOffValue> audioRecordingSetting = SettingsItem<OnOffValue>(ItemId.AudioRecordingSetting);
  SettingsItem<OnOffValue> flipSetting = SettingsItem<OnOffValue>(ItemId.FlipSetting);
  SettingsItem<TvColorSystemValue> tvColorSystem = SettingsItem<TvColorSystemValue>(ItemId.TvColorSystem);
  SettingsItem<OnOffValue> infraredRemoteControl = SettingsItem<OnOffValue>(ItemId.InfraredRemoteControl);
  SettingsItem<IntValue> autoPowerOff = SettingsItem<IntValue>(ItemId.AutoPowerOff);
  SettingsItem<BeepModeValue> beepMode = SettingsItem<BeepModeValue>(ItemId.BeepMode);
  SettingsItem focusModeToggleResponse = SettingsItem<FocusModeToggleValue>(ItemId.FocusModeToggleResponse);
  SettingsItem<ShootModeValue> shootMode = SettingsItem<ShootModeValue>(ItemId.ShootMode);
  SettingsItem<WhiteBalanceAbValue> whiteBalanceAB = SettingsItem<WhiteBalanceAbValue>(ItemId.WhiteBalanceAB);
  SettingsItem<WhiteBalanceGmValue> whiteBalanceGM = SettingsItem<WhiteBalanceGmValue>(ItemId.WhiteBalanceGM);
  SettingsItem<DriveModeValue> driveMode = SettingsItem<DriveModeValue>(ItemId.DriveMode);
  SettingsItem<FocusMagnifierDirectionValue> focusMagnifierDirection = SettingsItem<FocusMagnifierDirectionValue>(
      ItemId.FocusMagnifierDirection);
  SettingsItem<FocusMagnifierPhaseValue> focusMagnifierPhase = SettingsItem<FocusMagnifierPhaseValue>(
      ItemId.FocusMagnifierPhase);
  SettingsItem<DoubleValue> focusMagnifier = SettingsItem<DoubleValue>(ItemId.FocusMagnifier);
  SettingsItem<CameraFunctionValue> cameraFunction = SettingsItem<CameraFunctionValue>(ItemId.CameraFunction);
  SettingsItem<StringValue> zoom = SettingsItem<StringValue>(ItemId.Zoom);
  SettingsItem<IntValue> selfTimer = SettingsItem<IntValue>(ItemId.SelfTimer);
  SettingsItem<ContShootingModeValue> contShootingMode = SettingsItem<ContShootingModeValue>(ItemId.ContShootingMode);
  SettingsItem<ContShootingSpeedValue> contShootingSpeed =
  SettingsItem<ContShootingSpeedValue>(ItemId.ContShootingSpeed);
  SettingsItem<MeteringModeValue> meteringMode = SettingsItem<MeteringModeValue>(ItemId.MeteringMode);
  SettingsItem<LiveViewSizeValue> liveViewSize = SettingsItem<LiveViewSizeValue>(ItemId.LiveViewSize);
  SettingsItem<PostViewImageSizeValue> postViewImageSize = SettingsItem<PostViewImageSizeValue>(
      ItemId.PostViewImageSize);
  SettingsItem<IntValue> programShift = SettingsItem<IntValue>(ItemId.ProgramShift);
  SettingsItem<ZoomSettingValue> zoomSetting = SettingsItem<ZoomSettingValue>(ItemId.ZoomSetting);
  SettingsItem<StringValue> liveViewInfo = SettingsItem<StringValue>(ItemId.LiveViewInfo);
  SettingsItem<OnOffValue> silentShooting = SettingsItem<OnOffValue>(ItemId.SilentShooting);

  //TODO method types for all different SonyWebApiServiceTypeIds with versions?
  ListInfoItem<WebApiMethodValue> methodTypesCamera = ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);
  ListInfoItem<WebApiMethodValue> methodTypesAvContent = ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);
  ListInfoItem<WebApiMethodValue> methodTypesSystem = ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);
  ListInfoItem<WebApiMethodValue> methodTypesGuide = ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);
  ListInfoItem<WebApiMethodValue> methodTypesAccessControl = ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);

  ListInfoItem<ApiFunctionValue> availableFunctions = ListInfoItem<ApiFunctionValue>(ItemId.AvailableFunctions);

  ListInfoItem<StringValue> storageInformation = ListInfoItem<StringValue>(ItemId.StorageInformation);
  ListInfoItem<StringValue> capturePhoto = ListInfoItem<StringValue>(ItemId.CapturePhoto);

  ListInfoItem<StringValue> cameraSetup = ListInfoItem<StringValue>(ItemId.CameraSetup);
  ListInfoItem<StringValue> applicationInfo = ListInfoItem<StringValue>(ItemId.ApplicationInfo);
  ListInfoItem<StringValue> availableSettings = ListInfoItem<StringValue>(ItemId.AvailableSettings);

  //versions for all the different SonyWebApiServiceTypeIds
  ListInfoItem<WebApiVersionsValue> versionsCamera = ListInfoItem<WebApiVersionsValue>(ItemId.Versions);
  ListInfoItem<WebApiVersionsValue> versionsAvContent = ListInfoItem<WebApiVersionsValue>(ItemId.Versions);
  ListInfoItem<WebApiVersionsValue> versionsSystem = ListInfoItem<WebApiVersionsValue>(ItemId.Versions);
  ListInfoItem<WebApiVersionsValue> versionsGuide = ListInfoItem<WebApiVersionsValue>(ItemId.Versions);
  ListInfoItem<WebApiVersionsValue> versionsAccessControl = ListInfoItem<WebApiVersionsValue>(ItemId.Versions);

  InfoItem<StringValue> batteryInfo = InfoItem<StringValue>(ItemId.BatteryInfo);
  InfoItem<BoolValue> audioRecording = InfoItem<BoolValue>(ItemId.AudioRecording);
  InfoItem<BoolValue> intervalStillRecording = InfoItem<BoolValue>(ItemId.IntervalStillRecording);
  InfoItem<BoolValue> loopRecording = InfoItem<BoolValue>(ItemId.LoopRecording);
  InfoItem<BoolValue> movieRecording = InfoItem<BoolValue>(ItemId.MovieRecording);
  InfoItem<BoolValue> contShooting = InfoItem<BoolValue>(ItemId.ContShooting);
  InfoItem<BoolValue> halfPressShutter =
  InfoItem<BoolValue>(ItemId.HalfPressShutter); //saves if is act (true) or cancel (false)
  InfoItem<BoolValue> liveView = InfoItem<BoolValue>(ItemId.LiveView);
  InfoItem<BoolValue> cameraFunctionResult = InfoItem<BoolValue>(ItemId.CameraFunctionResult);
  InfoItem<FocusStateValue> focusState = InfoItem<FocusStateValue>(ItemId.FocusState);

  //SettingsItem, ListInfoItem or InfoItem
  dynamic getItem(ItemId itemId) {
    switch (itemId) {
      case ItemId.FNumber:
        return fNumber;
      case ItemId.IsoSpeedRate:
        return iso;
      case ItemId.ShutterSpeed:
        return shutterSpeed;
      case ItemId.ExposureCompensation:
        return exposureCompensation;
      case ItemId.FlashMode:
        return flashMode;
      case ItemId.FocusMode:
        return focusMode;
      case ItemId.FNumber:
        return fNumber;
      case ItemId.WhiteBalanceMode:
        return whiteBalanceMode;
      case ItemId.WhiteBalanceColorTemp:
        return whiteBalanceColorTemp;
      case ItemId.AEL_State:
        return aelState;
      case ItemId.FEL:
        return fel;
      case ItemId.FocusArea:
        return focusArea;
      case ItemId.FocusAreaSpot:
        return focusAreaSpot;
      case ItemId.FocusState:
        return focusState;
      case ItemId.FlashValue:
        return flashValue;
      case ItemId.ImageFileFormat:
        return imageFileFormat;
      case ItemId.PictureEffect:
        return pictureEffect;
      case ItemId.DroHdr:
        return droHdr;
      case ItemId.RecordVideoState:
        return recordVideoState;
      case ItemId.PhotoTransferQueue:
        return photoTransferQueue;
      case ItemId.BatteryInfo:
        return batteryInfo;
      case ItemId.ImageSize:
        return imageSize;
      case ItemId.AspectRatio:
        return aspectRatio;
      case ItemId.MovieFileFormat:
        return movieFileFormat;
      case ItemId.MovieQuality:
        return movieQuality;
      case ItemId.SteadyMode:
        return steadyMode;
      case ItemId.ViewAngle:
        return viewAngle;
      case ItemId.SceneSelection:
        return sceneSelection;
      case ItemId.ColorSetting:
        return colorSetting;
      case ItemId.IntervalTime:
        return intervalTime;
      case ItemId.LoopRecordingTime:
        return loopRecordingTime;
      case ItemId.WindNoiseReduction:
        return windNoiseReduction;
      case ItemId.AudioRecordingSetting:
        return audioRecordingSetting;
      case ItemId.AudioRecording:
        return audioRecording;
      case ItemId.FlipSetting:
        return flipSetting;
      case ItemId.TvColorSystem:
        return tvColorSystem;
      case ItemId.InfraredRemoteControl:
        return infraredRemoteControl;
      case ItemId.AutoPowerOff:
        return autoPowerOff;
      case ItemId.BeepMode:
        return beepMode;
      case ItemId.FocusModeToggleResponse:
        return focusModeToggleResponse;
      case ItemId.ShootMode:
        return shootMode;
      case ItemId.WhiteBalanceAB:
        return whiteBalanceAB;
      case ItemId.WhiteBalanceGM:
        return whiteBalanceGM;
      case ItemId.DriveMode:
        return driveMode;
      case ItemId.FocusMagnifierDirection:
        return focusMagnifierDirection;
      case ItemId.FocusMagnifierPhase:
        return focusMagnifierPhase;
      case ItemId.FocusMagnifier:
        return focusMagnifier;
      case ItemId.Versions:
        return [versionsCamera, versionsAvContent, versionsSystem, versionsGuide, versionsAccessControl];
      case ItemId.MethodTypes:
        return [methodTypesCamera, methodTypesAvContent, methodTypesSystem, methodTypesGuide, methodTypesAccessControl];
      case ItemId.AvailableFunctions:
        return availableFunctions;
      case ItemId.ApplicationInfo:
        return applicationInfo;
      case ItemId.AvailableSettings:
        return availableSettings;
      case ItemId.CameraFunction:
        return cameraFunction;
      case ItemId.CapturePhoto:
        return capturePhoto;
      case ItemId.CameraSetup:
        return cameraSetup;
      case ItemId.LiveView:
        return liveView;
      case ItemId.Zoom:
        return zoom;
      case ItemId.HalfPressShutter:
        return halfPressShutter;
      case ItemId.SelfTimer:
        return selfTimer;
      case ItemId.IntervalStillRecording:
        return intervalStillRecording;
      case ItemId.LoopRecording:
        return loopRecording;
      case ItemId.MovieRecording:
        return movieRecording;
      case ItemId.ContShooting:
        return contShooting;
      case ItemId.ContShootingMode:
        return contShootingMode;
      case ItemId.ContShootingSpeed:
        return contShootingSpeed;
      case ItemId.MeteringMode:
        return meteringMode;
      case ItemId.LiveViewSize:
        return liveViewSize;
      case ItemId.PostViewImageSize:
        return postViewImageSize;
      case ItemId.ProgramShift:
        return programShift;
      case ItemId.ZoomSetting:
        return zoomSetting;
      case ItemId.StorageInformation:
        return storageInformation;
      case ItemId.LiveViewInfo:
        return liveViewInfo;
      case ItemId.SilentShooting:
        return silentShooting;
      case ItemId.UnkD20E:
        // TODO: Handle this case.
        break;
      case ItemId.UnkD212:
        // TODO: Handle this case.
        break;
      case ItemId.SensorCrop:
        // TODO: Handle this case.
        break;
      case ItemId.FEL_State:
        // TODO: Handle this case.
        break;
      case ItemId.LiveViewState:
        // TODO: Handle this case.
        break;
      case ItemId.UnkD222:
        // TODO: Handle this case.
        break;
      case ItemId.UnkD22E:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierPosition:
        // TODO: Handle this case.
        break;
      case ItemId.UseLiveViewDisplayEffect:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierState:
        // TODO: Handle this case.
        break;
      case ItemId.UnkD236:
        // TODO: Handle this case.
        break;
      case ItemId.AEL:
        // TODO: Handle this case.
        break;
      case ItemId.UnkD2C5:
        // TODO: Handle this case.
        break;
      case ItemId.UnkD2C7:
        // TODO: Handle this case.
        break;
      case ItemId.RecordVideo:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierResetRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierMoveUpRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierMoveDownRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierMoveLeftRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierMoveRightRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusDistance:
        // TODO: Handle this case.
        break;
      case ItemId.FocusModeToggleRequest:
        // TODO: Handle this case.
        break;
      case ItemId.UnkD2D3:
        // TODO: Handle this case.
        break;
      case ItemId.UnkD2D4:
        // TODO: Handle this case.
        break;
      case ItemId.PhotoInfo:
        // TODO: Handle this case.
        break;
      case ItemId.CameraInfo:
        // TODO: Handle this case.
        break;
      case ItemId.Connect:
        // TODO: Handle this case.
        break;
      case ItemId.CameraStatus:
        // TODO: Handle this case.
        break;
      case ItemId.ZoomInformation:
        // TODO: Handle this case.
        break;
      case ItemId.EnableMethods:
        // TODO: Handle this case.
        break;
      case ItemId.TrackingFocus:
        // TODO: Handle this case.
        break;
      case ItemId.BulbShooting:
        // TODO: Handle this case.
        break;
      case ItemId.DateTimeSetting:
        // TODO: Handle this case.
        break;
      case ItemId.DeleteContents:
        // TODO: Handle this case.
        break;
      case ItemId.LiveViewWithSize:
        // TODO: Handle this case.
        break;
      case ItemId.RemotePlayback:
        // TODO: Handle this case.
        break;
      case ItemId.LiveViewOrientation:
        // TODO: Handle this case.
        break;
      case ItemId.PostViewUrlSet:
        // TODO: Handle this case.
        break;
      case ItemId.ContShootingUrlSet:
        // TODO: Handle this case.
        break;
      case ItemId.CameraFunctionResult:
        // TODO: Handle this case.
        break;
      case ItemId.IRRemoteControl:
        // TODO: Handle this case.
        break;
      case ItemId.TrackingFocusStatus:
        // TODO: Handle this case.
        break;
      case ItemId.RecordingTime:
        // TODO: Handle this case.
        break;
      case ItemId.NumberOfShots:
        // TODO: Handle this case.
        break;
      case ItemId.BulbCapturingTime:
        // TODO: Handle this case.
        break;
      case ItemId.Content:
        // TODO: Handle this case.
        break;
      case ItemId.RequestTo:
        // TODO: Handle this case.
        break;
      case ItemId.ServiceProtocols:
        // TODO: Handle this case.
        break;
      case ItemId.ApiInfo:
        // TODO: Handle this case.
        break;
      case ItemId.Unknown:
        // TODO: Handle this case.
        break;
    }
  }
}
