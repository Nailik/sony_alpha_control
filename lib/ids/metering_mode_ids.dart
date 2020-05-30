enum MeteringModeId {
  Multi,
  Center,
  EntireScreenAvg,
  SpotStandard,
  SpotLarge,
  Highlight,
  Unknown
}

extension MeteringModeIdExtension on MeteringModeId {
  String get name => toString().split('.')[1];

  //given: 0x8002 - actual 0x02
  int get value {
    switch (this) {
      case MeteringModeId.Multi:
        return 0x01;
      case MeteringModeId.Center: //2
        return 0x02;
      case MeteringModeId.EntireScreenAvg:
        return 0x03;
      case MeteringModeId.SpotStandard:
        return 0x04;
      case MeteringModeId.SpotLarge:
        return 0x05;
      case MeteringModeId.Highlight:
        return 0x06;
      case MeteringModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}
//2
MeteringModeId getMeteringModeId(int value) {
  return MeteringModeId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => MeteringModeId.Unknown);
}