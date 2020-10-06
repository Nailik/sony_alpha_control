import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
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
import 'package:sonyalphacontrol/top_level_api/ids/live_view_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_api_method_set.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';

abstract class CameraSettings extends ChangeNotifier {
  Future<bool> update();

  SettingsItem fNumber = SettingsItem<DoubleValue>(SettingsId.FNumber);
  SettingsItem iso = SettingsItem<IsoValue>(SettingsId.ISO);
  SettingsItem shutterSpeed =
      SettingsItem<ShutterSpeedValue>(SettingsId.ShutterSpeed);
  SettingsItem ev = SettingsItem<EvValue>(SettingsId.EV);
  SettingsItem flashMode = SettingsItem<FlashModeValue>(SettingsId.FlashMode);
  SettingsItem focusMode = SettingsItem<FocusModeValue>(SettingsId.FocusMode);
  SettingsItem whiteBalanceMode =
      SettingsItem<WhiteBalanceModeValue>(SettingsId.WhiteBalanceMode);
  SettingsItem whiteBalanceColorTemp = SettingsItem<WhiteBalanceColorTempValue>(
      SettingsId.WhiteBalanceColorTemp);
  SettingsItem aelState = SettingsItem<BoolValue>(SettingsId.AEL_State);
  SettingsItem fel = SettingsItem<BoolValue>(SettingsId.FEL);
  SettingsItem focusArea = SettingsItem<FocusAreaValue>(SettingsId.FocusArea);
  SettingsItem focusAreaSpot =
      SettingsItem<PointValue>(SettingsId.FocusAreaSpot);
  SettingsItem autoFocusState =
      SettingsItem<AutoFocusStateValue>(SettingsId.AutoFocusState);
  SettingsItem flashValue = SettingsItem<IntValue>(SettingsId.FlashValue);
  SettingsItem imageFileFormat =
      SettingsItem<ImageFileFormatValue>(SettingsId.ImageFileFormat);
  SettingsItem pictureEffect =
      SettingsItem<PictureEffectValue>(SettingsId.PictureEffect);
  SettingsItem droHdr = SettingsItem<DroHdrValue>(SettingsId.DroHdr);
  SettingsItem imageSize = SettingsItem<ImageSizeValue>(SettingsId.ImageSize);
  SettingsItem aspectRatio =
      SettingsItem<AspectRatioValue>(SettingsId.AspectRatio);
  SettingsItem focusModeToggleResponse =
      SettingsItem<FocusModeToggleValue>(SettingsId.FocusModeToggleResponse);
  SettingsItem shootingMode =
      SettingsItem<DriveModeValue>(SettingsId.ShootingMode);
  SettingsItem whiteBalanceAB =
      SettingsItem<WhiteBalanceAbValue>(SettingsId.WhiteBalanceAB);
  SettingsItem whiteBalanceGM =
      SettingsItem<WhiteBalanceGmValue>(SettingsId.WhiteBalanceGM);
  SettingsItem driveMode = SettingsItem<DriveModeValue>(SettingsId.DriveMode);
  SettingsItem focusMagnifierDirection =
      SettingsItem<FocusMagnifierDirectionValue>(
          SettingsId.FocusMagnifierDirection);
  SettingsItem focusMagnifierPhase =
      SettingsItem<FocusMagnifierPhaseValue>(SettingsId.FocusMagnifierPhase);
  SettingsItem focusMagnifier =
      SettingsItem<DoubleValue>(SettingsId.FocusMagnifier);
  SettingsItem versions = SettingsItem<WebApiVersionValue>(SettingsId.Versions);
  SettingsItem methodTypes = SettingsItem<WebApiMethodValue>(SettingsId.MethodTypes);
  SettingsItem applicationInfo =
      SettingsItem<StringValue>(SettingsId.ApplicationInfo);
  SettingsItem apiList = SettingsItem<StringValue>(SettingsId.ApiList);
  SettingsItem availableSettings =
      SettingsItem<StringValue>(SettingsId.AvailableSettings);
  SettingsItem cameraFunction =
      SettingsItem<StringValue>(SettingsId.CameraFunction);
  SettingsItem capturePhoto =
      SettingsItem<StringValue>(SettingsId.CapturePhoto);
  SettingsItem cameraSetup = SettingsItem<StringValue>(SettingsId.CameraSetup);
  SettingsItem liveView = SettingsItem<StringValue>(SettingsId.LiveView);
  SettingsItem liveViewWithSize =
      SettingsItem<StringValue>(SettingsId.LiveViewWithSize);
  SettingsItem zoom = SettingsItem<StringValue>(SettingsId.Zoom);
  SettingsItem halfPressShutter =
      SettingsItem<StringValue>(SettingsId.HalfPressShutter);
  SettingsItem selfTimer = SettingsItem<StringValue>(SettingsId.SelfTimer);
  SettingsItem contShootingMode =
      SettingsItem<StringValue>(SettingsId.ContShootingMode);
  SettingsItem contShootingSpeed =
      SettingsItem<StringValue>(SettingsId.ContShootingSpeed);
  SettingsItem meteringMode =
      SettingsItem<MeteringModeValue>(SettingsId.MeteringMode);
  SettingsItem liveViewSize =
      SettingsItem<LiveViewSizeValue>(SettingsId.LiveViewSize);
  SettingsItem postViewImageSize =
      SettingsItem<StringValue>(SettingsId.PostViewImageSize);
  SettingsItem programShift =
      SettingsItem<StringValue>(SettingsId.ProgramShift);
  SettingsItem zoomSetting = SettingsItem<StringValue>(SettingsId.ZoomSetting);
  SettingsItem storageInformation =
      SettingsItem<StringValue>(SettingsId.StorageInformation);
  SettingsItem liveViewInfo =
      SettingsItem<StringValue>(SettingsId.LiveViewInfo);
  SettingsItem silentShootingSettings =
      SettingsItem<StringValue>(SettingsId.SilentShootingSettings);

