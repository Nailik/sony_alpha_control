import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum ShootingModeId {
  //01 00 - M
  M,
  //02 00 - P
  P,
  //03 00 - A
  A,
  //04 00 - S
  S,
  //07 00 - SCN
  SCN,
//11 80 - Moving objects? (running person icon)
  SCN_MOO,
//15 80 - Flower icon
  SCN_F,
//14 80 - Mountains icon
  SCN_M,
//12 80 - Sun icon?
  SCN_S,
//13 80 - Moon icon
  SCN_MOON,
  SCN_PORTRAIT_NIGHT,
  SUPERIOR_AUTO,
  TELE_ZOOM_CONT_AE_PRIORITY,
  SWEEP_PANORAMA,
  INTELLIGENT_AUTO_FLASH_OFF,
  HANDHELD_TWILIGHT,
  PICTURE_EFFECT,
  Movie,
//17 80 - Moon icon with person
  SCN_MOON_P,
  //00 80 - AUTO
  AUTO,
  //50 80 - Movie (P)
  Movie_P,
  //51 80 - Movie (A)
  Movie_A,
  //52 80 - Movie (S)
  Movie_S,
  //53 80 - Movie (M)
  Movie_M,
  //84 80 - S&Q (P)
  SQ_P,
  //85 80 - S&Q (A)
  SQ_A,
  //86 80 - S&Q (S)
  SQ_S,
  //87 80 - S&Q (M)
  SQ_M,
  Unknown
}

extension ShootingModeIdExtension on ShootingModeId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case ShootingModeId.M:
        return 0x0001;
      case ShootingModeId.P:
        return 0x0002;
      case ShootingModeId.A:
        return 0x0003;
      case ShootingModeId.S:
        return 0x0004;
      case ShootingModeId.SCN:
        return 0x0007;
      case ShootingModeId.SCN_MOO:
        return 0x8011;
      case ShootingModeId.SCN_F:
        return 0x8015;
      case ShootingModeId.SCN_M:
        return 0x8014;
      case ShootingModeId.SCN_S:
        return 0x8012;
      case ShootingModeId.SCN_MOON:
        return 0x8013;
      case ShootingModeId.SCN_PORTRAIT_NIGHT:
        return 0x8017;
      case ShootingModeId.AUTO:
        return 0x8000;
      case ShootingModeId.SUPERIOR_AUTO:
        return 0x8001;
      case ShootingModeId.TELE_ZOOM_CONT_AE_PRIORITY:
        return 0x8031;
      case ShootingModeId.SWEEP_PANORAMA:
        return 0x8041;
      case ShootingModeId.INTELLIGENT_AUTO_FLASH_OFF:
        return 0x8060;
      case ShootingModeId.HANDHELD_TWILIGHT:
        return 0x8016;
      case ShootingModeId.PICTURE_EFFECT:
        return 0x8070;
      case ShootingModeId.Movie_P:
        return 0x8050;
      case ShootingModeId.Movie_A:
        return 0x8051;
      case ShootingModeId.Movie_S:
        return 0x8052;
      case ShootingModeId.Movie_M:
        return 0x8053;
      case ShootingModeId.Movie:
        return 0x8056;
      case ShootingModeId.SQ_P:
        return 0x8084;
      case ShootingModeId.SQ_A:
        return 0x8085;
      case ShootingModeId.SQ_S:
        return 0x8086;
      case ShootingModeId.SQ_M:
        return 0x8087;
      case ShootingModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => "";
}

ShootingModeId getShootingModeId(int usbValue) {
  return ShootingModeId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => ShootingModeId.Unknown);
}

class ShootingModeValue extends SettingsValue<ShootingModeId> {
  ShootingModeValue(ShootingModeId id) : super(id);

  @override
  factory ShootingModeValue.fromUSBValue(int usbValue) {
    return ShootingModeValue(getShootingModeId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
