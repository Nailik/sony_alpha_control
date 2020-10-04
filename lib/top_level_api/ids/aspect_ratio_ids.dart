import 'package:sonyalphacontrol/top_level_api/api/logger.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum AspectRatioId { Ar3_2, Ar16_9, Ar4_3, Ar1_1, Unknown }

extension AspectRatioIdExtension on AspectRatioId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case AspectRatioId.Ar3_2:
        return 1;
      case AspectRatioId.Ar16_9:
        return 2;
      case AspectRatioId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue {
    switch (this) {
      case AspectRatioId.Ar4_3:
        return "4:3";
      case AspectRatioId.Ar16_9:
        return "16:9";
      case AspectRatioId.Ar3_2:
        return "3_2";
      case AspectRatioId.Ar1_1:
        return "1:1";
      case AspectRatioId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static AspectRatioId getIdFromUsb(int usbValue) => AspectRatioId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(AspectRatioId, usbValue);
        return AspectRatioId.Unknown;
      });

  static AspectRatioId getIdFromWifi(String wifiValue) => AspectRatioId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(AspectRatioId, wifiValue);
        return AspectRatioId.Unknown;
      });
}

class AspectRatioValue extends SettingsValue<AspectRatioId> {
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
