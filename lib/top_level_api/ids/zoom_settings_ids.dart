import 'package:sonyalphacontrol/top_level_api/api/logger.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum ZoomSettingId {
  Optical_Zoom_Only,
  Smart_Zoom_Only,
  On_Clear_Image_Zoom,
  On_Digital_Zoom,
  Off_Digital_Zoom,
  Unknown
}

extension ZoomSettingIdExtension on ZoomSettingId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case ZoomSettingId.Optical_Zoom_Only:
        return "Optical Zoom Only";
      case ZoomSettingId.Smart_Zoom_Only:
        return "Smart Zoom Only";
      case ZoomSettingId.On_Clear_Image_Zoom:
        return "On:Clear Image Zoom";
      case ZoomSettingId.On_Digital_Zoom:
        return "On:Digital Zoom";
      case ZoomSettingId.Off_Digital_Zoom:
        return "Off:Digital Zoom";
      case ZoomSettingId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static ZoomSettingId getIdFromWifi(String wifiValue) => ZoomSettingId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ZoomSettingId, wifiValue);
        return ZoomSettingId.Unknown;
      });
}

class ZoomSettingValue extends SettingsValue<ZoomSettingId> {
  ZoomSettingValue(ZoomSettingId id) : super(id);

  @override
  factory ZoomSettingValue.fromUSBValue(int usbValue) =>
      throw UnimplementedError;

  @override
  factory ZoomSettingValue.fromWifiValue(String wifiValue) =>
      ZoomSettingValue(ZoomSettingIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnimplementedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
