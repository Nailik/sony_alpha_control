import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum ContShootingModeId { Single, Continuous, Spd_Priority_Cont, Burst, MotionShot, Unknown }

extension ContShootingModeIdExtension on ContShootingModeId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case ContShootingModeId.Single:
        return "Single";
      case ContShootingModeId.Continuous:
        return "Continuous";
      case ContShootingModeId.Spd_Priority_Cont:
        return "Spd Priority Cont.";
      case ContShootingModeId.Burst:
        return "Burst";
      case ContShootingModeId.MotionShot:
        return "MotionShot";
      case ContShootingModeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static ContShootingModeId getIdFromWifi(String wifiValue) =>
      ContShootingModeId.values.firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ContShootingModeId, wifiValue);
        return ContShootingModeId.Unknown;
      });
}
