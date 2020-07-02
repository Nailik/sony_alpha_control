/// <summary>
/// Used to switch between MF/AF without modifying the current AF setting
/// </summary>
enum FocusModeToggleId { Manual, Auto, Unknown }

extension FocusModeToggleIdExtension on FocusModeToggleId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case FocusModeToggleId.Manual:
        return 1;
      case FocusModeToggleId.Auto:
        return 2;
      case FocusModeToggleId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

FocusModeToggleId getFocusModeToggleId(int value) {
  return FocusModeToggleId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FocusModeToggleId.Unknown);
}

class FocusModeToggleValue extends SettingsValue<FocusModeToggleId> {
  FocusModeToggleValue(FocusModeToggleId id) : super(id);

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}