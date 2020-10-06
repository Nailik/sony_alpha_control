import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

import 'aspect_ratio_ids.dart';

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

  String get wifiValue {
    switch (this) {
      case AutoFocusStateId.Inactive:
        return "Not Focusing";
      case AutoFocusStateId.Focused:
        return "Focused";
      case AutoFocusStateId.FocusFailed:
        return "Failed";
      case AutoFocusStateId.Searching:
        return "Focusing";
      case AutoFocusStateId.FocusedAndSearching:
        return "Focused And Focusing"; //not supported by wifi api?
      case AutoFocusStateId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static AutoFocusStateId getIdFromUsb(int usbValue) => AutoFocusStateId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(AspectRatioId, usbValue);
        return AutoFocusStateId.Unknown;
      });

  static AutoFocusStateId getIdFromWifi(String wifiValue) =>
      AutoFocusStateId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(AspectRatioId, wifiValue);
        return AutoFocusStateId.Unknown;
      });
}
