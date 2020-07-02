import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

enum FocusModeId {
  MF,
  AF_SingleShot,
  AF_Continuous,
  AF_Automatic,
  DMF,
  Unknown
}

extension FocusModeIdExtension on FocusModeId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case FocusModeId.MF:
        return 0x0001;
      case FocusModeId.AF_SingleShot:
        return 0x0002;
      case FocusModeId.AF_Continuous:
        return 0x8004;
      case FocusModeId.AF_Automatic:
        return 0x8005;
      case FocusModeId.DMF:
        return 0x8006;
      case FocusModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => "";
}

FocusModeId getFocusModeId(int usbValue) {
  return FocusModeId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => FocusModeId.Unknown);
}

class FocusModeValue extends SettingsValue<FocusModeId> {
  FocusModeValue(FocusModeId id) : super(id);

  @override
  factory FocusModeValue.fromUSBValue(int usbValue) {
    return FocusModeValue(getFocusModeId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
