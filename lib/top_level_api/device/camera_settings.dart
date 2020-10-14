import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';

abstract class CameraSettings extends ChangeNotifier {
  Future<bool> update();

  SettingsItem fNumber = SettingsItem<DoubleValue>(ItemId.FNumber);
  SettingsItem iso = SettingsItem<IsoValue>(ItemId.ISO);
  SettingsItem shutterSpeed =
      SettingsItem<ShutterSpeedValue>(ItemId.ShutterSpeed);
  SettingsItem ev = SettingsItem<EvValue>(ItemId.EV);
  SettingsItem flashMode = SettingsItem<FlashModeValue>(ItemId.FlashMode);
  SettingsItem focusMode = SettingsItem<FocusModeValue>(ItemId.FocusMode);
  SettingsItem whiteBalanceMode =
      SettingsItem<WhiteBalanceModeValue>(ItemId.WhiteBalanceMode);
  SettingsItem whiteBalanceColorTemp =
      SettingsItem<WhiteBalanceColorTempValue>(ItemId.WhiteBalanceColorTemp);
  SettingsItem aelState = SettingsItem<BoolValue>(ItemId.AEL_State);
  SettingsItem fel = SettingsItem<BoolValue>(ItemId.FEL);
  SettingsItem focusArea = SettingsItem<FocusAreaValue>(ItemId.FocusArea);
  SettingsItem focusAreaSpot = SettingsItem<PointValue>(ItemId.FocusAreaSpot);
  SettingsItem autoFocusState =
      SettingsItem<AutoFocusStateValue>(ItemId.AutoFocusState);
  SettingsItem flashValue = SettingsItem<IntValue>(ItemId.FlashValue);
  SettingsItem imageFileFormat =
      SettingsItem<ImageFileFormatValue>(ItemId.ImageFileFormat);
  SettingsItem pictureEffect =
      SettingsItem<PictureEffectValue>(ItemId.PictureEffect);
  SettingsItem droHdr = SettingsItem<DroHdrValue>(ItemId.DroHdr);
  SettingsItem<RecordVideoStateValue> recordVideoState =
      SettingsItem<RecordVideoStateValue>(ItemId.RecordVideoState);
  SettingsItem<BoolValue> photoTransferQueue =
      SettingsItem<BoolValue>(ItemId.PhotoTransferQueue);
  InfoItem<StringValue> batteryInfo = InfoItem<StringValue>(ItemId.BatteryInfo);
  SettingsItem imageSize = SettingsItem<ImageSizeValue>(ItemId.ImageSize);
  SettingsItem aspectRatio = SettingsItem<AspectRatioValue>(ItemId.AspectRatio);
  SettingsItem focusModeToggleResponse =
      SettingsItem<FocusModeToggleValue>(ItemId.FocusModeToggleResponse);
  SettingsItem shootingMode = SettingsItem<DriveModeValue>(ItemId.ShootingMode);
  SettingsItem whiteBalanceAB =
      SettingsItem<WhiteBalanceAbValue>(ItemId.WhiteBalanceAB);
  SettingsItem whiteBalanceGM =
      SettingsItem<WhiteBalanceGmValue>(ItemId.WhiteBalanceGM);
  SettingsItem driveMode = SettingsItem<DriveModeValue>(ItemId.DriveMode);
  SettingsItem focusMagnifierDirection =
      SettingsItem<FocusMagnifierDirectionValue>(
          ItemId.FocusMagnifierDirection);
  SettingsItem focusMagnifierPhase =
      SettingsItem<FocusMagnifierPhaseValue>(ItemId.FocusMagnifierPhase);
  SettingsItem focusMagnifier =
      SettingsItem<DoubleValue>(ItemId.FocusMagnifier);

  //versions for all the different SonyWebApiServiceTypeIds
  ListInfoItem<WebApiVersionsValue> versionsCamera =
      ListInfoItem<WebApiVersionsValue>(ItemId.Versions);
  ListInfoItem<WebApiVersionsValue> versionsAvContent =
      ListInfoItem<WebApiVersionsValue>(ItemId.Versions);
  ListInfoItem<WebApiVersionsValue> versionsSystem =
      ListInfoItem<WebApiVersionsValue>(ItemId.Versions);
  ListInfoItem<WebApiVersionsValue> versionsGuide =
      ListInfoItem<WebApiVersionsValue>(ItemId.Versions);
  ListInfoItem<WebApiVersionsValue> versionsAccessControl =
      ListInfoItem<WebApiVersionsValue>(ItemId.Versions);

  //TODO method types for all different SonyWebApiServiceTypeIds with versions?
  ListInfoItem methodTypesCamera =
      ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);
  ListInfoItem methodTypesAvContent =
      ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);
  ListInfoItem methodTypesSystem =
      ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);
  ListInfoItem methodTypesGuide =
      ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);
  ListInfoItem methodTypesAccessControl =
      ListInfoItem<WebApiMethodValue>(ItemId.MethodTypes);

  ListInfoItem availableFunctions =
      ListInfoItem<ApiFunctionValue>(ItemId.ApiList);

  ListInfoItem<StringValue> applicationInfo =
      ListInfoItem<StringValue>(ItemId.ApplicationInfo);
  ListInfoItem<StringValue> availableSettings =
      ListInfoItem<StringValue>(ItemId.AvailableSettings);

  SettingsItem<CameraFunctionValue> cameraFunction =
      SettingsItem<CameraFunctionValue>(ItemId.CameraFunction);

  ListInfoItem<StringValue> capturePhoto =
      ListInfoItem<StringValue>(ItemId.CapturePhoto);

  ListInfoItem<StringValue> cameraSetup =
      ListInfoItem<StringValue>(ItemId.CameraSetup);

  SettingsItem liveView = SettingsItem<StringValue>(ItemId.LiveView);

  SettingsItem zoom = SettingsItem<StringValue>(ItemId.Zoom);
  InfoItem<BoolValue> halfPressShutter = InfoItem<BoolValue>(
      ItemId.HalfPressShutter); //saves if is act (true) or cancel (false)
  SettingsItem<IntValue> selfTimer = SettingsItem<IntValue>(ItemId.SelfTimer);
  SettingsItem contShootingMode =
      SettingsItem<StringValue>(ItemId.ContShootingMode);
  SettingsItem contShootingSpeed =
      SettingsItem<StringValue>(ItemId.ContShootingSpeed);
  SettingsItem<MeteringModeValue> meteringMode =
      SettingsItem<MeteringModeValue>(ItemId.MeteringMode);
  SettingsItem liveViewSize =
      SettingsItem<LiveViewSizeValue>(ItemId.LiveViewSize);
  SettingsItem postViewImageSize =
      SettingsItem<PostViewImageSizeValue>(ItemId.PostViewImageSize);
  SettingsItem programShift = SettingsItem<IntValue>(ItemId.ProgramShift);
  SettingsItem<ZoomSettingValue> zoomSetting =
      SettingsItem<ZoomSettingValue>(ItemId.ZoomSetting);
  ListInfoItem<StringValue> storageInformation = ListInfoItem<StringValue>(ItemId.StorageInformation);
  SettingsItem liveViewInfo = SettingsItem<StringValue>(ItemId.LiveViewInfo);
  SettingsItem<OnOffValue> silentShooting =
      SettingsItem<OnOffValue>(ItemId.SilentShooting);
}
