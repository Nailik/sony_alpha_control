import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum DriveModeId {
  SingleShooting,

// Continuous shooting

  ContinuousShooting_Hi,
  ContinuousShooting_Mid,
  ContinuousShooting_Lo,
  ContinuousShooting_HiPlus,

  /*
  ContinuousShooting_10FPS_1Sec,//10 frames in 1 second
  ContinuousShooting_8FPS_1Sec,//10 frames in 1.25 seconds
  ContinuousShooting_,//10 frames in 2 seconds
  ContinuousShooting_HiPlus,//10 frames in 5 seconds

        const val Single = "Single"
        const val Continuous = "Continuous"
        const val SpdPriorityCont = "Spd Priority Cont."
        const val Burst = "Burst"
        const val MotionShot = "MotionShot"
   */

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

extension DriveModeIdExtension on DriveModeId {
  String get name => toString().split('.')[1];

  int get usbValue {
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

  String get wifiValue => throw UnimplementedError; //TODO

  static DriveModeId getIdFromUsb(int usbValue) => DriveModeId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(DriveModeId, usbValue);
        return DriveModeId.Unknown;
      });

  static DriveModeId getIdFromWifi(String wifiValue) => DriveModeId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(DriveModeId, wifiValue);
        return DriveModeId.Unknown;
      });
}
