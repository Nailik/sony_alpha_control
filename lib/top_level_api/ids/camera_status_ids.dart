import 'package:sonyalphacontrol/top_level_api/api/logger.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum CameraStatusId {
  Error,
  NotReady,
  IDLE,
  StillCapturing,
  StillSaving,
  StillPostProcessing,
  MovieWaitRecStart,
  MovieRecording,
  MovieWaitRecStop,
  MovieSaving,
  AudioWaitRecStart,
  AudioRecording,
  AudioWaitRecStop,
  AudioSaving,
  IntervalWaitRecStart,
  IntervalRecording,
  IntervalWaitRecStop,
  LoopWaitRecStart,
  LoopRecording,
  LoopWaitRecStop,
  LoopSaving,
  WhiteBalanceOnePushCapturing,
  ContentsTransfer,
  Streaming,
  Deleting,
  Unknown
}

extension CameraStatusIdExtension on CameraStatusId {
  String get name => toString().split('.')[1];

  int get usbValue => throw UnimplementedError;

  String get wifiValue {
    switch (this) {
      case CameraStatusId.Error:
        return "Error";
      case CameraStatusId.NotReady:
        return "NotReady";
      case CameraStatusId.IDLE:
        return "IDLE";
      case CameraStatusId.StillCapturing:
        return "StillCapturing";
      case CameraStatusId.StillSaving:
        return "StillSaving";
      case CameraStatusId.StillPostProcessing:
        return "StillPostProcessing";
      case CameraStatusId.MovieWaitRecStart:
        return "MovieWaitRecStart";
      case CameraStatusId.MovieRecording:
        return "MovieRecording";
      case CameraStatusId.MovieWaitRecStop:
        return "MovieWaitRecStop";
      case CameraStatusId.MovieSaving:
        return "MovieSaving";
      case CameraStatusId.AudioWaitRecStart:
        return "AudioWaitRecStart";
      case CameraStatusId.AudioRecording:
        return "AudioRecording";
      case CameraStatusId.AudioWaitRecStop:
        return "AudioWaitRecStop";
      case CameraStatusId.AudioSaving:
        return "AudioSaving";
      case CameraStatusId.IntervalWaitRecStart:
        return "IntervalWaitRecStart";
      case CameraStatusId.IntervalRecording:
        return "IntervalRecording";
      case CameraStatusId.IntervalWaitRecStop:
        return "IntervalWaitRecStop";
      case CameraStatusId.LoopWaitRecStart:
        return "LoopWaitRecStart";
      case CameraStatusId.LoopRecording:
        return "LoopRecording";
      case CameraStatusId.LoopWaitRecStop:
        return "LoopWaitRecStop";
      case CameraStatusId.LoopSaving:
        return "LoopSaving";
      case CameraStatusId.WhiteBalanceOnePushCapturing:
        return "WhiteBalanceOnePushCapturing";
      case CameraStatusId.ContentsTransfer:
        return "ContentsTransfer";
      case CameraStatusId.Streaming:
        return "Streaming";
      case CameraStatusId.Deleting:
        return "Deleting";
      case CameraStatusId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static CameraStatusId getIdFromUsb(int usbValue) => CameraStatusId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(CameraStatusId, usbValue);
        return CameraStatusId.Unknown;
      });

  static CameraStatusId getIdFromWifi(String wifiValue) => CameraStatusId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(CameraStatusId, wifiValue);
        return CameraStatusId.Unknown;
      });
}

class CameraStatusValue extends SettingsValue<CameraStatusId> {
  CameraStatusValue(CameraStatusId id) : super(id);

  @override
  factory CameraStatusValue.fromUSBValue(int usbValue) =>
      CameraStatusValue(CameraStatusIdExtension.getIdFromUsb(usbValue));

  @override
  factory CameraStatusValue.fromWifiValue(String wifiValue) =>
      CameraStatusValue(CameraStatusIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
