//this file reads ids for usb

import 'package:sonyalphacontrol/top_level_api/ids/ids_settings.dart';

extension AspectRatioIdExtension on AspectRatioId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case AspectRatioId.Ar3_2:
        return 1;
      case AspectRatioId.Ar16_9:
        return 2;
      case AspectRatioId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

AspectRatioId getAspectRatioId(int value) {
  return AspectRatioId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => AspectRatioId.Unknown);
}


extension DriveModeIdExtension on DriveModeId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case DriveModeId.SingleShooting:
        return 0x0001;
      case DriveModeId.ContinuousShooting_Hi:
        return 0x0002;
      case DriveModeId.ContinuousShooting_Mid:
        return 0x8015;
      case DriveModeId.ContinuousShooting_Lo:
        return 0x8012;
      case DriveModeId.ContinuousShooting_HiPlus:
        return 0x8010;
      case DriveModeId.SelfTimerSingle_2Sec:
        return 0x8005;
      case DriveModeId.SelfTimerSingle_5Sec:
        return 0x8003;
      case DriveModeId.SelfTimerSingle_10Sec:
        return 0x8004;
      case DriveModeId.ContBracket_03EV_3Img:
        return 0x8337;
      case DriveModeId.ContBracket_03EV_5Img:
        return 0x8537;
      case DriveModeId.ContBracket_03EV_9Img:
        return 0x8937;
      case DriveModeId.ContBracket_05EV_3Img:
        return 0x8357;
      case DriveModeId.ContBracket_05EV_5Img:
        return 0x8557;
      case DriveModeId.ContBracket_05EV_9Img:
        return 0x8957;
      case DriveModeId.ContBracket_07EV_3Img:
        return 0x8377;
      case DriveModeId.ContBracket_07EV_5Img:
        return 0x8577;
      case DriveModeId.ContBracket_07EV_9Img:
        return 0x8977;
      case DriveModeId.ContBracket_10EV_3Img:
        return 0x8311;
      case DriveModeId.ContBracket_10EV_5Img:
        return 0x8511;
      case DriveModeId.ContBracket_10EV_9Img:
        return 0x8911;
      case DriveModeId.ContBracket_20EV_3Img:
        return 0x8321;
      case DriveModeId.ContBracket_20EV_5Img:
        return 0x8521;
      case DriveModeId.ContBracket_30EV_3Img:
        return 0x8331;
      case DriveModeId.ContBracket_30EV_5Img:
        return 0x8531;
      case DriveModeId.SingleBracket_03EV_3Img:
        return 0x8336;
      case DriveModeId.SingleBracket_03EV_5Img:
        return 0x8536;
      case DriveModeId.SingleBracket_03EV_9Img:
        return 0x8936;
      case DriveModeId.SingleBracket_05EV_3Img:
        return 0x8356;
      case DriveModeId.SingleBracket_05EV_5Img:
        return 0x8556;
      case DriveModeId.SingleBracket_05EV_9Img:
        return 0x8956;
      case DriveModeId.SingleBracket_07EV_3Img:
        return 0x8376;
      case DriveModeId.SingleBracket_07EV_5Img:
        return 0x8576;
      case DriveModeId.SingleBracket_07EV_9Img:
        return 0x8976;
      case DriveModeId.SingleBracket_10EV_3Img:
        return 0x8310;
      case DriveModeId.SingleBracket_10EV_5Img:
        return 0x8510;
      case DriveModeId.SingleBracket_10EV_9Img:
        return 0x8910;
      case DriveModeId.SingleBracket_20EV_3Img:
        return 0x8320;
      case DriveModeId.SingleBracket_20EV_5Img:
        return 0x8520;
      case DriveModeId.SingleBracket_30EV_3Img:
        return 0x8330;
      case DriveModeId.SingleBracket_30EV_5Img:
        return 0x8530;
      case DriveModeId.WhiteBalanceBracket_Lo:
        return 0x8018;
      case DriveModeId.WhiteBalanceBracket_Hi:
        return 0x8028;
      case DriveModeId.DROBracket_Lo:
        return 0x8019;
      case DriveModeId.DROBracket_Hi:
        return 0x8029;
      case DriveModeId.SelfTimerCont_10Sec_3Img:
        return 0x8008;
      case DriveModeId.SelfTimerCont_10Sec_5Img:
        return 0x8009;
      case DriveModeId.SelfTimerCont_2Sec_3Img:
        return 0x800E;
      case DriveModeId.SelfTimerCont_2Sec_5Img:
        return 0x800F;
      case DriveModeId.SelfTimerCont_5Sec_3Img:
        return 0x800C;
      case DriveModeId.SelfTimerCont_5Sec_5Img:
        return 0x800D;
      case DriveModeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

DriveModeId getDriveModeId(int value) {
  return DriveModeId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => DriveModeId.Unknown);
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



extension FlashModeIdExtension on FlashModeId {
  String get name => toString().split('.')[1];

  int get value {
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
}//8004

FlashModeId getFlashModeId(int value) {
  return FlashModeId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FlashModeId.Unknown);
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

extension FocusMagnifierPhaseIdExtension on FocusMagnifierPhaseId {
  String get name => toString().split('.')[1];

  int get value {
    switch (this) {
      case FocusMagnifierPhaseId.Inactive:
        return 0;
      case FocusMagnifierPhaseId.SelectRegion:
        return 1;
      case FocusMagnifierPhaseId.Magnify:
        return 2;
      case FocusMagnifierPhaseId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

FocusMagnifierPhaseId geFocusMagnifierPhaseId(int value) {
  return FocusMagnifierPhaseId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FocusMagnifierPhaseId.Unknown);
}

extension FocusMagnifierDirectionIdExtension on FocusMagnifierDirectionId {
  String get name => toString().split('.')[1];
  int get value {
    switch (this) {
      case FocusMagnifierDirectionId.Left:
        return 0;
      case FocusMagnifierDirectionId.Right:
        return 1;
      case FocusMagnifierDirectionId.Up:
        return 2;
      case FocusMagnifierDirectionId.Down:
        return 3;
      case FocusMagnifierDirectionId.Unknown:
        return -1;
      default:
        return -2;
    }
  }
}

FocusMagnifierDirectionId geFocusMagnifierDirectionId(int value) {
  return FocusMagnifierDirectionId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => FocusMagnifierDirectionId.Unknown);
}