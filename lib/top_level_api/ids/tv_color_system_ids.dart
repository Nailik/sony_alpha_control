import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum TvColorSystemId { NTSC, PAL, Unknown }

extension TvColorSystemIdExtension on TvColorSystemId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case TvColorSystemId.NTSC:
        return "L";
      case TvColorSystemId.PAL:
        return "M";
      case TvColorSystemId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static TvColorSystemId getIdFromWifi(String wifiValue) => TvColorSystemId.values
      .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
    Logger.n(TvColorSystemId, wifiValue);
    return TvColorSystemId.Unknown;
  });
}
