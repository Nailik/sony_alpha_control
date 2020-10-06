import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum SonyWebApiMethodId {
  //important that the longer get is before "get" for some other logic
  GET_AVAILABLE,
  GET_SUPPORTED,
  GET,
  SET,
  ACT,
  AWAIT,
  START,
  STOP,
  CANCEL,
  PAUSE,
  SEEK,
  NOTIFY_STREAMING_STATUS,
  DELETE,
  Unknown
}

extension SonyWebApiMethodExtension on SonyWebApiMethodId {
  String get wifiValue {
    switch (this) {
      case SonyWebApiMethodId.GET:
        return "get";
      case SonyWebApiMethodId.GET_AVAILABLE:
        return "getAvailable";
      case SonyWebApiMethodId.GET_SUPPORTED:
        return "getSupported";
      case SonyWebApiMethodId.SET:
        return "set";
      case SonyWebApiMethodId.ACT:
        return "act";
      case SonyWebApiMethodId.AWAIT:
        return "await";
      case SonyWebApiMethodId.START:
        return "start";
      case SonyWebApiMethodId.STOP:
        return "stop";
      case SonyWebApiMethodId.CANCEL:
        return "cancel";
      case SonyWebApiMethodId.PAUSE:
        return "pause";
      case SonyWebApiMethodId.SEEK:
        return "seek";
      case SonyWebApiMethodId.NOTIFY_STREAMING_STATUS:
        return "notifyStreamingStatus";
      case SonyWebApiMethodId.DELETE:
        return "delete";
      case SonyWebApiMethodId.Unknown:
      default:
        return "";
    }
  }

  static SonyWebApiMethodId getIdFromWifi(String wifiValue) =>
      SonyWebApiMethodId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(SonyWebApiMethodId, wifiValue);
        return SonyWebApiMethodId.Unknown;
      });
}
