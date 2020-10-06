enum SonyWebApiServiceTypeId {
  CAMERA,
  AV_CONTENT,
  SYSTEM,
  GUIDE,
  Unknown }

extension SonyWebApiServiceTypeIdExtension on SonyWebApiServiceTypeId {
  String get wifiValue {
    switch (this) {
      case SonyWebApiServiceTypeId.CAMERA:
        return "camera";
      case SonyWebApiServiceTypeId.AV_CONTENT:
        return "avContent";
      case SonyWebApiServiceTypeId.SYSTEM:
        return "system";
      case SonyWebApiServiceTypeId.GUIDE:
        return "guide";
      case SonyWebApiServiceTypeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }
}
