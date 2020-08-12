import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

/// <summary>
/// Used to switch between MF/AF without modifying the current AF setting
/// </summary>
enum FocusModeToggleId { Manual, Auto, Unknown }

extension FocusModeToggleIdExtension on FocusModeToggleId {
  String get name => toString().split('.')[1];

  int get usbValue {
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

  String get wifiValue => "";
}

FocusModeToggleId getFocusModeToggleId(int usbValue) {
  return FocusModeToggleId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => FocusModeToggleId.Unknown);
}

class FocusModeToggleValue extends SettingsValue<FocusModeToggleId> {
  FocusModeToggleValue(FocusModeToggleId id) : super(id);

  @override
  factory FocusModeToggleValue.fromUSBValue(int usbValue) {
    return FocusModeToggleValue(getFocusModeToggleId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
