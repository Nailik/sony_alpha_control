import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

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
      FocusMagnifierDirectionId.values.firstWhere(
          (element) => element.usbValue == usbValue,
          orElse: () => FocusMagnifierDirectionId.Unknown);

  static FocusMagnifierDirectionId getIdFromWifi(String wifiValue) =>
      FocusMagnifierDirectionId.values.firstWhere(
          (element) => element.wifiValue == wifiValue,
          orElse: () => FocusMagnifierDirectionId.Unknown);
}

class FocusMagnifierDirectionValue
    extends SettingsValue<FocusMagnifierDirectionId> {
  FocusMagnifierDirectionValue(FocusMagnifierDirectionId id) : super(id);

  @override
  factory FocusMagnifierDirectionValue.fromUSBValue(int usbValue) =>
      FocusMagnifierDirectionValue(
          FocusMagnifierDirectionIdExtension.getIdFromUsb(usbValue));

  @override
  factory FocusMagnifierDirectionValue.fromWifiValue(String wifiValue) =>
      FocusMagnifierDirectionValue(
          FocusMagnifierDirectionIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
