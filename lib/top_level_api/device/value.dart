// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/camera_function_id.dart';
import 'package:sonyalphacontrol/top_level_api/ids/camera_status_ids.dart';
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
import 'package:sonyalphacontrol/top_level_api/ids/movie_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/movie_quality_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/record_video_state_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_api_method_set.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
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
  OnOffValue(String id) : super(id); //"on" or "off"

  @override
  String get name => id.toString();

  @override
  int get usbValue => id == "on" ? 1 : 0;

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
  String get wifiValue => id.toString();
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

class DriveModeValue extends Value<DriveModeId> {
  DriveModeValue(DriveModeId id) : super(id);

  @override
  factory DriveModeValue.fromUSBValue(int usbValue) =>
      DriveModeValue(DriveModeIdExtension.getIdFromUsb(usbValue));

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

class DroHdrValue extends Value<DroHdrId> {
  DroHdrValue(DroHdrId id) : super(id);

  @override
  factory DroHdrValue.fromUSBValue(int usbValue) =>
      DroHdrValue(DroHdrIdExtension.getIdFromUsb(usbValue));

  @override
  factory DroHdrValue.fromWifiValue(String wifiValue) =>
      DroHdrValue(DroHdrIdExtension.getIdFromWifi(wifiValue));

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

class OpCodeValue extends Value<OpCodeId> {
  OpCodeValue(OpCodeId id) : super(id);

  @override
  factory OpCodeValue.fromUSBValue(int usbValue) =>
      OpCodeValue(OpCodesExtension.getIdFromUsb(usbValue));

  @override
  factory OpCodeValue.fromWifiValue(String wifiValue) =>
      OpCodeValue(OpCodesExtension.getIdFromWifi(wifiValue));

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
  ImageSizeValue(ImageSizeId id) : super(id);

  @override
  factory ImageSizeValue.fromUSBValue(int usbValue) =>
      ImageSizeValue(ImageSizeIdExtension.getIdFromUsb(usbValue));

  @override
  factory ImageSizeValue.fromWifiValue(String wifiValue) =>
      ImageSizeValue(ImageSizeIdExtension.getIdFromWifi(wifiValue));

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

class SettingsIdValue extends Value<SettingsId> {
  SettingsIdValue(SettingsId id) : super(id);

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
    var methodId = SonyWebApiMethodId.values
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
