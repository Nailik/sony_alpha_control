import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum FocusModeId {
  MF,
  AF_SingleShot,
  AF_Continuous,
  AF_Automatic,
  DMF,
  Unknown
}

extension FocusModeIdExtension on FocusModeId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case FocusModeId.MF:
        return 0x0001;
      case FocusModeId.AF_SingleShot:
        return 0x0002;
      case FocusModeId.AF_Continuous:
        return 0x8004;
      case FocusModeId.AF_Automatic:
        return 0x8005;
      case FocusModeId.DMF:
        return 0x8006;
      case FocusModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue {
    switch (this) {
      case FocusModeId.MF:
        return "MF";
      case FocusModeId.AF_SingleShot:
        return "AF-S";
      case FocusModeId.AF_Continuous:
        return "AF-C";
      case FocusModeId.DMF:
        return "DMF";
      case FocusModeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static FocusModeId getIdFromUsb(int usbValue) => FocusModeId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(FocusModeId, usbValue);
        return FocusModeId.Unknown;
      });

  static FocusModeId getIdFromWifi(String wifiValue) => FocusModeId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(FocusModeId, wifiValue);
        return FocusModeId.Unknown;
      });
}
