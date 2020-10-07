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

  SettingsItem applicationInfo =
      SettingsItem<StringValue>(ItemId.ApplicationInfo);
  SettingsItem apiList = SettingsItem<StringValue>(ItemId.ApiList);
  SettingsItem availableSettings =
      SettingsItem<StringValue>(ItemId.AvailableSettings);
  SettingsItem cameraFunction =
      SettingsItem<StringValue>(ItemId.CameraFunction);
  SettingsItem capturePhoto = SettingsItem<StringValue>(ItemId.CapturePhoto);
  SettingsItem cameraSetup = SettingsItem<StringValue>(ItemId.CameraSetup);
  SettingsItem liveView = SettingsItem<StringValue>(ItemId.LiveView);
  SettingsItem liveViewWithSize =
      SettingsItem<StringValue>(ItemId.LiveViewWithSize);
  SettingsItem zoom = SettingsItem<StringValue>(ItemId.Zoom);
  SettingsItem halfPressShutter =
      SettingsItem<StringValue>(ItemId.HalfPressShutter);
  SettingsItem selfTimer = SettingsItem<StringValue>(ItemId.SelfTimer);
  SettingsItem contShootingMode =
      SettingsItem<StringValue>(ItemId.ContShootingMode);
  SettingsItem contShootingSpeed =
      SettingsItem<StringValue>(ItemId.ContShootingSpeed);
  SettingsItem meteringMode =
      SettingsItem<MeteringModeValue>(ItemId.MeteringMode);
  SettingsItem liveViewSize =
      SettingsItem<LiveViewSizeValue>(ItemId.LiveViewSize);
  SettingsItem postViewImageSize =
      SettingsItem<StringValue>(ItemId.PostViewImageSize);
  SettingsItem programShift = SettingsItem<StringValue>(ItemId.ProgramShift);
  SettingsItem zoomSetting = SettingsItem<StringValue>(ItemId.ZoomSetting);
  SettingsItem storageInformation =
      SettingsItem<StringValue>(ItemId.StorageInformation);
  SettingsItem liveViewInfo = SettingsItem<StringValue>(ItemId.LiveViewInfo);
  SettingsItem silentShootingSettings =
      SettingsItem<StringValue>(ItemId.SilentShootingSettings);

  //TODO getter future, da wenn current value "leer" evtl nochmal requesten? (vtl einstellbar falls nie ?)
  //TODO update mit boolean request -> falls immer geupdttet werden soll
  //TODO remove this method
  SettingsItem<T> getItem<T extends Value>(ItemId settingsId) {
    switch (settingsId) {
      case ItemId.FNumber:
        return fNumber;
      case ItemId.EV:
        return ev;
      case ItemId.ISO:
        return iso;
      case ItemId.ShutterSpeed:
        return shutterSpeed;
      case ItemId.AEL_State:
        return aelState;
      case ItemId.FEL:
        return fel;
      case ItemId.FlashMode:
        return flashMode;
      case ItemId.FocusMode:
        return focusMode;
      case ItemId.MeteringMode:
        return meteringMode;
      case ItemId.WhiteBalanceMode:
        return whiteBalanceMode;
      case ItemId.WhiteBalanceColorTemp:
        return whiteBalanceColorTemp;
      case ItemId.FocusArea:
        return focusArea;
      case ItemId.FocusAreaSpot:
        return focusAreaSpot;
      case ItemId.AutoFocusState:
        return autoFocusState;
      case ItemId.ImageFileFormat:
        return autoFocusState;
      case ItemId.FlashValue:
        return flashValue;
      case ItemId.ImageFileFormat:
        return imageFileFormat;
      case ItemId.PictureEffect:
        return pictureEffect;
      case ItemId.DroHdr:
        return droHdr;
      case ItemId.ImageSize:
        return imageSize;
      case ItemId.AspectRatio:
        return aspectRatio;
      case ItemId.FocusModeToggleResponse:
        return focusModeToggleResponse;
      case ItemId.ShootingMode:
        return shootingMode;
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
        throw UnsupportedError;
      case ItemId.MethodTypes:
        throw UnsupportedError;
      case ItemId.ApplicationInfo:
        return applicationInfo;
      case ItemId.ApiList:
        return apiList;
      case ItemId.AvailableSettings:
        return availableSettings;
      case ItemId.CameraFunction:
        return cameraFunction;
      case ItemId.CameraSetup:
        return cameraSetup;
      case ItemId.LiveView:
        return liveView;
      case ItemId.LiveViewWithSize:
        return liveViewWithSize;
      case ItemId.Zoom:
        return zoom;
      case ItemId.HalfPressShutter:
        return halfPressShutter;
      case ItemId.SelfTimer:
        return selfTimer;
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
      case ItemId.ProgramShift:
        return programShift;
      case ItemId.LiveViewInfo:
        return liveViewInfo;
      case ItemId.SilentShootingSettings:
        return silentShootingSettings;
      default:
        return null;
    }
  }
}
