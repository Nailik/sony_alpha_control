enum SonyWebApiFunctionType { REMOTE_SHOOTING, CONTENTS_TRANSFER, UNKNOWN }

extension SonyWebApiFunctionTypeExtension on SonyWebApiFunctionType {
  String get wifiValue {
    switch (this) {
      case SonyWebApiFunctionType.REMOTE_SHOOTING:
        return "Remote Shooting";
      case SonyWebApiFunctionType.CONTENTS_TRANSFER:
        return "Contents Transfer";
      case SonyWebApiFunctionType.UNKNOWN:
      default:
        return "";
    }
  }

  static SonyWebApiFunctionType fromWifiValue(String value) {
    switch (value) {
      case "Remote Shooting":
        return SonyWebApiFunctionType.REMOTE_SHOOTING;
      case "Contents Transfer":
        return SonyWebApiFunctionType.CONTENTS_TRANSFER;
      default:
        return SonyWebApiFunctionType.UNKNOWN;
    }
  }
}
