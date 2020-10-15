// ignore: avoid_web_libraries_in_flutter

import 'dart:math';

import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/beep_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/camera_function_id.dart';
import 'package:sonyalphacontrol/top_level_api/ids/camera_status_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/color_setting_parameter_value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/cont_shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/cont_shooting_speed_ids.dart';
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
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/live_view_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/movie_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/movie_quality_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/post_view_image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/record_video_state_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/scene_selection_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/shoot_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_api_method_set.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/tv_color_system_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/zoom_settings_ids.dart';

abstract class Value<T> {
  T id;

  Value(this.id);

  Value.fromUSBValue(int usbValue);

  Value.fromWifiValue(String wifiValue);

  int get usbValue;

  String get wifiValue;

  String get name;

  @override
  String toString() => name;

  @override
  bool operator ==(o) => o is Value<T> && id == o.id;

  @override
  int get hashCode => id.hashCode;

  static Value fromWifi(ItemId itemId, dynamic wifiValue) {
    switch (itemId) {
      case ItemId.Versions:
        return WebApiVersionsValue.fromWifiValue(wifiValue);
      case ItemId.MethodTypes:
        return WebApiMethodValue.fromWifiValue(wifiValue);
      case ItemId.ImageFileFormat: //StillQuality
        return ImageFileFormatValue.fromWifiValue(wifiValue);
      case ItemId.ApiList:
        return ApiFunctionValue.fromWifiValue(wifiValue);
      case ItemId.CameraStatus:
        return CameraStatusValue.fromWifiValue(wifiValue);
      case ItemId.ZoomInformation:
      //TODO return StringValue(wifiValue);
      case ItemId.LiveViewState:
        return BoolValue(wifiValue);
      case ItemId.LiveViewOrientation:
        return StringValue(wifiValue); //TODO enum 0,90,180,270
      case ItemId.ShootMode:
        return ShootModeValue.fromWifiValue(wifiValue);
      case ItemId.PostViewUrlSet:
      //TODO
      case ItemId.LiveViewSize:
        return LiveViewSizeValue.fromWifiValue(wifiValue);
      case ItemId.ContShootingUrlSet:
      //TODO
      case ItemId.AvailableSettings:
        return StringValue(wifiValue.toString());
      case ItemId.ApplicationInfo:
        return StringValue(wifiValue);
      case ItemId.StorageInformation:
       return StringValue(wifiValue);
      case ItemId.CapturePhoto:
        return StringValue(wifiValue);
      case ItemId.BeepMode:
        return StringValue(wifiValue); //TODO enum
      case ItemId.CameraFunction:
        return CameraFunctionValue.fromWifiValue(wifiValue);
      case ItemId.ExposureCompensation: //exposureCompensation
        throw UnsupportedError; //this should never be called //EvValue(double.parse(wifiValue));
      case ItemId.MovieQuality:
        return MovieQualityValue.fromWifiValue(wifiValue);
      case ItemId.CameraFunctionResult:
      //TODO
      case ItemId.SteadyMode:
        return OnOffValue(wifiValue);
      case ItemId.ViewAngle:
        return IntValue(int.parse(wifiValue));
      case ItemId.FlipSetting:
        return OnOffValue(wifiValue);
      case ItemId.SceneSelection:
      //TODO
      case ItemId.IntervalTime:
      //TODO
      case ItemId.ColorSetting:
      //TODO
      case ItemId.MovieFileFormat:
        return MovieFileFormatValue.fromWifiValue(wifiValue);
      case ItemId.IRRemoteControl:
        return OnOffValue(wifiValue);
      case ItemId.TvColorSystem:
      //TODO
      case ItemId.ImageSize:
        return ImageSizeValue.fromWifiValue(wifiValue);
      case ItemId.PostViewImageSize:
        return PostViewImageSizeValue.fromWifiValue(wifiValue);
      case ItemId.SelfTimer:
        return IntValue(wifiValue);
      case ItemId.ShootMode:
      //TODO  return ShootingModeValue.fromWifiValue(wifiValue);
      case ItemId.MeteringMode: //exposureMode
        return MeteringModeValue.fromWifiValue(wifiValue);
      case ItemId.FlashMode:
        return FlashModeValue.fromWifiValue(wifiValue);
      case ItemId.FNumber:
        return DoubleValue(
            double.parse(wifiValue.replaceAll(",", "."))); //durch 100
      case ItemId.FocusMode:
        return FocusModeValue.fromWifiValue(wifiValue);
      case ItemId.ISO:
        return IsoValue.fromWifiValue(
            wifiValue); //TODO test noise reduction, auto ...
      case ItemId.ProgramShift:
        return IntValue(wifiValue);
      case ItemId.ShutterSpeed:
        return ShutterSpeedValue.fromWifiValue(wifiValue);
      case ItemId.WhiteBalanceMode:
        throw UnsupportedError; //should never be called return WhiteBalanceModeValue.fromWifiValue(wifiValue);
      case ItemId.FocusAreaSpot: //touchAFPosition
      //TODO  return IntValue(wifiValue);
      case ItemId.AutoFocusState:
      //TODO  return AutoFocusStateValue.fromWifiValue(wifiValue);
      case ItemId.TrackingFocusStatus:
      //TODO
      case ItemId.TrackingFocus:
        return OnOffValue(wifiValue);
      case ItemId.ZoomSetting: //FocusStatus
        return ZoomSettingValue.fromWifiValue(wifiValue);
      case ItemId.ContShootingMode:
        return ContShootingModeValue.fromWifiValue(wifiValue);
      case ItemId.ContShootingSpeed:
        return ContShootingSpeedValue.fromWifiValue(wifiValue);
      case ItemId.BatteryInfo: //BatteryInformation
      //TODO   return IntValue(wifiValue);
      case ItemId.SilentShooting:
        return OnOffValue(wifiValue); //bool value?
      case ItemId.RecordingTime:
      //TODO
      case ItemId.NumberOfShots:
      //TODO
      case ItemId.AutoPowerOff:
      //TODO
      case ItemId.LoopRecordingTime:
      //TODO
      case ItemId.AudioRecordingSetting:
      //TODO
      case ItemId.WindNoiseReduction:
      //TODO
      case ItemId.BulbCapturingTime:
      //TODO
      default:
        return null;
        break;
    }
  }

