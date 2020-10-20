import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

import 'aspect_ratio_ids.dart';

enum TrackingFocusStateId {
  /// <summary>
  /// Tracking a subject
  /// </summary>
  Tracking,

  /// <summary>
  /// Not tracking a subject
  /// </summary>
  Not_Tracking,
  Unknown
}

extension TrackingFocusStateIdExtension on TrackingFocusStateId {
  String get name => toString().split('.')[1];

  int get usbValue => throw UnsupportedError;

  String get wifiValue {
    switch (this) {
      case TrackingFocusStateId.Tracking:
        return "Tracking";
      case TrackingFocusStateId.Not_Tracking:
        return "Not Tracking";
      case TrackingFocusStateId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static TrackingFocusStateId getIdFromUsb(int usbValue) => throw UnsupportedError;

  static TrackingFocusStateId getIdFromWifi(String wifiValue) =>
      TrackingFocusStateId.values.firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(AspectRatioId, wifiValue);
        return TrackingFocusStateId.Unknown;
      });
}
