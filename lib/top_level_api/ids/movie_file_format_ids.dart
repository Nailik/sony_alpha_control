import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum MovieFileFormatId { MP4, XAVC_S, XAVC_S_4K, Unknown }

extension MovieFileFormatIdExtension on MovieFileFormatId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case MovieFileFormatId.MP4:
        return "MP4";
      case MovieFileFormatId.XAVC_S:
        return "XAVC S";
      case MovieFileFormatId.XAVC_S_4K:
        return "XAVC S 4K";
      case MovieFileFormatId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static MovieFileFormatId getIdFromUsb(int usbValue) => throw UnsupportedError;

  static MovieFileFormatId getIdFromWifi(String wifiValue) {
    return MovieFileFormatId.values
        .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
      Logger.n(MovieFileFormatId, wifiValue);
      return MovieFileFormatId.Unknown;
    });
  }
}