  static fromUsb(ItemId itemId, int usbValue, {int subValue = 1}) {
    switch (itemId) {
      case ItemId.ImageFileFormat:
        return ImageFileFormatValue.fromUSBValue(usbValue);
      case ItemId.WhiteBalanceMode:
        return WhiteBalanceModeValue.fromUSBValue(usbValue);
      case ItemId.FNumber:
        return DoubleValue(usbValue as double); //TODO test
      case ItemId.FocusMode:
        return FocusModeValue.fromUSBValue(usbValue);
      case ItemId.MeteringMode:
        return MeteringModeValue.fromUSBValue(usbValue);
      case ItemId.FlashMode:
        return FlashModeValue.fromUSBValue(usbValue);
      case ItemId.ShootMode:
        return ShootingModeValue.fromUSBValue(usbValue);
      case ItemId.ExposureCompensation:
        return IntValue(usbValue);
      case ItemId.DriveMode:
        return DriveModeValue.fromUSBValue(usbValue);
      case ItemId.FlashValue:
        return IntValue(usbValue);
      case ItemId.DroHdr:
        return DroHdrValue.fromUSBValue(usbValue);
      case ItemId.ImageSize:
        return ImageSizeValue.fromUSBValue(usbValue);
      case ItemId.ShutterSpeed:
        return ShutterSpeedValue(usbValue.toDouble(), subValue);
      case ItemId.UnkD20E:
        print("UnkD20E $usbValue");
        return IntValue(usbValue);
      case ItemId.WhiteBalanceColorTemp:
        return IntValue(usbValue);
      case ItemId.WhiteBalanceGM:
        return WhiteBalanceGmValue.fromUSBValue(usbValue);
      case ItemId.AspectRatio:
        return AspectRatioValue.fromUSBValue(usbValue);
      case ItemId.UnkD212:
        print("UnkD212 $usbValue");
        return IntValue(usbValue);
      case ItemId.AutoFocusState:
        return AutoFocusStateValue.fromUSBValue(usbValue);
      case ItemId.Zoom:
        return IntValue(usbValue);
      case ItemId.PhotoTransferQueue:
        return IntValue(usbValue); //32769  & 0xFF
      case ItemId.AEL_State:
        return BoolValue(usbValue == 2);
      case ItemId.BatteryInfo:
        return IntValue(usbValue);
      case ItemId.SensorCrop:
        return BoolValue(usbValue == 2);
      case ItemId.PictureEffect:
        return PictureEffectValue.fromUSBValue(usbValue);
      case ItemId.WhiteBalanceAB:
        return WhiteBalanceAbValue.fromUSBValue(usbValue);
      case ItemId.RecordVideoState:
        return RecordVideoStateValue.fromUSBValue(usbValue);
      case ItemId.ISO:
        return IsoValue(usbValue);
      case ItemId.FEL_State:
        return BoolValue(usbValue == 2);
      case ItemId.LiveViewState:
        return BoolValue(usbValue == 2);
      case ItemId.UnkD222:
        print("UnkD222 $usbValue");
        return IntValue(usbValue);
      case ItemId.FocusArea:
        return FocusAreaValue.fromUSBValue(usbValue);
      case ItemId.FocusMagnifierPhase:
        return FocusMagnifierPhaseValue.fromUSBValue(usbValue);
      case ItemId.UnkD22E:
        print("UnkD22E $usbValue");
        return IntValue(usbValue);
      case ItemId.FocusMagnifier:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierPosition:
        return IntValue(usbValue);
      case ItemId.UseLiveViewDisplayEffect:
        return BoolValue(usbValue == 2);
      case ItemId.FocusAreaSpot:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierState:
        return BoolValue(usbValue == 2);
      case ItemId.FocusModeToggleResponse:
        return IntValue(usbValue);
      case ItemId.UnkD236:
        print("UnkD236 $usbValue");
        return IntValue(usbValue);
      case ItemId.HalfPressShutter:
        return BoolValue(usbValue == 2);
      case ItemId.CapturePhoto:
        return BoolValue(usbValue == 2);
      case ItemId.AEL:
        return IntValue(usbValue);
      case ItemId.UnkD2C5:
        print("UnkD2C5 $usbValue");
        return IntValue(usbValue);
      case ItemId.UnkD2C7:
        print("UnkD2C7 $usbValue");
        return IntValue(usbValue);
      case ItemId.RecordVideo:
        return BoolValue(usbValue == 2);
      case ItemId.FEL:
        return BoolValue(usbValue == 2);
      case ItemId.FocusMagnifierRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierResetRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierMoveUpRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierMoveDownRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierMoveLeftRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierMoveRightRequest:
        return IntValue(usbValue);
      case ItemId.FocusDistance:
        return IntValue(usbValue);
      case ItemId.FocusModeToggleRequest:
        return IntValue(usbValue);
      case ItemId.UnkD2D3:
        print("UnkD2D3 $usbValue");
        return IntValue(usbValue);
      case ItemId.UnkD2D4:
        print("UnkD2D4 $usbValue");
        return IntValue(usbValue);
      case ItemId.LiveViewInfo:
        return IntValue(usbValue);
      case ItemId.PhotoInfo:
        return IntValue(usbValue);
      case ItemId.Unknown:
        print("Unknown $usbValue");
        return IntValue(usbValue);
      case ItemId.AvailableSettings:
        return IntValue(usbValue);
      case ItemId.CameraInfo:
        return IntValue(usbValue);
      case ItemId.Connect:
        return IntValue(usbValue);
      case ItemId.Versions:
        throw UnsupportedError;
      default:
        throw UnsupportedError;
    }
  }
}

