import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum BeepModeId { Off, On, Shutter_Only, Silent, Limited, Unknown }

extension BeepModeIdExtension on BeepModeId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case BeepModeId.Off:
        return "Off";
      case BeepModeId.On:
        return "On";
      case BeepModeId.Shutter_Only:
        return "Shutter Only";
      case BeepModeId.Silent:
        return "Silent";
      case BeepModeId.Limited:
        return "Limited";
      case BeepModeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static BeepModeId getIdFromWifi(String wifiValue) =>
      BeepModeId.values.firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(BeepModeId, wifiValue);
        return BeepModeId.Unknown;
      });
}
