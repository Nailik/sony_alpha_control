import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum CameraFunctionId {
  REMOTE_SHOOTING,
  CONTENTS_TRANSFER,
  OTHER_FUNCTION,
  UNKNOWN
}

extension CameraFunctionIdExtension on CameraFunctionId {
  String get wifiValue {
    switch (this) {
      case CameraFunctionId.REMOTE_SHOOTING:
        return "Remote Shooting";
      case CameraFunctionId.CONTENTS_TRANSFER:
        return "Contents Transfer";
      case CameraFunctionId.OTHER_FUNCTION:
        return "Other Function";
      case CameraFunctionId.UNKNOWN:
      default:
        return "";
    }
  }

  static CameraFunctionId getIdFromUsb(int usbValue) => throw UnsupportedError;

  static CameraFunctionId getIdFromWifi(String wifiValue) {
    return CameraFunctionId.values.firstWhere(
        (element) => element.wifiValue == wifiValue,
        orElse: () => CameraFunctionId.UNKNOWN);
  }
}

class CameraFunctionValue extends SettingsValue<CameraFunctionId> {
  CameraFunctionValue(CameraFunctionId id) : super(id);

  @override
  factory CameraFunctionValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory CameraFunctionValue.fromWifiValue(String wifiValue) =>
      CameraFunctionValue(CameraFunctionIdExtension.getIdFromWifi(wifiValue));

  @override
  String get name => id.toString();

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;
}