extension StringExtension on String {
  String get startCap => "${this[0].toUpperCase()}${this.substring(1)}";

  String get startLow => "${this[0].toLowerCase()}${this.substring(1)}";
}

class StringValue extends Value<String> {
  StringValue(String id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => throw UnimplementedError();

  @override
  String get wifiValue => id;
}

class BoolValue extends Value<bool> {
  BoolValue(bool id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => id ? 1 : 0;

  @override
  String get wifiValue => id.toString();
}

class OnOffValue extends Value<String> {
  OnOffValue(String id) : super(id); //"On" or "Off" //TODO enums

  @override
  String get name => id.toString();

  @override
  int get usbValue => id == "On" ? 1 : 0;

  @override
  String get wifiValue => id.toString();
}

class PointValue extends Value<Point> {
  PointValue(Point<num> id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => null;

  @override
  String get wifiValue => id.toString();
}

class DoubleValue extends Value<double> {
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

class IntValue extends Value<int> {
  IntValue(int id) : super(id);

  @override
  String get name => id.toString();

  @override
  int get usbValue => id;

  @override
  String get wifiValue => id
      .toString(); //TODO for ints wifi value has to be still an int no string :/
}

class WhiteBalanceColorTempValue extends IntValue {
  final WhiteBalanceModeId whiteBalanceModeId;

