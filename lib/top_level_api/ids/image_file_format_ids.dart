import 'package:sonyalphacontrol/top_level_api/api/logger.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';

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

  String get wifiValue {
    switch (this) {
      case ImageFileFormatId.JpegStandard:
        return "Standard";
      case ImageFileFormatId.JpegFine:
        return "Fine";
      case ImageFileFormatId.JpegXFine:
        return "XFine"; //TODO ensure
      case ImageFileFormatId.Raw:
        return "RAW"; //TODO ensure
      case ImageFileFormatId.Raw_JPEG:
        return "RAW+JPEG";
      case ImageFileFormatId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static ImageFileFormatId getIdFromUsb(int? usbValue) =>
      ImageFileFormatId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(ImageFileFormatId, usbValue);
        return ImageFileFormatId.Unknown;
      });

  static ImageFileFormatId getIdFromWifi(String wifiValue) =>
      ImageFileFormatId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ImageFileFormatId, wifiValue);
        return ImageFileFormatId.Unknown;
      });
}
