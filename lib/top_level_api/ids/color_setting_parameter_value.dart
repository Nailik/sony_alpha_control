import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum ColorSettingParameterId { Neutral, Vivid, Unknown }

extension ColorSettingParameterIdExtension on ColorSettingParameterId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case ColorSettingParameterId.Neutral:
        return "Neutral";
      case ColorSettingParameterId.Vivid:
        return "Vivid";
      case ColorSettingParameterId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static ColorSettingParameterId getIdFromWifi(String wifiValue) =>
      ColorSettingParameterId.values.firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ColorSettingParameterId, wifiValue);
        return ColorSettingParameterId.Unknown;
      });
}
