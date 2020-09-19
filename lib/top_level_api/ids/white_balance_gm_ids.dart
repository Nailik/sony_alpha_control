import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

///
/// Warmth bias used by GM (green-magenta)
///
enum WhiteBalanceGmId {
  M700,
  M675,
  M650,
  M625,
  M600,
  M575,
  M550,
  M525,
  M500,
  M475,
  M450,
  M425,
  M400,
  M375,
  M350,
  M325,
  M300,
  M275,
  M250,
  M225,
  M200,
  M175,
  M150,
  M125,
  M100,
  M075,
  M050,
  M025,
  Zero,
  G025,
  G050,
  G075,
  G100,
  G125,
  G150,
  G175,
  G200,
  G225,
  G250,
  G275,
  G300,
  G325,
  G350,
  G375,
  G400,
  G425,
  G450,
  G475,
  G500,
  G525,
  G550,
  G575,
  G600,
  G625,
  G650,
  G675,
  G700,
  Unknown
}

extension WhiteBalanceGmIdExtension on WhiteBalanceGmId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case WhiteBalanceGmId.M700:
        return 0xA4;
      case WhiteBalanceGmId.M675:
        return 0xA5;
      case WhiteBalanceGmId.M650:
        return 0xA6;
      case WhiteBalanceGmId.M625:
        return 0xA7;
      case WhiteBalanceGmId.M600:
        return 0xA8;
      case WhiteBalanceGmId.M575:
        return 0xA9;
      case WhiteBalanceGmId.M550:
        return 0xAA;
      case WhiteBalanceGmId.M525:
        return 0xAB;
      case WhiteBalanceGmId.M500:
        return 0xAC;
      case WhiteBalanceGmId.M475:
        return 0xAD;
      case WhiteBalanceGmId.M450:
        return 0xAE;
      case WhiteBalanceGmId.M425:
        return 0xAF;
      case WhiteBalanceGmId.M400:
        return 0xB0;
      case WhiteBalanceGmId.M375:
        return 0xB1;
      case WhiteBalanceGmId.M350:
        return 0xB2;
      case WhiteBalanceGmId.M325:
        return 0xB3;
      case WhiteBalanceGmId.M300:
        return 0xB4;
      case WhiteBalanceGmId.M275:
        return 0xB5;
      case WhiteBalanceGmId.M250:
        return 0xB6;
      case WhiteBalanceGmId.M225:
        return 0xB7;
      case WhiteBalanceGmId.M200:
        return 0xB8;
      case WhiteBalanceGmId.M175:
        return 0xB9;
      case WhiteBalanceGmId.M150:
        return 0xBA;
      case WhiteBalanceGmId.M125:
        return 0xBB;
      case WhiteBalanceGmId.M100:
        return 0xBC;
      case WhiteBalanceGmId.M075:
        return 0xBD;
      case WhiteBalanceGmId.M050:
        return 0xBE;
      case WhiteBalanceGmId.M025:
        return 0xBF;
      case WhiteBalanceGmId.Zero:
        return 0xC0;
      case WhiteBalanceGmId.G025:
        return 0xC1;
      case WhiteBalanceGmId.G050:
        return 0xC2;
      case WhiteBalanceGmId.G075:
        return 0xC3;
      case WhiteBalanceGmId.G100:
        return 0xC4;
      case WhiteBalanceGmId.G125:
        return 0xC5;
      case WhiteBalanceGmId.G150:
        return 0xC6;
      case WhiteBalanceGmId.G175:
        return 0xC7;
      case WhiteBalanceGmId.G200:
        return 0xC8;
      case WhiteBalanceGmId.G225:
        return 0xC9;
      case WhiteBalanceGmId.G250:
        return 0xCA;
      case WhiteBalanceGmId.G275:
        return 0xCB;
      case WhiteBalanceGmId.G300:
        return 0xCC;
      case WhiteBalanceGmId.G325:
        return 0xCD;
      case WhiteBalanceGmId.G350:
        return 0xCE;
      case WhiteBalanceGmId.G375:
        return 0xCF;
      case WhiteBalanceGmId.G400:
        return 0xD0;
      case WhiteBalanceGmId.G425:
        return 0xD1;
      case WhiteBalanceGmId.G450:
        return 0xD2;
      case WhiteBalanceGmId.G475:
        return 0xD3;
      case WhiteBalanceGmId.G500:
        return 0xD4;
      case WhiteBalanceGmId.G525:
        return 0xD5;
      case WhiteBalanceGmId.G550:
        return 0xD6;
      case WhiteBalanceGmId.G575:
        return 0xD7;
      case WhiteBalanceGmId.G600:
        return 0xD8;
      case WhiteBalanceGmId.G625:
        return 0xD9;
      case WhiteBalanceGmId.G650:
        return 0xDA;
      case WhiteBalanceGmId.G675:
        return 0xDB;
      case WhiteBalanceGmId.G700:
        return 0xDC;
      case WhiteBalanceGmId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => throw UnimplementedError;

  static WhiteBalanceGmId getIdFromUsb(int usbValue) => WhiteBalanceGmId.values
      .firstWhere((element) => element.usbValue == usbValue,
          orElse: () => WhiteBalanceGmId.Unknown);

  static WhiteBalanceGmId getIdFromWifi(String wifiValue) =>
      WhiteBalanceGmId.values.firstWhere(
          (element) => element.wifiValue == wifiValue,
          orElse: () => WhiteBalanceGmId.Unknown);
}

class WhiteBalanceGmValue extends SettingsValue<WhiteBalanceGmId> {
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
