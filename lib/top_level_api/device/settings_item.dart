//a set function is like "fmode" you have available settings and choose one
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
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
import 'file:///C:/Users/kilia/CloudStation/Dokumente/Projects/sony_alpha_control/lib/top_level_api/ids/camera_function_id.dart';

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

  //TODO stillsize(usb) - size and aspect ratio (wifi)
  //TODO drivemode cont and timer (usb) - single on wifi (different methods) TODO test
  //TODO cont shooting on wifi - on off via "start cont shooting" (bracket not wupporte?)
  //TODO cont shooting speed and state together in usb, different in wifi

  //TODO zusammengefasstes "teilen" auch in usb -> man wählt das eine aus,
//SettingsIdExtension.getSettingsIdWifi(value["type"].toString(
  SettingsValue fromWifi(String wifiValue, {String wifiSubValue = ""}) {
    switch (settingsId) {
      case SettingsId.AvailableApiList:
        return StringValue(wifiValue);
      case SettingsId.CameraStatus:
        return StringValue(wifiValue);
      case SettingsId.ZoomStatus:
        return StringValue(wifiValue);
      case SettingsId.LiveViewState:
        return BoolValue(wifiValue);
      case SettingsId.StorageInformation:
        return StringValue(wifiValue);
      case SettingsId.CameraFunction:
        return CameraFunctionValue.fromWifiValue(wifiValue);
      case SettingsId.EV: //exposureCompensation
        return IntValue(wifiValue);
      case SettingsId.PostViewImageSize:
        return StringValue(wifiValue);
      case SettingsId.SelfTimer:
        return StringValue(wifiValue);
      case SettingsId.ShootingMode:
        return ShootingModeValue.fromWifiValue(wifiValue);
      case SettingsId.MeteringMode: //exposureMode
        return MeteringModeValue.fromWifiValue(wifiValue);
      case SettingsId.FlashMode:
        return FlashModeValue.fromWifiValue(wifiValue);
      case SettingsId.FNumber:
        return IntValue(wifiValue); //durch 100
      case SettingsId.FocusMode:
        return FocusModeValue.fr(wifiValue);
      case SettingsId.ISO:
        return StringValue(wifiValue);
      case SettingsId.ProgramShift:
        return StringValue(wifiValue);
      case SettingsId.ShutterSpeed:
        return ShutterSpeedValue(wifiValue.toDouble(), subValue);
      case SettingsId.WhiteBalance:
        return StringValue(wifiValue);
      case SettingsId.FocusAreaSpot: //touchAFPosition
        return IntValue(wifiValue);
      case SettingsId.AutoFocusState:
        return AutoFocusStateValue.fromWifiValue(wifiValue);
      case SettingsId.ZoomSetting:
        return StringValue(wifiValue);
      case SettingsId.ContShootingMode:
        return ContShootingModeValue.fromWifiValue(wifiValue);
      case SettingsId.ContShootingSpeed:
        return ContShootingSpeedValue.fromWifiValue(wifiValue);
      case SettingsId.BatteryInfo:
        return IntValue(wifiValue);
      case SettingsId.SilentShooting:
        return StringValue(wifiValue); //bool value?
      default:
        return null;
        break;
    }
  }

  SettingsValue fromUsb(int usbValue, {int subValue = 1}) {
    switch (settingsId) {
      case SettingsId.FileFormat:
        return ImageFileFormatValue.fromUSBValue(usbValue);
      case SettingsId.WhiteBalance:
        return WhiteBalanceValue.fromUSBValue(usbValue);
      case SettingsId.FNumber:
        return IntValue(usbValue);
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
      case SettingsId.FlashValue:
        return IntValue(usbValue);
      case SettingsId.DroHdr:
        return DroHdrValue.fromUSBValue(usbValue);
      case SettingsId.ImageSize:
        return ImageSizeValue.fromUSBValue(usbValue);
      case SettingsId.ShutterSpeed:
        return ShutterSpeedValue(usbValue.toDouble(), subValue);
      case SettingsId.UnkD20E:
        print("UnkD20E $usbValue");
        return IntValue(usbValue);
      case SettingsId.WhiteBalanceColorTemp:
        return IntValue(usbValue);
      case SettingsId.WhiteBalanceGM:
        return WhiteBalanceGmValue.fromUSBValue(usbValue);
      case SettingsId.AspectRatio:
        return AspectRatioValue.fromUSBValue(usbValue);
      case SettingsId.UnkD212:
        print("UnkD212 $usbValue");
        return IntValue(usbValue);
      case SettingsId.AutoFocusState:
        return AutoFocusStateValue.fromUSBValue(usbValue);
      case SettingsId.Zoom:
        return IntValue(usbValue);
      case SettingsId.PhotoTransferQueue:
        return IntValue(usbValue); //32769  & 0xFF
      case SettingsId.AEL_State:
        return BoolValue(usbValue == 2);
      case SettingsId.BatteryInfo:
        return IntValue(usbValue);
      case SettingsId.SensorCrop:
        return BoolValue(usbValue == 2);
      case SettingsId.PictureEffect:
        return PictureEffectValue.fromUSBValue(usbValue);
      case SettingsId.WhiteBalanceAB:
        return WhiteBalanceAbValue.fromUSBValue(usbValue);
      case SettingsId.RecordVideoState:
        return RecordVideoStateValue.fromUSBValue(usbValue);
      case SettingsId.ISO:
        return IsoValue(usbValue.toDouble());
      case SettingsId.FEL_State:
        return BoolValue(usbValue == 2);
      case SettingsId.LiveViewState:
        return BoolValue(usbValue == 2);
      case SettingsId.UnkD222:
        print("UnkD222 $usbValue");
        return IntValue(usbValue);
      case SettingsId.FocusArea:
        return FocusAreaValue.fromUSBValue(usbValue);
      case SettingsId.FocusMagnifierPhase:
        return FocusMagnifierPhaseValue.fromUSBValue(usbValue);
      case SettingsId.UnkD22E:
        print("UnkD22E $usbValue");
        return IntValue(usbValue);
      case SettingsId.FocusMagnifier:
        return IntValue(usbValue);
      case SettingsId.FocusMagnifierPosition:
        return IntValue(usbValue);
      case SettingsId.UseLiveViewDisplayEffect:
        return BoolValue(usbValue == 2);
      case SettingsId.FocusAreaSpot:
        return IntValue(usbValue);
      case SettingsId.FocusMagnifierState:
        return BoolValue(usbValue == 2);
      case SettingsId.FocusModeToggleResponse:
        return IntValue(usbValue);
      case SettingsId.UnkD236:
        print("UnkD236 $usbValue");
        return IntValue(usbValue);
      case SettingsId.HalfPressShutter:
        return BoolValue(usbValue == 2);
      case SettingsId.CapturePhoto:
        return BoolValue(usbValue == 2);
      case SettingsId.AEL:
        return IntValue(usbValue);
      case SettingsId.UnkD2C5:
        print("UnkD2C5 $usbValue");
        return IntValue(usbValue);
      case SettingsId.UnkD2C7:
        print("UnkD2C7 $usbValue");
        return IntValue(usbValue);
      case SettingsId.RecordVideo:
        return BoolValue(usbValue == 2);
      case SettingsId.FEL:
        return BoolValue(usbValue == 2);
      case SettingsId.FocusMagnifierRequest:
        return IntValue(usbValue);
      case SettingsId.FocusMagnifierResetRequest:
        return IntValue(usbValue);
      case SettingsId.FocusMagnifierMoveUpRequest:
        return IntValue(usbValue);
      case SettingsId.FocusMagnifierMoveDownRequest:
        return IntValue(usbValue);
      case SettingsId.FocusMagnifierMoveLeftRequest:
        return IntValue(usbValue);
      case SettingsId.FocusMagnifierMoveRightRequest:
        return IntValue(usbValue);
      case SettingsId.FocusDistance:
        return IntValue(usbValue);
      case SettingsId.FocusModeToggleRequest:
        return IntValue(usbValue);
      case SettingsId.UnkD2D3:
        print("UnkD2D3 $usbValue");
        return IntValue(usbValue);
      case SettingsId.UnkD2D4:
        print("UnkD2D4 $usbValue");
        return IntValue(usbValue);
      case SettingsId.LiveViewInfo:
        return IntValue(usbValue);
      case SettingsId.PhotoInfo:
        return IntValue(usbValue);
      case SettingsId.Unknown:
        print("Unknown $usbValue");
        return IntValue(usbValue);
      case SettingsId.AvailableSettings:
        return IntValue(usbValue);
      case SettingsId.CameraInfo:
        return IntValue(usbValue);
      case SettingsId.Connect:
        return IntValue(usbValue);
      default:
        return null;
    }
  }
}

class StringValue extends SettingsValue<String> {
  StringValue(String id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => throw UnimplementedError();

  @override
  String get wifiValue => id;
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
  var subValue;

  ShutterSpeedValue(double id, this.subValue) : super(id);

  @override
  String get name {
    if (subValue == 1) {
      return "1/${id.toInt()}";
    }
    return "0.$subValue\"";
  }
}

class IsoValue extends DoubleValue {
  IsoValue(double id) : super(id);

  @override
  String get name {
    var multiFrame = id > (2 * 0xFFFFFF)
        ? "MultiFrame RM Hoch"
        : id > 0xFFFFFF ? "MultiFrame RM Standard" : "";
    var auto =
        id == 0xFFFFFF || id == (2 * 0xFFFFFF) + 1 || id == (3 * 0xFFFFFF) + 2
            ? "Auto"
            : "";
    var value = id % 0xFFFFFF - id ~/ 0xFFFFFF;
    return "${auto.isEmpty ? value : auto} $multiFrame";
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

  SettingsValue.fromWifiValue(String wifiValue);

  int get usbValue;

  String get wifiValue;

  String get name;
}

//TODO 0xFFFFFF -> auto iso
