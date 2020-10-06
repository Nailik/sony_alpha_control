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
import 'package:sonyalphacontrol/top_level_api/ids/live_view_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/movie_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/movie_quality_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/record_video_state_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_api_method_set.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/zoom_settings_ids.dart';

class SettingsItem<T extends SettingsValue> extends ChangeNotifier {
  SettingsId settingsId;

  T _value;

  T get value => _value;
  T _subValue;

  T get subValue => _subValue;
  List<T> _available = new List.unmodifiable({});

  List<T> get available => _available;
  List<T> _supported = new List.unmodifiable({});

  get supported => _supported;

  //not different setter to not notify layout changes too often when multiple values are updated at the same time one after another
  updateItem(
      T newValue, T newSubValue, List<T> newAvailable, List<T> newSupported) {
    if (value != newValue ||
        subValue != newSubValue ||
        available != newAvailable ||
        supported != newSupported) {
      //TODO list check all items?
      _value = newValue;
      _subValue = newSubValue;
      _available = new List.unmodifiable(newAvailable);
      _supported = new List.unmodifiable(newSupported);

      notifyListeners();
    }
  }

  SettingsItem(this.settingsId);

  bool hasSubValue() {
    return (settingsId == SettingsId.FocusAreaSpot ||
        settingsId == SettingsId.FocusMagnifierPosition ||
        settingsId == SettingsId.ShutterSpeed);
  }

  //TODO speichern welche methoden möglich sind für dieses "settingsid" item
  //TODO für wifi available apilist nutzen, für usb nur ob diese funktion implementiert ist
  //TODO methoden beim erstellen hinzufügen?


  //TODO stillsize(usb) - size and aspect ratio (wifi)
  //TODO drivemode cont and timer (usb) - single on wifi (different methods) TODO test
  //TODO cont shooting on wifi - on off via "start cont shooting" (bracket not wupporte?)
  //TODO cont shooting speed and state together in usb, different in wifi

  //TODO zusammengefasstes "teilen" auch in usb -> man wählt das eine aus,

//SettingsIdExtension.getSettingsIdWifi(value["type"].toString(
  SettingsValue fromWifi(dynamic wifiValue) {
    switch (settingsId) {
      case SettingsId.Versions:
        return WebApiVersionsValue.fromWifiValue(wifiValue);
      case SettingsId.MethodTypes:
        return WebApiMethodValue.fromWifiValue(wifiValue);
      case SettingsId.ImageFileFormat: //StillQuality
        return ImageFileFormatValue.fromWifiValue(wifiValue);
      case SettingsId.ApiList:
        return StringValue(wifiValue);
      case SettingsId.CameraStatus:
        return CameraStatusValue.fromWifiValue(wifiValue);
      case SettingsId.ZoomInformation:
      //TODO return StringValue(wifiValue);
      case SettingsId.LiveViewState:
        return BoolValue(wifiValue);
      case SettingsId.LiveViewOrientation:
        return StringValue(wifiValue); //TODO enum 0,90,180,270
      case SettingsId.PostViewUrlSet:
      //TODO
      case SettingsId.LiveViewSize:
        return LiveViewSizeValue.fromWifiValue(wifiValue);
      case SettingsId.ContShootingUrlSet:
      //TODO
      case SettingsId.StorageInformation:
      //TODO return StringValue(wifiValue);
      case SettingsId.BeepMode:
        return StringValue(wifiValue); //TODO enum
      case SettingsId.CameraFunction:
        return CameraFunctionValue.fromWifiValue(wifiValue);
      case SettingsId.EV: //exposureCompensation
        throw UnsupportedError; //this should never be called //EvValue(double.parse(wifiValue));
      case SettingsId.MovieQuality:
        return MovieQualityValue.fromWifiValue(wifiValue);
      case SettingsId.CameraFunctionResult:
      //TODO
      case SettingsId.SteadyMode:
        return OnOffValue(wifiValue);
      case SettingsId.ViewAngle:
        return IntValue(int.parse(wifiValue));
      case SettingsId.FlipSetting:
        return OnOffValue(wifiValue);
      case SettingsId.SceneSelection:
      //TODO
      case SettingsId.IntervalTime:
      //TODO
      case SettingsId.ColorSetting:
      //TODO
      case SettingsId.MovieFileFormat:
        return MovieFileFormatValue.fromWifiValue(wifiValue);
      case SettingsId.IRRemoteControl:
        return OnOffValue(wifiValue);
      case SettingsId.TvColorSystem:
      //TODO
      case SettingsId.PostViewImageSize:
         return StringValue(wifiValue);
      case SettingsId.SelfTimer:
        return IntValue(wifiValue);
      case SettingsId.ShootingMode:
      //TODO  return ShootingModeValue.fromWifiValue(wifiValue);
      case SettingsId.MeteringMode: //exposureMode
      //TODO  return MeteringModeValue.fromWifiValue(wifiValue);
      case SettingsId.FlashMode:
        return FlashModeValue.fromWifiValue(wifiValue);
      case SettingsId.FNumber:
        return DoubleValue(
            double.parse(wifiValue.replaceAll(",", "."))); //durch 100
      case SettingsId.FocusMode:
        return FocusModeValue.fromWifiValue(wifiValue);
      case SettingsId.ISO:
        return IsoValue.fromWifiValue(
            wifiValue); //TODO test noise reduction, auto ...
      case SettingsId.ProgramShift:
      //TODO  return StringValue(wifiValue);
      case SettingsId.ShutterSpeed:
        return ShutterSpeedValue.fromWifiValue(wifiValue);
      case SettingsId.WhiteBalanceMode:
        throw UnsupportedError; //should never be called return WhiteBalanceModeValue.fromWifiValue(wifiValue);
      case SettingsId.FocusAreaSpot: //touchAFPosition
      //TODO  return IntValue(wifiValue);
      case SettingsId.AutoFocusState:
      //TODO  return AutoFocusStateValue.fromWifiValue(wifiValue);
      case SettingsId.TrackingFocusStatus:
      //TODO
      case SettingsId.TrackingFocus:
        return OnOffValue(wifiValue);
      case SettingsId.ZoomSetting: //FocusStatus
      //TODO   return StringValue(wifiValue);
      case SettingsId.ZoomSetting: //FocusStatus
        return ZoomSettingValue.fromWifiValue(wifiValue);
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
      case SettingsId.ImageFileFormat:
        return ImageFileFormatValue.fromUSBValue(usbValue);
      case SettingsId.WhiteBalanceMode:
        return WhiteBalanceModeValue.fromUSBValue(usbValue);
      case SettingsId.FNumber:
        return DoubleValue(usbValue as double); //TODO test
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
        return IsoValue(usbValue);
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
      case SettingsId.Versions:
        return throw UnsupportedError;
      default:
        return throw UnsupportedError;
    }
  }

