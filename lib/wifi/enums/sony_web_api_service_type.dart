enum SonyWebApiServiceType { CAMERA, AV_CONTENT, SYSTEM, GUIDE, UNKNOWN }

extension SonyWebApiServiceTypeExtension on SonyWebApiServiceType {
  String get wifiValue {
    switch (this) {
      case SonyWebApiServiceType.CAMERA:
        return "camera";
      case SonyWebApiServiceType.AV_CONTENT:
        return "avContent";
      case SonyWebApiServiceType.SYSTEM:
        return "system";
      case SonyWebApiServiceType.GUIDE:
        return "guide";
      case SonyWebApiServiceType.UNKNOWN:
      default:
        return "";
    }
  }
}
