import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

import 'aspect_ratio_ids.dart';

enum FocusStateId {
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

extension AutoFocusStateIdExtension on FocusStateId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case FocusStateId.Inactive:
        return 1;
      case FocusStateId.Focused:
        return 2;
      case FocusStateId.FocusFailed:
        return 3;
      case FocusStateId.Searching:
        return 5;
      case FocusStateId.FocusedAndSearching:
        return 6;
      case FocusStateId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue {
    switch (this) {
      case FocusStateId.Inactive:
        return "Not Focusing";
      case FocusStateId.Focused:
        return "Focused";
      case FocusStateId.FocusFailed:
        return "Failed";
      case FocusStateId.Searching:
        return "Focusing";
      case FocusStateId.FocusedAndSearching:
        return "Focused And Focusing"; //not supported by wifi api?
      case FocusStateId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static FocusStateId getIdFromUsb(int? usbValue) => FocusStateId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(AspectRatioId, usbValue);
        return FocusStateId.Unknown;
      });

  static FocusStateId getIdFromWifi(String wifiValue) =>
      FocusStateId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(AspectRatioId, wifiValue);
        return FocusStateId.Unknown;
      });
}