  createListFromWifiJson(List<dynamic> list) =>
      list.map<T>((e) => fromWifi(e)).toList();
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
  String get wifiValue => id.toString();
}

class OnOffValue extends SettingsValue<String> {
  OnOffValue(String id) : super(id); //"on" or "off"

  @override
  String get name => id.toString();

  @override
  int get usbValue => id == "on" ? 1 : 0;

  @override
  String get wifiValue => id.toString();
}

class PointValue extends SettingsValue<Point> {
  PointValue(Point<num> id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => null;

  @override
  String get wifiValue => id.toString();
}

class DoubleValue extends SettingsValue<double> {
  DoubleValue(double id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => id.toInt();

  @override
  String get wifiValue => id.toString();
}

class EvValue extends DoubleValue {
  final int index;
  final int step; //0 = problem, 2 = 2/3, 3 = 1/3;

  EvValue(this.index, this.step, double id) : super(id);
}

class ShutterSpeedValue extends DoubleValue {
  var subValue;
  var _name;

  ShutterSpeedValue(double id, this.subValue) : super(id);

  @override
  String get name => _name;

  @override
  String get wifiValue => _name; //TODO really parse the id value

  @override
  factory ShutterSpeedValue.fromWifiValue(String wifiValue) {
    double value = wifiValue.contains("/")
        ? double.parse(wifiValue.split("/")[0]) /
            double.parse(wifiValue.split("/")[1])
        : wifiValue == "BULB"
            ? 0xFFFFFF
            : double.parse(wifiValue.replaceAll("\"", "").replaceAll(",", "."));
    var it = ShutterSpeedValue(value, 0);
    it._name = wifiValue;
    return it;
  }

  @override
  factory ShutterSpeedValue.fromUsbValue(double usbValue, double subValue) {
    //TODO bulb value? even used or just up and down one step?
    var it = ShutterSpeedValue(usbValue, subValue);
    if (subValue == -1) {
      it._name = it.id.toString();
    } else if (subValue == 1) {
      it._name = "1/${it.id.toInt()}";
    } else {
      it._name = "0.$subValue\"";
    }
    return it;
  }
}

class IsoValue extends IntValue {
  IsoValue(int id) : super(id);

  @override
  factory IsoValue.fromWifiValue(String wifiValue) =>
      IsoValue(wifiValue == "AUTO" ? 0xFFFFFF : int.parse(wifiValue));

  @override
  String get wifiValue => id == 0xFFFFFF ? "AUTO" : id.toString();

  @override
  String get name {
    var multiFrame = id > (2 * 0xFFFFFF)
        ? "MultiFrame RM High"
        : id > 0xFFFFFF
            ? "MultiFrame RM Standard"
            : "";
    var auto =
        id == 0xFFFFFF || id == (2 * 0xFFFFFF) + 1 || id == (3 * 0xFFFFFF) + 2
            ? "Auto"
            : "";
    var value = id % 0xFFFFFF - id ~/ 0xFFFFFF;
    return "${auto.isEmpty ? value : auto} $multiFrame"; //TODO enums for text?
  }
}

class IntValue extends SettingsValue<int> {
  IntValue(int id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => id;

  @override
  String get wifiValue => id.toString();
}

class WhiteBalanceColorTempValue extends IntValue {
  final WhiteBalanceModeId whiteBalanceModeId;

  WhiteBalanceColorTempValue(int id, this.whiteBalanceModeId) : super(id);

  static WhiteBalanceColorTempValue fromUSBValue(int value) {}
}

abstract class SettingsValue<T> {
  T id;

  SettingsValue(this.id);

  SettingsValue.fromUSBValue(int usbValue);

  SettingsValue.fromWifiValue(String wifiValue);

  int get usbValue;

  String get wifiValue;

  String get name;

  @override
  String toString() => name;

  bool operator ==(o) => o is SettingsValue<T> && id == o.id;

  @override
  int get hashCode => id.hashCode;
}
