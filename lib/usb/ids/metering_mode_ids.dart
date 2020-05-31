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
  int get value {
    switch (this) {
      case MeteringModeId.Multi:
        return 0x01;
      case MeteringModeId.Multi_2:
        return 0x8001;
      case MeteringModeId.Center: //2
        return 0x02;
      case MeteringModeId.Center_2: //2
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
}

//2
MeteringModeId getMeteringModeId(int value) {
  return MeteringModeId.values.firstWhere((element) => element.value == value,
      orElse: () => MeteringModeId.Unknown);
}
