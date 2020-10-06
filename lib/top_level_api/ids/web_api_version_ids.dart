import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum WebApiVersionId {
  V_1_0,
  V_1_1,
  V_1_2,
  V_1_3,
  V_1_4,
  V_1_5,
  V_1_6,
  V_1_7,
  V_1_8,
  Unknown
}

extension WebApiVersionIdExtension on WebApiVersionId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case WebApiVersionId.V_1_0:
        return "1.0";
      case WebApiVersionId.V_1_1:
        return "1.1";
      case WebApiVersionId.V_1_2:
        return "1.2";
      case WebApiVersionId.V_1_3:
        return "1.3";
      case WebApiVersionId.V_1_4:
        return "1.4";
      case WebApiVersionId.V_1_5:
        return "1.5";
      case WebApiVersionId.V_1_6:
        return "1.6";
      case WebApiVersionId.V_1_7:
        return "1.7";
      case WebApiVersionId.V_1_8:
        return "1.8";
      case WebApiVersionId.Unknown:
      default:
        return "";
    }
  }

  static WebApiVersionId fromWifiValue(String value) {
    switch (value) {
      case "1.0":
        return WebApiVersionId.V_1_0;
      case "1.1":
        return WebApiVersionId.V_1_1;
      case "1.2":
        return WebApiVersionId.V_1_2;
      case "1.3":
        return WebApiVersionId.V_1_3;
      case "1.4":
        return WebApiVersionId.V_1_4;
      case "1.5":
        return WebApiVersionId.V_1_5;
      case "1.6":
        return WebApiVersionId.V_1_6;
      case "1.7":
        return WebApiVersionId.V_1_7;
      case "1.8":
        return WebApiVersionId.V_1_8;
      default:
        return WebApiVersionId.Unknown;
    }
  }

  static WebApiVersionId getIdFromWifi(String wifiValue) =>
      WebApiVersionId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(WebApiVersionId, wifiValue);
        return WebApiVersionId.Unknown;
      });
}
