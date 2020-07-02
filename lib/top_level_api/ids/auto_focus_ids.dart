import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

enum AutoFocusStateId {
  /// <summary>
  /// Focus state is inactive (no green circle / rings on the screen)
  /// </summary>
  Inactive,

  /// <summary>
  /// Solid green circle
  /// </summary>
  Focused,

  /// <summary>
  /// Blinking solid green circle (the camera cannot focus on the selected subject)
  /// </summary>
  FocusFailed,

  /// <summary>
  /// Green rings
  /// </summary>
  Searching,

  /// <summary>
  /// Solid green circle with green rings
  /// </summary>
  FocusedAndSearching,
  Unknown
}

extension AutoFocusStateIdExtension on AutoFocusStateId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case AutoFocusStateId.Inactive:
        return 1;
      case AutoFocusStateId.Focused:
        return 2;
      case AutoFocusStateId.FocusFailed:
        return 3;
      case AutoFocusStateId.Searching:
        return 5;
      case AutoFocusStateId.FocusedAndSearching:
        return 6;
      case AutoFocusStateId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => "";
}

AutoFocusStateId getAutoFocusStateId(int usbValue) {
  return AutoFocusStateId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => AutoFocusStateId.Unknown);
}

class AutoFocusStateValue extends SettingsValue<AutoFocusStateId> {
  AutoFocusStateValue(AutoFocusStateId id) : super(id);

  @override
  factory AutoFocusStateValue.fromUSBValue(int usbValue) {
    return AutoFocusStateValue(getAutoFocusStateId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
