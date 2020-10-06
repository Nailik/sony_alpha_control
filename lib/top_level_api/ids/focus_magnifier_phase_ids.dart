import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

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
      FocusMagnifierPhaseId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(FocusMagnifierPhaseId, usbValue);
        return FocusMagnifierPhaseId.Unknown;
      });

  static FocusMagnifierPhaseId getIdFromWifi(String wifiValue) =>
      FocusMagnifierPhaseId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(FocusMagnifierPhaseId, wifiValue);
        return FocusMagnifierPhaseId.Unknown;
      });
}
