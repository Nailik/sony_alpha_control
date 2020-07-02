import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

enum ImageFileFormatId {
  JpegStandard,
  JpegFine,
  JpegXFine,
  Raw,
  Raw_JPEG,
  Unknown
}

extension ImageFileFormatIdExtension on ImageFileFormatId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case ImageFileFormatId.JpegStandard:
        return 0x02;
      case ImageFileFormatId.JpegFine:
        return 0x03;
      case ImageFileFormatId.JpegXFine:
        return 0x04;
      case ImageFileFormatId.Raw:
        return 0x10;
      case ImageFileFormatId.Raw_JPEG:
        return 0x13;
      case ImageFileFormatId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => "";
}

ImageFileFormatId getImageFileFormatId(int usbValue) {
  return ImageFileFormatId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => ImageFileFormatId.Unknown);
}

class ImageFileFormatValue extends SettingsValue<ImageFileFormatId> {
  ImageFileFormatValue(ImageFileFormatId id) : super(id);

  @override
  factory ImageFileFormatValue.fromUSBValue(int usbValue) {
    return ImageFileFormatValue(getImageFileFormatId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
