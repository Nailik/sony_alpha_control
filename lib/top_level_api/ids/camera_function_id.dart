import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum CameraFunctionId {
  REMOTE_SHOOTING,
  CONTENTS_TRANSFER,
  OTHER_FUNCTION,
  Unknown
}

extension CameraFunctionIdExtension on CameraFunctionId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case CameraFunctionId.REMOTE_SHOOTING:
        return "Remote Shooting";
      case CameraFunctionId.CONTENTS_TRANSFER:
        return "Contents Transfer";
      case CameraFunctionId.OTHER_FUNCTION:
        return "Other Function";
      case CameraFunctionId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static CameraFunctionId getIdFromUsb(int usbValue) => throw UnsupportedError;

  static CameraFunctionId getIdFromWifi(String wifiValue) {
    return CameraFunctionId.values
        .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
      Logger.n(CameraFunctionId, wifiValue);
      return CameraFunctionId.Unknown;
    });
  }
}
