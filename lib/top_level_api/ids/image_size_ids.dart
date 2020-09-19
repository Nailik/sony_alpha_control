import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum ImageSizeId { Large, Medium, Small, Unknown }

extension ImageSizeIdExtension on ImageSizeId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case ImageSizeId.Large:
        return 1;
      case ImageSizeId.Medium:
        return 2;
      case ImageSizeId.Small:
        return 3;
      case ImageSizeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => throw UnimplementedError;

  static ImageSizeId getIdFromUsb(int usbValue) =>
      ImageSizeId.values.firstWhere((element) => element.usbValue == usbValue,
          orElse: () => ImageSizeId.Unknown);

  static ImageSizeId getIdFromWifi(String wifiValue) =>
      ImageSizeId.values.firstWhere((element) => element.wifiValue == wifiValue,
          orElse: () => ImageSizeId.Unknown);
}

class ImageSizeValue extends SettingsValue<ImageSizeId> {
  ImageSizeValue(ImageSizeId id) : super(id);

  @override
  factory ImageSizeValue.fromUSBValue(int usbValue) =>
      ImageSizeValue(ImageSizeIdExtension.getIdFromUsb(usbValue));

  @override
  factory ImageSizeValue.fromWifiValue(String wifiValue) =>
      ImageSizeValue(ImageSizeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
