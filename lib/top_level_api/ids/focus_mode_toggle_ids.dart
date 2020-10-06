import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

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

  String get wifiValue => throw UnimplementedError;

  static FocusModeToggleId getIdFromUsb(int usbValue) =>
      FocusModeToggleId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(FocusModeToggleId, usbValue);
        return FocusModeToggleId.Unknown;
      });

  static FocusModeToggleId getIdFromWifi(String wifiValue) =>
      FocusModeToggleId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(FocusModeToggleId, wifiValue);
        return FocusModeToggleId.Unknown;
      });
}
