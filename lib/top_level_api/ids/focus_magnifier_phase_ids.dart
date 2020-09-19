import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

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

  int get usbValue {
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

  String get wifiValue => throw UnimplementedError;

  static FocusMagnifierPhaseId getIdFromUsb(int usbValue) =>
      FocusMagnifierPhaseId.values.firstWhere(
          (element) => element.usbValue == usbValue,
          orElse: () => FocusMagnifierPhaseId.Unknown);

  static FocusMagnifierPhaseId getIdFromWifi(String wifiValue) =>
      FocusMagnifierPhaseId.values.firstWhere(
          (element) => element.wifiValue == wifiValue,
          orElse: () => FocusMagnifierPhaseId.Unknown);
}

class FocusMagnifierPhaseValue extends SettingsValue<FocusMagnifierPhaseId> {
  FocusMagnifierPhaseValue(FocusMagnifierPhaseId id) : super(id);

  @override
  factory FocusMagnifierPhaseValue.fromUSBValue(int usbValue) =>
      FocusMagnifierPhaseValue(
          FocusMagnifierPhaseIdExtension.getIdFromUsb(usbValue));

  @override
  factory FocusMagnifierPhaseValue.fromWifiValue(String wifiValue) =>
      FocusMagnifierPhaseValue(
          FocusMagnifierPhaseIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
