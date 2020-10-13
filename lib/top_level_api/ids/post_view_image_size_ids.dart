import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum PostViewImageSizeId { TWO_MP, Original, Unknown }

extension PostViewImageSizeIdExtension on PostViewImageSizeId {
  String get name => wifiValue;

  String get wifiValue {
    switch (this) {
      case PostViewImageSizeId.TWO_MP:
        return "2M";
      case PostViewImageSizeId.Original:
        return "Original";
      case PostViewImageSizeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static PostViewImageSizeId getIdFromWifi(String wifiValue) => PostViewImageSizeId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(PostViewImageSizeId, wifiValue);
        return PostViewImageSizeId.Unknown;
      });
}
