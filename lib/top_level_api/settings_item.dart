//a set function is like "fmode" you have available settings and choose one
import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_ids.dart';
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

import 'ids/aspect_ratio_ids.dart';

class SettingsItem<T> extends ChangeNotifier {
  T value;
  T subValue;
  SettingsId settingsId;

  List<T> available = new List();
  List<T> supported = new List();

  SettingsItem(this.settingsId);

  bool hasSubValue() {
    return (settingsId == SettingsId.FocusAreaSpot ||
        settingsId == SettingsId.FocusMagnifierPosition ||
        settingsId == SettingsId.ShutterSpeed);
  }

  String getValueName(){
    return getNameOf(value);
  }

  String getNameOf(T item) {
    switch (settingsId) {
      case SettingsId.FileFormat:
        return getImageFileFormatId(item as int).name;
      case SettingsId.WhiteBalance:
        return getWhiteBalanceId(item as int).name;
      case SettingsId.FNumber:
        return item.toString();
      case SettingsId.FocusMode:
        return getFocusModeId(item as int).name;
      case SettingsId.MeteringMode:
        return getMeteringModeId(item as int).name;
      case SettingsId.FlashMode:
        return getFlashModeId(item as int).name;
      case SettingsId.ShootingMode:
        return getShootingModeId(item as int).name;
      case SettingsId.EV:
        return item.toString();
      case SettingsId.DriveMode:
        return getDriveModeId(item as int).name;
      case SettingsId.Flash:
        return getFlashModeId(item as int).name;
      case SettingsId.DroHdr:
        return getDroHdrId(item as int).name;
      case SettingsId.ImageSize:
        return getImageSizeId(item as int).name;
      case SettingsId.ShutterSpeed:
        return item.toString();
      case SettingsId.UnkD20E:
        return "UnkD20E";
      case SettingsId.WhiteBalanceColorTemp:
        return item.toString();
      case SettingsId.WhiteBalanceGM:
        return getWhiteBalanceGmId(item as int).name;
      case SettingsId.AspectRatio:
        return getAspectRatioId(item as int).name;
      case SettingsId.UnkD212:
        return "UnkD212";
      case SettingsId.AutoFocusState:
        return getAutoFocusStateId(item as int).name;
      case SettingsId.Zoom:
        return item.toString();
      case SettingsId.PhotoTransferQueue:
        return item.toString();
      case SettingsId.AEL_State:
        return item.toString();
      case SettingsId.BatteryInfo:
        return item.toString();
      case SettingsId.SensorCrop:
          return item.toString();
      case SettingsId.PictureEffect:
        return getPictureEffectId(item as int).name;
      case SettingsId.WhiteBalanceAB:
        return getWhiteBalanceAbId(item as int).name;
      case SettingsId.RecordVideoState:
        return getRecordVideoStateId(item as int).name;
      case SettingsId.ISO:
        return item.toString();
      case SettingsId.FEL_State:
        return item.toString();
      case SettingsId.LiveViewState:
        return item.toString();
      case SettingsId.UnkD222:
        return "UnkD222";
      case SettingsId.FocusArea:
        return getFocusAreaId(item as int).name;
      case SettingsId.FocusMagnifierPhase:
        return item.toString();
      case SettingsId.UnkD22E:
        return "UnkD22E";
      case SettingsId.FocusMagnifier:
        return item.toString();
      case SettingsId.FocusMagnifierPosition:
        return item.toString();
      case SettingsId.UseLiveViewDisplayEffect:
        return item.toString();
      case SettingsId.FocusAreaSpot:
        return item.toString();
      case SettingsId.FocusMagnifierState:
        return item.toString();
      case SettingsId.FocusModeToggleResponse:
        return item.toString();
      case SettingsId.UnkD236:
        return "UnkD236";
      case SettingsId.HalfPressShutter:
        return item.toString();
      case SettingsId.CapturePhoto:
        return item.toString();
      case SettingsId.AEL:
        return item.toString();
      case SettingsId.UnkD2C5:
        return "UnkD2C5";
      case SettingsId.UnkD2C7:
        return "UnkD2C7";
      case SettingsId.RecordVideo:
        return getRecordVideoStateId(item as int).name;
      case SettingsId.FEL:
        return item.toString();
      case SettingsId.FocusMagnifierRequest:
        return item.toString();
      case SettingsId.FocusMagnifierResetRequest:
        return item.toString();
      case SettingsId.FocusMagnifierMoveUpRequest:
        return item.toString();
      case SettingsId.FocusMagnifierMoveDownRequest:
        return item.toString();
      case SettingsId.FocusMagnifierMoveLeftRequest:
        return item.toString();
      case SettingsId.FocusMagnifierMoveRightRequest:
        return item.toString();
      case SettingsId.FocusDistance:
        return item.toString();
      case SettingsId.FocusModeToggleRequest:
        return item.toString();
      case SettingsId.UnkD2D3:
        return "UnkD2D3";
      case SettingsId.UnkD2D4:
        return "UnkD2D4";
      case SettingsId.LiveViewInfo:
        return item.toString();
      case SettingsId.PhotoInfo:
        return "UnkD2D4";
      case SettingsId.Unknown:
        return "Unknown";
    }
    return "";
  }
}

class Value<T> {
  T value;

  Value(this.value);
}