  //TODO getter future, da wenn current value "leer" evtl nochmal requesten? (vtl einstellbar falls nie ?)
  //TODO update mit boolean request -> falls immer geupdttet werden soll
  SettingsItem<T> getItem<T extends SettingsValue>(SettingsId settingsId) {
    switch (settingsId) {
      case SettingsId.FNumber:
        return fNumber;
      case SettingsId.EV:
        return ev;
      case SettingsId.ISO:
        return iso;
      case SettingsId.ShutterSpeed:
        return shutterSpeed;
      case SettingsId.AEL_State:
        return aelState;
      case SettingsId.FEL:
        return fel;
      case SettingsId.FlashMode:
        return flashMode;
      case SettingsId.FocusMode:
        return focusMode;
      case SettingsId.MeteringMode:
        return meteringMode;
      case SettingsId.WhiteBalanceMode:
        return whiteBalanceMode;
      case SettingsId.WhiteBalanceColorTemp:
        return whiteBalanceColorTemp;
      case SettingsId.FocusArea:
        return focusArea;
      case SettingsId.FocusAreaSpot:
        return focusAreaSpot;
      case SettingsId.AutoFocusState:
        return autoFocusState;
      case SettingsId.ImageFileFormat:
        return autoFocusState;
      case SettingsId.FlashValue:
        return flashValue;
      case SettingsId.ImageFileFormat:
        return imageFileFormat;
      case SettingsId.PictureEffect:
        return pictureEffect;
      case SettingsId.DroHdr:
        return droHdr;
      case SettingsId.ImageSize:
        return imageSize;
      case SettingsId.AspectRatio:
        return aspectRatio;
      case SettingsId.FocusModeToggleResponse:
        return focusModeToggleResponse;
      case SettingsId.ShootingMode:
        return shootingMode;
      case SettingsId.WhiteBalanceAB:
        return whiteBalanceAB;
      case SettingsId.WhiteBalanceGM:
        return whiteBalanceGM;
      case SettingsId.DriveMode:
        return driveMode;
      case SettingsId.FocusMagnifierDirection:
        return focusMagnifierDirection;
      case SettingsId.FocusMagnifierPhase:
        return focusMagnifierPhase;
      case SettingsId.FocusMagnifier:
        return focusMagnifier;
      case SettingsId.Versions:
        return versions;
      case SettingsId.MethodTypes:
        return methodTypes;
      case SettingsId.ApplicationInfo:
        return applicationInfo;
      case SettingsId.ApiList:
        return apiList;
      case SettingsId.AvailableSettings:
        return availableSettings;
      case SettingsId.CameraFunction:
        return cameraFunction;
      case SettingsId.CameraSetup:
        return cameraSetup;
      case SettingsId.LiveView:
        return liveView;
      case SettingsId.LiveViewWithSize:
        return liveViewWithSize;
      case SettingsId.Zoom:
        return zoom;
      case SettingsId.HalfPressShutter:
        return halfPressShutter;
      case SettingsId.SelfTimer:
        return selfTimer;
      case SettingsId.ContShootingMode:
        return contShootingMode;
      case SettingsId.ContShootingSpeed:
        return contShootingSpeed;
      case SettingsId.MeteringMode:
        return meteringMode;
      case SettingsId.LiveViewSize:
        return liveViewSize;
      case SettingsId.PostViewImageSize:
        return postViewImageSize;
      case SettingsId.ProgramShift:
        return programShift;
      case SettingsId.ZoomSetting:
        return zoomSetting;
      case SettingsId.StorageInformation:
        return storageInformation;
      case SettingsId.ProgramShift:
        return programShift;
      case SettingsId.LiveViewInfo:
        return liveViewInfo;
      case SettingsId.SilentShootingSettings:
        return silentShootingSettings;
      default:
        return null;
    }
  }
}
