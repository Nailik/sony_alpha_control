import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

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
  Soft_Lo,
  Soft_Mid,
  Soft_Hi,
  Painting_Lo,
  Painting_Mid,
  Painting_Hi,
  Rich_BW,
  Miniature_Auto,
  Miniature_Top,
  Miniature_Horizontal,
  Miniature_Bottom,
  Miniature_Right,
  Miniature_Mid,
  Miniature_Left,
  Water_Color,
  Illustration_Lo,
  Illustration_Mid,
  Illustration_Hi,
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
      case PictureEffectId.Soft_Lo:
        return 0x8070;
      case PictureEffectId.Soft_Mid:
        return 0x8071;
      case PictureEffectId.Soft_Hi:
        return 0x8072;
      case PictureEffectId.Painting_Lo:
        return 0x8080;
      case PictureEffectId.Painting_Mid:
        return 0x8081;
      case PictureEffectId.Painting_Hi:
        return 0x8082;
      case PictureEffectId.Rich_BW: //Mono
        return 0x8090;
      case PictureEffectId.Miniature_Auto:
        return 0x80A0;
      case PictureEffectId.Miniature_Top:
        return 0x80A1;
      case PictureEffectId.Miniature_Horizontal:
        return 0x80A2;
      case PictureEffectId.Miniature_Bottom:
        return 0x80A3;
      case PictureEffectId.Miniature_Right:
        return 0x80A4;
      case PictureEffectId.Miniature_Mid:
        return 0x80A5;
      case PictureEffectId.Miniature_Left:
        return 0x80A6;
      case PictureEffectId.Water_Color:
        return 0x80B0;
      case PictureEffectId.Illustration_Lo:
        return 0x80C0;
      case PictureEffectId.Illustration_Mid:
        return 0x80C1;
      case PictureEffectId.Illustration_Hi:
        return 0x80C2;
      case PictureEffectId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => throw UnimplementedError;

  static PictureEffectId getIdFromUsb(int? usbValue) => PictureEffectId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(PictureEffectId, usbValue);
        return PictureEffectId.Unknown;
      });

  static PictureEffectId getIdFromWifi(String wifiValue) =>
      PictureEffectId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(PictureEffectId, wifiValue);
        return PictureEffectId.Unknown;
      });
}
