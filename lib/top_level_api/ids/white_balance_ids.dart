import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum WhiteBalanceModeId {
  Auto,
  Daylight,
  Incandescent,
  Flash,
  Fluor_WarmWhite,
  Fluor_CoolWhite,
  Fluor_DayWhite,
  Fluor_Daylight,
  Cloudy,
  Shade,
  CTempFilter,
  Custom1,
  Custom2,
  Custom3,
  UnderwaterAuto,
  Unknown
}

extension WhiteBalanceIdExtension on WhiteBalanceModeId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case WhiteBalanceModeId.Auto:
        return 0x0002;
      case WhiteBalanceModeId.Daylight:
        return 0x0004;
      case WhiteBalanceModeId.Incandescent:
        return 0x0006;
      case WhiteBalanceModeId.Flash:
        return 0x0007;
      case WhiteBalanceModeId.Fluor_WarmWhite:
        return 0x8001;
      case WhiteBalanceModeId.Fluor_CoolWhite:
        return 0x8002;
      case WhiteBalanceModeId.Fluor_DayWhite:
        return 0x8003;
      case WhiteBalanceModeId.Fluor_Daylight:
        return 0x8004;
      case WhiteBalanceModeId.Cloudy:
        return 0x8010;
      case WhiteBalanceModeId.Shade:
        return 0x8011;
      case WhiteBalanceModeId.CTempFilter:
        return 0x8012;
      case WhiteBalanceModeId.Custom1:
        return 0x8020;
      case WhiteBalanceModeId.Custom2:
        return 0x8021;
      case WhiteBalanceModeId.Custom3:
        return 0x8022;
      case WhiteBalanceModeId.UnderwaterAuto:
        return 0x8030;
      case WhiteBalanceModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue {
    switch (this) {
      case WhiteBalanceModeId.Auto:
        return "Auto WB";
      case WhiteBalanceModeId.Daylight:
        return "Daylight";
      case WhiteBalanceModeId.Incandescent:
        return "Incandescent";
      case WhiteBalanceModeId.Flash:
        return "Flash";
      case WhiteBalanceModeId.Fluor_WarmWhite:
        return "Fluorescent: Warm White (-1)";
      case WhiteBalanceModeId.Fluor_CoolWhite:
        return "Fluorescent: Cool White (0)";
      case WhiteBalanceModeId.Fluor_DayWhite:
        return "Fluorescent: Day White (+1)";
      case WhiteBalanceModeId.Fluor_Daylight:
        return "Fluorescent: Daylight (+2)";
      case WhiteBalanceModeId.Cloudy:
        return "Cloudy";
      case WhiteBalanceModeId.Shade:
        return "Shade";
      case WhiteBalanceModeId.CTempFilter:
        return "Color Temperature";
      case WhiteBalanceModeId.Custom1:
        return "Custom";
      case WhiteBalanceModeId.Custom2:
        return "Custom 1";
      case WhiteBalanceModeId.Custom3:
        return "Custom 2";
      case WhiteBalanceModeId.UnderwaterAuto:
        return "Custom 3";
      case WhiteBalanceModeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static WhiteBalanceModeId getIdFromUsb(int usbValue) =>
      WhiteBalanceModeId.values.firstWhere(
          (element) => element.usbValue == usbValue,
          orElse: () => WhiteBalanceModeId.Unknown);

  static WhiteBalanceModeId getIdFromWifi(String wifiValue) =>
      WhiteBalanceModeId.values.firstWhere(
          (element) => element.wifiValue == wifiValue,
          orElse: () => WhiteBalanceModeId.Unknown);
}

class WhiteBalanceModeValue extends SettingsValue<WhiteBalanceModeId> {
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
