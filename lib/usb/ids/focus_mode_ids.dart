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

  int get value {
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
}

FocusModeId getFocusModeId(int value) {
  return FocusModeId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FocusModeId.Unknown);
}
