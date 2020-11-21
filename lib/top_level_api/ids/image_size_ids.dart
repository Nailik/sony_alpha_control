import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum ImageSizeId {
  Large,
  Medium,
  Small,
  M_20,
  M_18,
  M_17,
  M_13,
  M_8_3,
  M_7_5,
  M_5,
  M_4_2,
  M_3_7,
  M_2_1,
  Unknown
}

extension ImageSizeIdExtension on ImageSizeId {
  String get name => toString().split('.')[1];

  //TODO how many mp?
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

  String get wifiValue {
    switch (this) {
      case ImageSizeId.M_20:
        return "20M";
      case ImageSizeId.M_18:
        return "18M";
      case ImageSizeId.M_17:
        return "17M";
      case ImageSizeId.M_13:
        return "13M";
      case ImageSizeId.M_8_3:
        return "8.3M";
      case ImageSizeId.M_7_5:
        return "7.5M";
      case ImageSizeId.M_5:
        return "5M";
      case ImageSizeId.M_4_2:
        return "4.2M";
      case ImageSizeId.M_3_7:
        return "3.7M";
      case ImageSizeId.M_2_1:
        return "2.1M";
      case ImageSizeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static ImageSizeId getIdFromUsb(int? usbValue) => ImageSizeId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(ImageSizeId, usbValue);
        return ImageSizeId.Unknown;
      });

  static ImageSizeId getIdFromWifi(String? wifiValue) => ImageSizeId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ImageSizeId, wifiValue);
        return ImageSizeId.Unknown;
      });
}
