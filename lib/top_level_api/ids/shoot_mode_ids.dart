import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum ShootModeId { Still, Movie, Audio, IntervalStill, LoopRec, Unknown }

extension ShootModeIdExtension on ShootModeId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case ShootModeId.Still:
        return "still";
      case ShootModeId.Movie:
        return "movie";
      case ShootModeId.Audio:
        return "audio";
      case ShootModeId.IntervalStill:
        return "intervalstill";
      case ShootModeId.LoopRec:
        return "looprec";
      case ShootModeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static ShootModeId getIdFromWifi(String wifiValue) =>
      ShootModeId.values.firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ShootModeId, wifiValue);
        return ShootModeId.Unknown;
      });
}
