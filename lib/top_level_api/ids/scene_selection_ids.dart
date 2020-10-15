import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum SceneSelectionId { Normal, UnderWater, Unknown }

extension SceneSelectionIdExtension on SceneSelectionId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case SceneSelectionId.Normal:
        return "Normal";
      case SceneSelectionId.UnderWater:
        return "Under Water";
      case SceneSelectionId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static SceneSelectionId getIdFromWifi(String wifiValue) =>
      SceneSelectionId.values.firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(SceneSelectionId, wifiValue);
        return SceneSelectionId.Unknown;
      });
}
