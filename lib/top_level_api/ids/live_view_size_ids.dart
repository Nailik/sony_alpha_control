import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum LiveViewSizeId { L, M, Unknown }

extension LiveViewSizeIdExtension on LiveViewSizeId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case LiveViewSizeId.L:
        return "L";
      case LiveViewSizeId.M:
        return "M";
      case LiveViewSizeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static LiveViewSizeId getIdFromWifi(String wifiValue) => LiveViewSizeId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(LiveViewSizeId, wifiValue);
        return LiveViewSizeId.Unknown;
      });
}
