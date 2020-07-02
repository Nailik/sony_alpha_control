import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

enum MeteringModeId {
  Multi,
  Multi_2,
  Center,
  Center_2,
  EntireScreenAvg,
  EntireScreenAvg_2,
  SpotStandard,
  SpotStandard_2,
  SpotLarge,
  SpotLarge_2,
  Highlight,
  Highlight_2,
  Unknown
}

extension MeteringModeIdExtension on MeteringModeId {
  String get name => toString().split('.')[1];

  //given: 0x8002 - actual 0x02
  int get usbValue {
    switch (this) {
      case MeteringModeId.Multi:
        return 0x01;
      case MeteringModeId.Multi_2:
        return 0x8001;
      case MeteringModeId.Center:
        return 0x02;
      case MeteringModeId.Center_2: //TODO?????
        return 0x8002;
      case MeteringModeId.EntireScreenAvg:
        return 0x03;
      case MeteringModeId.EntireScreenAvg_2:
        return 0x8003;
      case MeteringModeId.SpotStandard:
        return 0x04;
      case MeteringModeId.SpotStandard_2:
        return 0x8004;
      case MeteringModeId.SpotLarge:
        return 0x05;
      case MeteringModeId.SpotLarge_2:
        return 0x8005;
      case MeteringModeId.Highlight:
        return 0x06;
      case MeteringModeId.Highlight_2:
        return 0x8006;
      case MeteringModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => "";
}

MeteringModeId getMeteringModeId(int usbValue) {
  return MeteringModeId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => MeteringModeId.Unknown);
}

class MeteringModeValue extends SettingsValue<MeteringModeId> {
  MeteringModeValue(MeteringModeId id) : super(id);

  @override
  factory MeteringModeValue.fromUSBValue(int usbValue) {
    return MeteringModeValue(getMeteringModeId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
