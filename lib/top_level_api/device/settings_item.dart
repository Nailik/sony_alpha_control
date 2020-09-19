//a set function is like "fmode" you have available settings and choose one
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/camera_function_id.dart';
import 'package:sonyalphacontrol/top_level_api/ids/camera_status_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/movie_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/movie_quality_ids.dart';
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

  //TODO stillsize(usb) - size and aspect ratio (wifi)
  //TODO drivemode cont and timer (usb) - single on wifi (different methods) TODO test
  //TODO cont shooting on wifi - on off via "start cont shooting" (bracket not wupporte?)
  //TODO cont shooting speed and state together in usb, different in wifi

  //TODO zusammengefasstes "teilen" auch in usb -> man wählt das eine aus,
//SettingsIdExtension.getSettingsIdWifi(value["type"].toString(
  SettingsValue fromWifi(String wifiValue, {String wifiSubValue = ""}) {
    switch (settingsId) {
      case SettingsId.FileFormat: //StillQuality
        return ImageFileFormatValue.fromWifiValue(wifiValue);
      case SettingsId.AvailableApiList:
        return StringValue(wifiValue);
      case SettingsId.CameraStatus:
        return CameraStatusValue.fromWifiValue(wifiValue);
      case SettingsId.ZoomStatus:
      //TODO return StringValue(wifiValue);
      case SettingsId.LiveViewState:
        return BoolValue(wifiValue as bool);
      case SettingsId.LiveViewOrientation:
        return StringValue(wifiValue); //TODO enum 0,90,180,270
      case SettingsId.PostViewUrlSet:
      //TODO
      case SettingsId.ContShootingUrlSet:
      //TODO
      case SettingsId.StorageInformation:
      //TODO return StringValue(wifiValue);
      case SettingsId.BeepMode:
        return StringValue(wifiValue); //TODO enum
      case SettingsId.CameraFunction:
        return CameraFunctionValue.fromWifiValue(wifiValue);
      case SettingsId.EV: //exposureCompensation
      //TODO  return IntValue(wifiValue);
      case SettingsId.MovieQuality:
        return MovieQualityValue.fromWifiValue(wifiValue);
      case SettingsId.StillSize:
      //TODO
      case SettingsId.CameraFunctionResult:
      //TODO
      case SettingsId.SteadyMode:
      //TODO "off" an "on"
      case SettingsId.ViewAngle:
      //TODO 120,70,-1
      case SettingsId.FlipSetting:
      //TODO
      case SettingsId.SceneSelection:
      //TODO
      case SettingsId.IntervalTime:
      //TODO
      case SettingsId.ColorSetting:
      //TODO
      case SettingsId.MovieFileFormat:
        return MovieFileFormatValue.fromWifiValue(wifiValue);
      case SettingsId.IRRemoteControl:
      //TODO
      case SettingsId.TvColorSystem:
      //TODO
      case SettingsId.PostViewImageSize:
      //TODO  return StringValue(wifiValue);
      case SettingsId.SelfTimer:
      //TODO  return StringValue(wifiValue);
      case SettingsId.ShootingMode:
      //TODO  return ShootingModeValue.fromWifiValue(wifiValue);
      case SettingsId.MeteringMode: //exposureMode
      //TODO  return MeteringModeValue.fromWifiValue(wifiValue);
      case SettingsId.FlashMode:
        return FlashModeValue.fromWifiValue(wifiValue);
      case SettingsId.FNumber:
      //TODO  return IntValue(wifiValue); //durch 100
      case SettingsId.FocusMode:
        return FocusModeValue.fromWifiValue(wifiValue);
      case SettingsId.ISO:
      //TODO  return StringValue(wifiValue);
      case SettingsId.ProgramShift:
      //TODO  return StringValue(wifiValue);
      case SettingsId.ShutterSpeed:
      //TODO return ShutterSpeedValue(wifiValue.toDouble(), subValue);
      case SettingsId.WhiteBalance:
      //TODO   return StringValue(wifiValue);
      case SettingsId.FocusAreaSpot: //touchAFPosition
      //TODO  return IntValue(wifiValue);
      case SettingsId.AutoFocusState:
      //TODO  return AutoFocusStateValue.fromWifiValue(wifiValue);
      case SettingsId.TrackingFocusStatus:
      //TODO
      case SettingsId.TrackingFocus:
      //TODO
      case SettingsId.ZoomSetting: //FocusStatus
      //TODO   return StringValue(wifiValue);
      case SettingsId.ContShootingMode:
      //TODO return ContShootingModeValue.fromWifiValue(wifiValue);
      case SettingsId.ContShootingSpeed:
      //TODO  return ContShootingSpeedValue.fromWifiValue(wifiValue);
      case SettingsId.BatteryInfo: //BatteryInformation
      //TODO   return IntValue(wifiValue);
      case SettingsId.SilentShooting:
      //TODO  return StringValue(wifiValue); //bool value?
      case SettingsId.RecordingTime:
      //TODO
      case SettingsId.NumberOfShots:
      //TODO
      case SettingsId.AutoPowerOff:
      //TODO
      case SettingsId.LoopRecordingTime:
      //TODO
      case SettingsId.AudioRecordingSetting:
      //TODO
      case SettingsId.WindNoiseReduction:
      //TODO
      case SettingsId.SilentShootingSetting:
      //TODO
      case SettingsId.BulbCapturingTime:
      //TODO
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
        : id > 0xFFFFFF
            ? "MultiFrame RM Standard"
            : "";
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
