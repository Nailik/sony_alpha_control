import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

enum PictureEffectId {
  Off,
  ToyCamera_Normal,
  ToyCamera_Cool,
  ToyCamera_Warm,
  ToyCamera_Green,
  ToyCamera_Magenta,
  PopColor,
  Posterization_BW,
  Posterization_Color,
  RetroPhoto,
  SoftHighKey,
  PartialColor_Red,
  PartialColor_Green,
  PartialColor_Blue,
  PartialColor_Yellow,
  HighContrastMono,
  RichToneMono,
  Unknown
}

extension PictureEffectIdExtension on PictureEffectId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case PictureEffectId.Off:
        return 0x8000;
      case PictureEffectId.ToyCamera_Normal:
        return 0x8001;
      case PictureEffectId.ToyCamera_Cool:
        return 0x8002;
      case PictureEffectId.ToyCamera_Warm:
        return 0x8003;
      case PictureEffectId.ToyCamera_Green:
        return 0x8004;
      case PictureEffectId.ToyCamera_Magenta:
        return 0x8005;
      case PictureEffectId.PopColor:
        return 0x8010;
      case PictureEffectId.Posterization_BW:
        return 0x8020;
      case PictureEffectId.Posterization_Color:
        return 0x8021;
      case PictureEffectId.RetroPhoto:
        return 0x8030;
      case PictureEffectId.SoftHighKey:
        return 0x8040;
      case PictureEffectId.PartialColor_Red:
        return 0x8050;
      case PictureEffectId.PartialColor_Green:
        return 0x8051;
      case PictureEffectId.PartialColor_Blue:
        return 0x8052;
      case PictureEffectId.PartialColor_Yellow:
        return 0x8053;
      case PictureEffectId.HighContrastMono:
        return 0x8060;
      case PictureEffectId.RichToneMono:
        return 0x8090;
      case PictureEffectId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => "";
}

PictureEffectId getPictureEffectId(int usbValue) {
  return PictureEffectId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => PictureEffectId.Unknown);
}

class PictureEffectValue extends SettingsValue<PictureEffectId> {
  PictureEffectValue(PictureEffectId id) : super(id);

  @override
  factory PictureEffectValue.fromUSBValue(int usbValue) {
    return PictureEffectValue(getPictureEffectId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
