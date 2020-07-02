enum WhiteBalanceId {
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

extension WhiteBalanceIdExtension on WhiteBalanceId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case WhiteBalanceId.Auto:
        return 0x0002;
      case WhiteBalanceId.Daylight:
        return 0x0004;
      case WhiteBalanceId.Incandescent:
        return 0x0006;
      case WhiteBalanceId.Flash:
        return 0x0007;
      case WhiteBalanceId.Fluor_WarmWhite:
        return 0x8001;
      case WhiteBalanceId.Fluor_CoolWhite:
        return 0x8002;
      case WhiteBalanceId.Fluor_DayWhite:
        return 0x8003;
      case WhiteBalanceId.Fluor_Daylight:
        return 0x8004;
      case WhiteBalanceId.Cloudy:
        return 0x8010;
      case WhiteBalanceId.Shade:
        return 0x8011;
      case WhiteBalanceId.CTempFilter:
        return 0x8012;
      case WhiteBalanceId.Custom1:
        return 0x8020;
      case WhiteBalanceId.Custom2:
        return 0x8021;
      case WhiteBalanceId.Custom3:
        return 0x8022;
      case WhiteBalanceId.UnderwaterAuto:
        return 0x8030;
      case WhiteBalanceId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

WhiteBalanceId getWhiteBalanceId(int value) {
  return WhiteBalanceId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => WhiteBalanceId.Unknown);
}

class WhiteBalanceValue extends SettingsValue<WhiteBalanceId> {
  WhiteBalance(WhiteBalanceId id) : super(id);

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}