  WhiteBalanceColorTempValue(int id, this.whiteBalanceModeId) : super(id);

  static WhiteBalanceColorTempValue fromUSBValue(int value) =>
      throw UnsupportedError;
}

class WebApiVersionsValue extends Value<WebApiVersionId> {
  WebApiVersionsValue(WebApiVersionId id) : super(id);

  @override
  factory WebApiVersionsValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory WebApiVersionsValue.fromWifiValue(String wifiValue) =>
      WebApiVersionsValue(WebApiVersionIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class AspectRatioValue extends Value<AspectRatioId> {
  AspectRatioValue(AspectRatioId id) : super(id);

  @override
  factory AspectRatioValue.fromUSBValue(int usbValue) =>
      AspectRatioValue(AspectRatioIdExtension.getIdFromUsb(usbValue));

  @override
  factory AspectRatioValue.fromWifiValue(String wifiValue) =>
      AspectRatioValue(AspectRatioIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class AutoFocusStateValue extends Value<AutoFocusStateId> {
  AutoFocusStateValue(AutoFocusStateId id) : super(id);

  @override
  factory AutoFocusStateValue.fromUSBValue(int usbValue) =>
      AutoFocusStateValue(AutoFocusStateIdExtension.getIdFromUsb(usbValue));

  @override
  factory AutoFocusStateValue.fromWifiValue(String wifiValue) =>
      AutoFocusStateValue(AutoFocusStateIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class CameraFunctionValue extends Value<CameraFunctionId> {
  CameraFunctionValue(CameraFunctionId id) : super(id);

  @override
  factory CameraFunctionValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory CameraFunctionValue.fromWifiValue(String wifiValue) =>
      CameraFunctionValue(CameraFunctionIdExtension.getIdFromWifi(wifiValue));

  @override
  String get name => id.name;

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;
}

class BeepModeValue extends Value<BeepModeId> {
  BeepModeValue(BeepModeId id) : super(id);

  @override
  factory BeepModeValue.fromUSBValue(int usbValue) => throw UnsupportedError;

  @override
  factory BeepModeValue.fromWifiValue(String wifiValue) => BeepModeValue(BeepModeIdExtension.getIdFromWifi(wifiValue));

  @override
  String get name => id.name;

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;
}

class CameraStatusValue extends Value<CameraStatusId> {
  CameraStatusValue(CameraStatusId id) : super(id);

  @override
  factory CameraStatusValue.fromUSBValue(int usbValue) =>
      CameraStatusValue(CameraStatusIdExtension.getIdFromUsb(usbValue));

  @override
  factory CameraStatusValue.fromWifiValue(String wifiValue) =>
      CameraStatusValue(CameraStatusIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class TvColorSystemValue extends Value<TvColorSystemId> {
  TvColorSystemValue(TvColorSystemId id) : super(id);

  @override
  factory TvColorSystemValue.fromUSBValue(int usbValue) => throw UnsupportedError;

  @override
  factory TvColorSystemValue.fromWifiValue(String wifiValue) =>
      TvColorSystemValue(TvColorSystemIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class DriveModeValue extends Value<DriveModeId> {
  DriveModeValue(DriveModeId id) : super(id);

  @override
  factory DriveModeValue.fromUSBValue(int usbValue) => DriveModeValue(DriveModeIdExtension.getIdFromUsb(usbValue));

  @override
  factory DriveModeValue.fromWifiValue(String wifiValue) =>
      DriveModeValue(DriveModeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class ShootModeValue extends Value<ShootModeId> {
  ShootModeValue(ShootModeId id) : super(id);

  @override
  factory ShootModeValue.fromUSBValue(int usbValue) => throw UnsupportedError;

  @override
  factory ShootModeValue.fromWifiValue(String wifiValue) =>
      ShootModeValue(ShootModeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class DroHdrValue extends Value<DroHdrId> {
  DroHdrValue(DroHdrId id) : super(id);

  @override
  factory DroHdrValue.fromUSBValue(int usbValue) => DroHdrValue(DroHdrIdExtension.getIdFromUsb(usbValue));

  @override
  factory DroHdrValue.fromWifiValue(String wifiValue) => DroHdrValue(DroHdrIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class FlashModeValue extends Value<FlashModeId> {
  FlashModeValue(FlashModeId id) : super(id);

  @override
  factory FlashModeValue.fromUSBValue(int usbValue) =>
      FlashModeValue(FlashModeIdExtension.getIdFromUsb(usbValue));

  @override
  factory FlashModeValue.fromWifiValue(String wifiValue) =>
      FlashModeValue(FlashModeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class MovieQualityValue extends Value<MovieQualityId> {
  MovieQualityValue(MovieQualityId id) : super(id);

  @override
  factory MovieQualityValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory MovieQualityValue.fromWifiValue(String wifiValue) =>
      MovieQualityValue(MovieFileQualityIdExtension.getIdFromWifi(wifiValue));

  @override
  String get name => id.name;

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;
}

class SceneSelectionValue extends Value<SceneSelectionId> {
  SceneSelectionValue(SceneSelectionId id) : super(id);

  @override
  factory SceneSelectionValue.fromUSBValue(int usbValue) => throw UnsupportedError;

  @override
  factory SceneSelectionValue.fromWifiValue(String wifiValue) =>
      SceneSelectionValue(SceneSelectionIdExtension.getIdFromWifi(wifiValue));

  @override
  String get name => id.name;

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;
}

class ColorSettingValue extends Value<ColorSettingParameterId> {
  ColorSettingValue(ColorSettingParameterId id) : super(id);

  @override
  factory ColorSettingValue.fromUSBValue(int usbValue) => throw UnsupportedError;

  @override
  factory ColorSettingValue.fromWifiValue(String wifiValue) =>
      ColorSettingValue(ColorSettingParameterIdExtension.getIdFromWifi(wifiValue));

  @override
  String get name => id.name;

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;
}

class OpCodeValue extends Value<OpCodeId> {
  OpCodeValue(OpCodeId id) : super(id);

  @override
  factory OpCodeValue.fromUSBValue(int usbValue) => OpCodeValue(OpCodesExtension.getIdFromUsb(usbValue));

  @override
  factory OpCodeValue.fromWifiValue(String wifiValue) => OpCodeValue(OpCodesExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class LiveViewSizeValue extends Value<LiveViewSizeId> {
  LiveViewSizeValue(LiveViewSizeId id) : super(id);

  @override
  factory LiveViewSizeValue.fromUSBValue(int usbValue) =>
      throw UnimplementedError;

  @override
  factory LiveViewSizeValue.fromWifiValue(String wifiValue) =>
      LiveViewSizeValue(LiveViewSizeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnimplementedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class PostViewImageSizeValue extends Value<PostViewImageSizeId> {
  PostViewImageSizeValue(PostViewImageSizeId id) : super(id);

  @override
  factory PostViewImageSizeValue.fromUSBValue(int usbValue) =>
      throw UnimplementedError;

  @override
  factory PostViewImageSizeValue.fromWifiValue(String wifiValue) =>
      PostViewImageSizeValue(
          PostViewImageSizeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnimplementedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class MovieFileFormatValue extends Value<MovieFileFormatId> {
  MovieFileFormatValue(MovieFileFormatId id) : super(id);

  @override
  factory MovieFileFormatValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory MovieFileFormatValue.fromWifiValue(String wifiValue) =>
      MovieFileFormatValue(MovieFileFormatIdExtension.getIdFromWifi(wifiValue));

  @override
  String get name => id.name;

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;
}

class RecordVideoStateValue extends Value<RecordVideoStateId> {
  RecordVideoStateValue(RecordVideoStateId id) : super(id);

  @override
  factory RecordVideoStateValue.fromUSBValue(int usbValue) =>
      RecordVideoStateValue(RecordVideoStateIdExtension.getIdFromUsb(usbValue));

  @override
  factory RecordVideoStateValue.fromWifiValue(String wifiValue) =>
      RecordVideoStateValue(
          RecordVideoStateIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class ImageSizeValue extends Value<ImageSizeId> {
  final AspectRatioId aspectRatioId;

  ImageSizeValue(ImageSizeId id, this.aspectRatioId) : super(id);

  @override
  factory ImageSizeValue.fromUSBValue(int usbValue) =>
      ImageSizeValue(ImageSizeIdExtension.getIdFromUsb(usbValue), null);

  @override
  factory ImageSizeValue.fromWifiValue(dynamic wifiValue) => ImageSizeValue(
      ImageSizeIdExtension.getIdFromWifi(wifiValue["size"]), AspectRatioIdExtension.getIdFromWifi(wifiValue["aspect"]));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class ShootingModeValue extends Value<ShootingModeId> {
  ShootingModeValue(ShootingModeId id) : super(id);

  @override
  factory ShootingModeValue.fromUSBValue(int usbValue) =>
      ShootingModeValue(ShootingModeIdExtension.getIdFromUsb(usbValue));

  @override
  factory ShootingModeValue.fromWifiValue(String wifiValue) =>
      ShootingModeValue(ShootingModeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class FocusMagnifierPhaseValue extends Value<FocusMagnifierPhaseId> {
  FocusMagnifierPhaseValue(FocusMagnifierPhaseId id) : super(id);

  @override
  factory FocusMagnifierPhaseValue.fromUSBValue(int usbValue) =>
      FocusMagnifierPhaseValue(
          FocusMagnifierPhaseIdExtension.getIdFromUsb(usbValue));

  @override
  factory FocusMagnifierPhaseValue.fromWifiValue(String wifiValue) =>
      FocusMagnifierPhaseValue(
          FocusMagnifierPhaseIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class FocusModeValue extends Value<FocusModeId> {
  FocusModeValue(FocusModeId id) : super(id);

  @override
  factory FocusModeValue.fromUSBValue(int usbValue) =>
      FocusModeValue(FocusModeIdExtension.getIdFromUsb(usbValue));

  @override
  factory FocusModeValue.fromWifiValue(String wifiValue) =>
      FocusModeValue(FocusModeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class FocusModeToggleValue extends Value<FocusModeToggleId> {
  FocusModeToggleValue(FocusModeToggleId id) : super(id);

  @override
  factory FocusModeToggleValue.fromUSBValue(int usbValue) =>
      FocusModeToggleValue(FocusModeToggleIdExtension.getIdFromUsb(usbValue));

  @override
  factory FocusModeToggleValue.fromWifiValue(String wifiValue) =>
      FocusModeToggleValue(FocusModeToggleIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class FocusAreaValue extends Value<FocusAreaId> {
  FocusAreaValue(FocusAreaId id) : super(id);

  @override
  factory FocusAreaValue.fromUSBValue(int usbValue) =>
      FocusAreaValue(FocusAreaIdExtension.getIdFromUsb(usbValue));

  @override
  factory FocusAreaValue.fromWifiValue(String wifiValue) =>
      FocusAreaValue(FocusAreaIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class FocusMagnifierDirectionValue extends Value<FocusMagnifierDirectionId> {
  FocusMagnifierDirectionValue(FocusMagnifierDirectionId id) : super(id);

  @override
  factory FocusMagnifierDirectionValue.fromUSBValue(int usbValue) =>
      FocusMagnifierDirectionValue(
          FocusMagnifierDirectionIdExtension.getIdFromUsb(usbValue));

  @override
  factory FocusMagnifierDirectionValue.fromWifiValue(String wifiValue) =>
      FocusMagnifierDirectionValue(
          FocusMagnifierDirectionIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class ImageFileFormatValue extends Value<ImageFileFormatId> {
  ImageFileFormatValue(ImageFileFormatId id) : super(id);

  @override
  factory ImageFileFormatValue.fromUSBValue(int usbValue) =>
      ImageFileFormatValue(ImageFileFormatIdExtension.getIdFromUsb(usbValue));

  @override
  factory ImageFileFormatValue.fromWifiValue(String wifiValue) =>
      ImageFileFormatValue(ImageFileFormatIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class MeteringModeValue extends Value<MeteringModeId> {
  MeteringModeValue(MeteringModeId id) : super(id);

  @override
  factory MeteringModeValue.fromUSBValue(int usbValue) =>
      MeteringModeValue(MeteringModeIdExtension.getIdFromUsb(usbValue));

  @override
  factory MeteringModeValue.fromWifiValue(String wifiValue) =>
      MeteringModeValue(MeteringModeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class PictureEffectValue extends Value<PictureEffectId> {
  PictureEffectValue(PictureEffectId id) : super(id);

  @override
  factory PictureEffectValue.fromUSBValue(int usbValue) =>
      PictureEffectValue(PictureEffectIdExtension.getIdFromUsb(usbValue));

  @override
  factory PictureEffectValue.fromWifiValue(String wifiValue) =>
      PictureEffectValue(PictureEffectIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class SettingsIdValue extends Value<ItemId> {
  SettingsIdValue(ItemId id) : super(id);

  @override
  factory SettingsIdValue.fromUSBValue(int usbValue) =>
      SettingsIdValue(SettingsIdExtension.getIdFromUsb(usbValue));

  @override
  factory SettingsIdValue.fromWifiValue(String wifiValue) =>
      SettingsIdValue(SettingsIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class WebApiMethodValue extends Value<WebApiMethod> {
  WebApiMethodValue(WebApiMethod id) : super(id);

  @override
  factory WebApiMethodValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory WebApiMethodValue.fromWifiValue(dynamic wifiValue) {
    var methodId = ApiMethodId.values
        .firstWhere((element) => wifiValue[0].startsWith(element.wifiValue));
    return WebApiMethodValue(WebApiMethod(
        methodId,
        SettingsIdExtension.getIdFromWifi(
            (wifiValue[0].replaceFirst(methodId.wifiValue, "") as String)
                .startLow),
        (wifiValue[1] as List)?.map((e) => e as String)?.toList(),
        (wifiValue[2] as List)?.map((e) => e as String)?.toList(),
        WebApiVersionIdExtension.fromWifiValue(wifiValue[3])));
  }

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.toString();

  @override
  String get name => id.toString();
}

class WhiteBalanceAbValue extends Value<WhiteBalanceAbId> {
  WhiteBalanceAbValue(WhiteBalanceAbId id) : super(id);

  @override
  factory WhiteBalanceAbValue.fromUSBValue(int usbValue) =>
      WhiteBalanceAbValue(WhiteBalanceAbIdExtension.getIdFromUsb(usbValue));

  @override
  factory WhiteBalanceAbValue.fromWifiValue(String wifiValue) =>
      WhiteBalanceAbValue(WhiteBalanceAbIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class WhiteBalanceGmValue extends Value<WhiteBalanceGmId> {
  WhiteBalanceGmValue(WhiteBalanceGmId id) : super(id);

  @override
  factory WhiteBalanceGmValue.fromUSBValue(int usbValue) =>
      WhiteBalanceGmValue(WhiteBalanceGmIdExtension.getIdFromUsb(usbValue));

  @override
  factory WhiteBalanceGmValue.fromWifiValue(String wifiValue) =>
      WhiteBalanceGmValue(WhiteBalanceGmIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class WhiteBalanceModeValue extends Value<WhiteBalanceModeId> {
  final bool hasColorTemps;

  WhiteBalanceModeValue(WhiteBalanceModeId id, {this.hasColorTemps = false})
      : super(id);

  @override
  factory WhiteBalanceModeValue.fromUSBValue(int usbValue) =>
      WhiteBalanceModeValue(WhiteBalanceIdExtension.getIdFromUsb(usbValue));

  @override
  factory WhiteBalanceModeValue.fromWifiValue(
      String wifiValue, bool hasColorTemps) {
    return WhiteBalanceModeValue(
        WhiteBalanceIdExtension.getIdFromWifi(wifiValue),
        hasColorTemps: hasColorTemps);
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class ZoomSettingValue extends Value<ZoomSettingId> {
  ZoomSettingValue(ZoomSettingId id) : super(id);

  @override
  factory ZoomSettingValue.fromUSBValue(int usbValue) =>
      throw UnimplementedError;

  @override
  factory ZoomSettingValue.fromWifiValue(String wifiValue) =>
      ZoomSettingValue(ZoomSettingIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnimplementedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class ApiFunctionValue extends Value<ItemId> {
  List<ApiMethodId> methods;

  ApiFunctionValue(ItemId id, this.methods) : super(id);

  @override
  factory ApiFunctionValue.fromUSBValue(int usbValue) =>
      throw UnimplementedError;

  @override
  factory ApiFunctionValue.fromWifiValue(String wifiValue) {
    var methodId = ApiMethodId.values
        .firstWhere((element) => wifiValue.startsWith(element.wifiValue));
    return ApiFunctionValue(
        SettingsIdExtension.getIdFromWifi(
            wifiValue.replaceFirst(methodId.wifiValue, "").startLow),
        [methodId]);
  }

  @override
  int get usbValue => throw UnimplementedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => "${id.name} $methods";
}

class ContShootingModeValue extends Value<ContShootingModeId> {
  ContShootingModeValue(ContShootingModeId id) : super(id);

  @override
  factory ContShootingModeValue.fromUSBValue(int usbValue) => throw UnimplementedError;

  @override
  factory ContShootingModeValue.fromWifiValue(String wifiValue) =>
      ContShootingModeValue(ContShootingModeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnimplementedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}

class ContShootingSpeedValue extends Value<ContShootingSpeedId> {
  ContShootingSpeedValue(ContShootingSpeedId id) : super(id);

  @override
  factory ContShootingSpeedValue.fromUSBValue(int usbValue) => throw UnimplementedError;

  @override
  factory ContShootingSpeedValue.fromWifiValue(String wifiValue) =>
      ContShootingSpeedValue(ContShootingSpeedIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnimplementedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
