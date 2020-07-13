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
}
