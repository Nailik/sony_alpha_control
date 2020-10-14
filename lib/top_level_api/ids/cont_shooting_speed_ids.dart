import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum ContShootingSpeedId {
  Hi,
  Mid,
  Low,
  Spd_Priority_Cont,
  S_10fps_1sec,
  S_8fps_1sec,
  S_5fps_2sec,
  S_2fps_5sec,
  Unknown
}

extension ContShootingSpeedIdExtension on ContShootingSpeedId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case ContShootingSpeedId.Hi:
        return "Hi";
      case ContShootingSpeedId.Mid:
        return "Mid";
      case ContShootingSpeedId.Low:
        return "Low";
      case ContShootingSpeedId.S_10fps_1sec:
        return "10fps 1sec";
      case ContShootingSpeedId.S_8fps_1sec:
        return "8fps 1sec";
      case ContShootingSpeedId.S_5fps_2sec:
        return "5fps 2sec";
      case ContShootingSpeedId.S_2fps_5sec:
        return "2fps 5sec";
      case ContShootingSpeedId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static ContShootingSpeedId getIdFromWifi(String wifiValue) =>
      ContShootingSpeedId.values.firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ContShootingSpeedId, wifiValue);
        return ContShootingSpeedId.Unknown;
      });
}
