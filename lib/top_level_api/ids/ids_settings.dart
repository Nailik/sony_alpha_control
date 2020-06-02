enum AspectRatioId { Ar3_2, Ar16_9, Unknown }

enum DriveModeId {
  SingleShooting,

// Continuous shooting

  ContinuousShooting_Hi,
  ContinuousShooting_Mid,
  ContinuousShooting_Lo,
  ContinuousShooting_HiPlus,

// Self timer (single)

  SelfTimerSingle_2Sec,
  SelfTimerSingle_5Sec,
  SelfTimerSingle_10Sec,

// Cont. Bracket

  ContBracket_03EV_3Img,
  ContBracket_03EV_5Img,
  ContBracket_03EV_9Img,
  ContBracket_05EV_3Img,
  ContBracket_05EV_5Img,
  ContBracket_05EV_9Img,
  ContBracket_07EV_3Img,
  ContBracket_07EV_5Img,
  ContBracket_07EV_9Img,
  ContBracket_10EV_3Img,
  ContBracket_10EV_5Img,
  ContBracket_10EV_9Img,
  ContBracket_20EV_3Img,
  ContBracket_20EV_5Img,
  ContBracket_30EV_3Img,
  ContBracket_30EV_5Img,

// Single Bracket

  SingleBracket_03EV_3Img,
  SingleBracket_03EV_5Img,
  SingleBracket_03EV_9Img,
  SingleBracket_05EV_3Img,
  SingleBracket_05EV_5Img,
  SingleBracket_05EV_9Img,
  SingleBracket_07EV_3Img,
  SingleBracket_07EV_5Img,
  SingleBracket_07EV_9Img,
  SingleBracket_10EV_3Img,
  SingleBracket_10EV_5Img,
  SingleBracket_10EV_9Img,
  SingleBracket_20EV_3Img,
  SingleBracket_20EV_5Img,
  SingleBracket_30EV_3Img,
  SingleBracket_30EV_5Img,

// White Balance Bracket

  WhiteBalanceBracket_Lo,
  WhiteBalanceBracket_Hi,

// DRO Bracket

  DROBracket_Lo,
  DROBracket_Hi,

// Self timer (continuous)

  SelfTimerCont_10Sec_3Img,
  SelfTimerCont_10Sec_5Img,
  SelfTimerCont_2Sec_3Img,
  SelfTimerCont_2Sec_5Img,
  SelfTimerCont_5Sec_3Img,
  SelfTimerCont_5Sec_5Img,
  Unknown,
}

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

enum FocusMagnifierPhaseId {
  /// <summary>
  /// The magnifier isn't currently being used
  /// </summary>
  Inactive,

  /// <summary>
  /// x1.0, this phase is used to select the screen region to magnify
  /// </summary>
  SelectRegion,

  /// <summary>
  /// Actively magnifying a region of the screen
  /// </summary>
  Magnify,
  Unknown
}

enum FocusMagnifierDirectionId { Left, Right, Up, Down, Unknown }

