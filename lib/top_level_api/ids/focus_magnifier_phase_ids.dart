enum FocusMagnifierPhaseId {
  /// <summary>
  /// The magnifier isn't currently being used
  /// </summary>
  Inactive,

  /// <summary>
  /// x1.0, this phase is used to select the screen region to magnify
  /// </summary>
  SelectRegion,

  /// <summary>
  /// Actively magnifying a region of the screen
  /// </summary>
  Magnify,
  Unknown
}

extension FocusMagnifierPhaseIdExtension on FocusMagnifierPhaseId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case FocusMagnifierPhaseId.Inactive:
        return 0;
      case FocusMagnifierPhaseId.SelectRegion:
        return 1;
      case FocusMagnifierPhaseId.Magnify:
        return 2;
      case FocusMagnifierPhaseId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

FocusMagnifierPhaseId geFocusMagnifierPhaseId(int value) {
  return FocusMagnifierPhaseId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FocusMagnifierPhaseId.Unknown);
}

class FocusMagnifierPhaseValue extends SettingsValue<FocusMagnifierPhaseId> {
  FocusMagnifierPhaseValue(FocusMagnifierPhaseId id) : super(id);

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}