enum FocusAreaId {
  Wide,
  Zone,
  Center,
  FlexibleSpotS,
  FlexibleSpotM,
  FlexibleSpotL,
  ExpandFlexibleSpot,
  LockOnAF_Wide,
  LockOnAF_Zone,
  LockOnAF_Center,
  LockOnAF_FlexibleSpotS,
  LockOnAF_FlexibleSpotM,
  LockOnAF_FlexibleSpotL,
  LockOnAF_ExpandFlexibleSpot,
  Unknown
}

extension FocusAreaIdExtension on FocusAreaId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case FocusAreaId.Wide:
        return 0x0001;
      case FocusAreaId.Zone:
        return 0x0002;
      case FocusAreaId.Center:
        return 0x0003;
      case FocusAreaId.FlexibleSpotS:
        return 0x0101;
      case FocusAreaId.FlexibleSpotM:
        return 0x0102;
      case FocusAreaId.FlexibleSpotL:
        return 0x0103;
      case FocusAreaId.ExpandFlexibleSpot:
        return 0x0104;
      case FocusAreaId.LockOnAF_Wide:
        return 0x0201;
      case FocusAreaId.LockOnAF_Zone:
        return 0x0202;
      case FocusAreaId.LockOnAF_Center:
        return 0x0203;
      case FocusAreaId.LockOnAF_FlexibleSpotS:
        return 0x0204;
      case FocusAreaId.LockOnAF_FlexibleSpotM:
        return 0x0205;
      case FocusAreaId.LockOnAF_FlexibleSpotL:
        return 0x0206;
      case FocusAreaId.LockOnAF_ExpandFlexibleSpot:
        return 0x0207;
      case FocusAreaId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

FocusAreaId getFocusAreaId(int value) {
  return FocusAreaId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FocusAreaId.Unknown);
}
