import 'package:json_annotation/json_annotation.dart';

enum WebApiVersion {
  V_1_0,
  V_1_1,
  V_1_2,
  V_1_3,
  V_1_4,
  V_1_5,
  V_1_6,
  V_1_7,
  V_1_8,
  UNKNOWN
}

extension WebApiVersionExtension on WebApiVersion {
  String get wifiValue {
    switch (this) {
      case WebApiVersion.V_1_0:
        return "1.0";
      case WebApiVersion.V_1_1:
        return "1.1";
      case WebApiVersion.V_1_2:
        return "1.2";
      case WebApiVersion.V_1_3:
        return "1.3";
      case WebApiVersion.V_1_4:
        return "1.4";
      case WebApiVersion.V_1_5:
        return "1.5";
      case WebApiVersion.V_1_6:
        return "1.6";
      case WebApiVersion.V_1_7:
        return "1.7";
      case WebApiVersion.V_1_8:
        return "1.8";
      case WebApiVersion.UNKNOWN:
      default:
        return "";
    }
  }

  static WebApiVersion fromWifiValue(String value) {
    switch (value) {
      case "1.0":
        return WebApiVersion.V_1_0;
      case "1.1":
        return WebApiVersion.V_1_1;
      case "1.2":
        return WebApiVersion.V_1_2;
      case "1.3":
        return WebApiVersion.V_1_3;
      case "1.4":
        return WebApiVersion.V_1_4;
      case "1.5":
        return WebApiVersion.V_1_5;
      case "1.6":
        return WebApiVersion.V_1_6;
      case "1.7":
        return WebApiVersion.V_1_7;
      case "1.8":
        return WebApiVersion.V_1_8;
      default:
        return WebApiVersion.UNKNOWN;
    }
  }
}

class WebApiVersionConverter implements JsonConverter<WebApiVersion, String> {
  const WebApiVersionConverter();

  @override
  WebApiVersion fromJson(String json) =>
      WebApiVersionExtension.fromWifiValue(json);

  @override
  String toJson(WebApiVersion value) => value.wifiValue;
}
