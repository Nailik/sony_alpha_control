import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum FocusMagnifierDirectionId { Left, Right, Up, Down, Unknown }

extension FocusMagnifierDirectionIdExtension on FocusMagnifierDirectionId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case FocusMagnifierDirectionId.Left:
        return 0;
      case FocusMagnifierDirectionId.Right:
        return 1;
      case FocusMagnifierDirectionId.Up:
        return 2;
      case FocusMagnifierDirectionId.Down:
        return 3;
      case FocusMagnifierDirectionId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => throw UnimplementedError;

  static FocusMagnifierDirectionId getIdFromUsb(int usbValue) =>
      FocusMagnifierDirectionId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(FocusMagnifierDirectionId, usbValue);
        return FocusMagnifierDirectionId.Unknown;
      });

  static FocusMagnifierDirectionId getIdFromWifi(String wifiValue) =>
      FocusMagnifierDirectionId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(FocusMagnifierDirectionId, wifiValue);
        return FocusMagnifierDirectionId.Unknown;
      });
}
