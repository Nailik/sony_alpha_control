import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum FlashModeId {
  AutoFlash,
  FlashOff,
  FillFlash,
  EyeFlashAuto, // unsure of offical name
  EyeFlash, // unsure of offical name
  AltSlowSync,
  RearSync,
  EyeFlashAuto_SlowSync, // unsure of offical name
  SlowSync,
  SlowWL,
  WirelessSync,
  RearWL,
  Unknown
}

extension FlashModeIdExtension on FlashModeId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case FlashModeId.AutoFlash:
        return 1;
      case FlashModeId.FlashOff:
        return 2;
      case FlashModeId.FillFlash:
        return 3;
      case FlashModeId.EyeFlashAuto:
        return 4;
      case FlashModeId.EyeFlash:
        return 5;
      case FlashModeId.AltSlowSync:
        return 0x8001;
      case FlashModeId.RearSync:
        return 0x8003;
      case FlashModeId.EyeFlashAuto_SlowSync:
        return 0x8031;
      case FlashModeId.SlowSync:
        return 0x8032;
      case FlashModeId.SlowWL:
        return 0x8041;
      case FlashModeId.WirelessSync:
        return 0x8004;
      case FlashModeId.RearWL:
        return 0x8042;
      case FlashModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => "";
} //8004

FlashModeId getFlashModeId(int usbValue) {
  return FlashModeId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => FlashModeId.Unknown);
}

class FlashModeValue extends SettingsValue<FlashModeId> {
  FlashModeValue(FlashModeId id) : super(id);

  @override
  factory FlashModeValue.fromUSBValue(int usbValue) {
    return FlashModeValue(getFlashModeId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
