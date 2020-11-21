import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum FlashModeId {
  AutoFlash,
  FlashOff,
  FillFlash,
  EyeFlashAuto, // unsure of offical name
  EyeFlash, // unsure of offical name
  AltSlowSync,
  RearSync,
  EyeFlashAuto_SlowSync, // unsure of offical name
  SlowSync,
  SlowWL,
  WirelessSync,
  RearWL,
  Unknown
}

extension FlashModeIdExtension on FlashModeId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case FlashModeId.AutoFlash:
        return 1;
      case FlashModeId.FlashOff:
        return 2;
      case FlashModeId.FillFlash:
        return 3;
      case FlashModeId.EyeFlashAuto:
        return 4;
      case FlashModeId.EyeFlash:
        return 5;
      case FlashModeId.AltSlowSync:
        return 0x8001;
      case FlashModeId.RearSync:
        return 0x8003;
      case FlashModeId.EyeFlashAuto_SlowSync:
        return 0x8031;
      case FlashModeId.SlowSync:
        return 0x8032;
      case FlashModeId.SlowWL:
        return 0x8041;
      case FlashModeId.WirelessSync:
        return 0x8004;
      case FlashModeId.RearWL:
        return 0x8042;
      case FlashModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue {
    switch (this) {
      case FlashModeId.AutoFlash:
        return "auto";
      case FlashModeId.FlashOff:
        return "off";
      case FlashModeId.FillFlash:
        return "on";
      case FlashModeId.AltSlowSync:
        return "slowSync";
      case FlashModeId.RearSync:
        return "rearSync";
      case FlashModeId.SlowSync:
        return "slowSync";
      case FlashModeId.WirelessSync:
        return "wireless";
      case FlashModeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static FlashModeId getIdFromUsb(int? usbValue) => FlashModeId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(FlashModeId, usbValue);
        return FlashModeId.Unknown;
      });

  static FlashModeId getIdFromWifi(String wifiValue) => FlashModeId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(FlashModeId, wifiValue);
        return FlashModeId.Unknown;
      });
}
