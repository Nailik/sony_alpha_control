/// <summary>
/// DRO/Auto HDR (Dynamic-Range Optimizer / Auto High Dynamic Range)
/// </summary>
enum DroHdrId {
  DrOff,
  DroLv1,
  DroLv2,
  DroLv3,
  DroLv4,
  DroLv5,
  DroAuto,
  HdrAuto,
  Hdr1Ev,
  Hdr2Ev,
  Hdr3Ev,
  Hdr4Ev,
  Hdr5Ev,
  Hdr6Ev,
  Unknown
}

extension DroHdrIdExtension on DroHdrId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case DroHdrId.DrOff:
        return 0x01;
      case DroHdrId.DroLv1:
        return 0x11;
      case DroHdrId.DroLv2:
        return 0x12;
      case DroHdrId.DroLv3:
        return 0x13;
      case DroHdrId.DroLv4:
        return 0x14;
      case DroHdrId.DroLv5:
        return 0x15;
      case DroHdrId.DroAuto:
        return 0x1F;
      case DroHdrId.HdrAuto:
        return 0x20;
      case DroHdrId.Hdr1Ev:
        return 0x21;
      case DroHdrId.Hdr2Ev:
        return 0x22;
      case DroHdrId.Hdr3Ev:
        return 0x23;
      case DroHdrId.Hdr4Ev:
        return 0x24;
      case DroHdrId.Hdr5Ev:
        return 0x25;
      case DroHdrId.Hdr6Ev:
        return 0x26;
      case DroHdrId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}
DroHdrId getDroHdrId(int value) {
  return DroHdrId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => DroHdrId.Unknown);
}

