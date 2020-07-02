//a set function is like "fmode" you have available settings and choose one
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
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

class SettingsItem<T extends SettingsValue> extends ChangeNotifier {
  SettingsId settingsId;

  SettingsValue value;
  SettingsValue subValue;

  List<SettingsValue> available = new List();
  List<SettingsValue> supported = new List();

  SettingsItem(this.settingsId);

  bool hasSubValue() {
    return (settingsId == SettingsId.FocusAreaSpot ||
        settingsId == SettingsId.FocusMagnifierPosition ||
        settingsId == SettingsId.ShutterSpeed);
  }

  SettingsValue fromUsb(int usbValue) {
    switch (settingsId) {
      case SettingsId.FileFormat:
        return ImageFileFormatValue.fromUSBValue(usbValue);
      case SettingsId.WhiteBalance:
        return WhiteBalanceValue.fromUSBValue(usbValue);
      case SettingsId.FNumber:
        return IntValue(usbValue); //durch 100
      case SettingsId.FocusMode:
        return FocusModeValue.fromUSBValue(usbValue);
      case SettingsId.MeteringMode:
        return MeteringModeValue.fromUSBValue(usbValue);
      case SettingsId.FlashMode:
        return FlashModeValue.fromUSBValue(usbValue);
      case SettingsId.ShootingMode:
        return ShootingModeValue.fromUSBValue(usbValue);
      case SettingsId.EV:
        return IntValue(usbValue);
      case SettingsId.DriveMode:
        return DriveModeValue.fromUSBValue(usbValue);
      case SettingsId.Flash:
        return IntValue(usbValue);
      case SettingsId.DroHdr:
        return DroHdrValue.fromUSBValue(usbValue);
      case SettingsId.ImageSize:
        return ImageSizeValue.fromUSBValue(usbValue);
      case SettingsId.ShutterSpeed:
        return IntValue(usbValue);
      case SettingsId.UnkD20E:
        // TODO: Handle this case.
        break;
      case SettingsId.WhiteBalanceColorTemp:
        return IntValue(usbValue);
      case SettingsId.WhiteBalanceGM:
        return WhiteBalanceGmValue.fromUSBValue(usbValue);
      case SettingsId.AspectRatio:
        return AspectRatioValue.fromUSBValue(usbValue);
      case SettingsId.UnkD212:
        // TODO: Handle this case.
        break;
      case SettingsId.AutoFocusState:
        return AutoFocusStateValue.fromUSBValue(usbValue);
      case SettingsId.Zoom:
        // TODO: Handle this case.
        break;
      case SettingsId.PhotoTransferQueue:
        // TODO: Handle this case.
        break;
      case SettingsId.AEL_State:
        return BoolValue(usbValue == 2);
      case SettingsId.BatteryInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.SensorCrop:
        // TODO: Handle this case.
        break;
      case SettingsId.PictureEffect:
        return PictureEffectValue.fromUSBValue(usbValue);
      case SettingsId.WhiteBalanceAB:
        return WhiteBalanceAbValue.fromUSBValue(usbValue);
      case SettingsId.RecordVideoState:
        return RecordVideoStateValue.fromUSBValue(usbValue);
      case SettingsId.ISO:
        return IntValue(usbValue);
      case SettingsId.FEL_State:
        return BoolValue(usbValue == 2);
      case SettingsId.LiveViewState:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD222:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusArea:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierPhase:
        return FocusMagnifierPhaseValue.fromUSBValue(usbValue);
      case SettingsId.UnkD22E:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifier:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierPosition:
        // TODO: Handle this case.
        break;
      case SettingsId.UseLiveViewDisplayEffect:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusAreaSpot:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierState:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusModeToggleResponse:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD236:
        // TODO: Handle this case.
        break;
      case SettingsId.HalfPressShutter:
        // TODO: Handle this case.
        break;
      case SettingsId.CapturePhoto:
        // TODO: Handle this case.
        break;
      case SettingsId.AEL:
        return IntValue(usbValue);
      case SettingsId.UnkD2C5:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2C7:
        // TODO: Handle this case.
        break;
      case SettingsId.RecordVideo:
        // TODO: Handle this case.
        break;
      case SettingsId.FEL:
        return BoolValue(usbValue == 2);
      case SettingsId.FocusMagnifierRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierResetRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierMoveUpRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierMoveDownRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierMoveLeftRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierMoveRightRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusDistance:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusModeToggleRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2D3:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2D4:
        // TODO: Handle this case.
        break;
      case SettingsId.LiveViewInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.PhotoInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.Unknown:
        // TODO: Handle this case.
        break;
    }
  }
}

class BoolValue extends SettingsValue<bool> {
  BoolValue(bool id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => id ? 1 : 0;

  @override
  String get wifiValue => throw UnimplementedError();
}

class PointValue extends SettingsValue<Point> {
  PointValue(Point<num> id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => null;

  @override
  String get wifiValue => throw UnimplementedError();
}

class DoubleValue extends SettingsValue<double> {
  DoubleValue(double id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => null;

  @override
  String get wifiValue => throw UnimplementedError();
}

class ShutterSpeedValue extends DoubleValue {
  ShutterSpeedValue(double id) : super(id);

  @override
  String get name {
    if(id > 1.0){
      return "1/$id".replaceAll(".0", "");
    }
    return "$id\"";
  }
}

class IntValue extends SettingsValue<int> {
  IntValue(int id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => id;

  @override
  String get wifiValue => throw UnimplementedError();
}

abstract class SettingsValue<T> {
  T id;

  SettingsValue(this.id);

  SettingsValue.fromUSBValue(int usbValue);

  int get usbValue;

  String get wifiValue;

  String get name;
}

//TODO 0xFFFFFF -> auto iso