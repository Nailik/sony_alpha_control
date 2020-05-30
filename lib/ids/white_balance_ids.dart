enum FocusModeId {
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

extension FocusModeIdExtension on FocusModeId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case FocusModeId.Auto:
        return 0x0002;
      case FocusModeId.Daylight:
        return 0x0004;
      case FocusModeId.Incandescent:
        return 0x0006;
      case FocusModeId.Flash:
        return 0x0007;
      case FocusModeId.Fluor_WarmWhite:
        return 0x8001;
      case FocusModeId.Fluor_CoolWhite:
        return 0x8002;
      case FocusModeId.Fluor_DayWhite:
        return 0x8003;
      case FocusModeId.Fluor_Daylight:
        return 0x8004;
      case FocusModeId.Cloudy:
        return 0x8010;
      case FocusModeId.Shade:
        return 0x8011;
      case FocusModeId.CTempFilter:
        return 0x8012;
      case FocusModeId.Custom1:
        return 0x8020;
      case FocusModeId.Custom2:
        return 0x8021;
      case FocusModeId.Custom3:
        return 0x8022;
      case FocusModeId.UnderwaterAuto:
        return 0x8030;
      case FocusModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

FocusModeId getFocusModeId(int value) {
  return FocusModeId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FocusModeId.Unknown);
}
