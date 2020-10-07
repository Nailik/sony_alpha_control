import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum ApiMethodId {
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

extension SonyWebApiMethodExtension on ApiMethodId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case ApiMethodId.GET:
        return "get";
      case ApiMethodId.GET_AVAILABLE:
        return "getAvailable";
      case ApiMethodId.GET_SUPPORTED:
        return "getSupported";
      case ApiMethodId.SET:
        return "set";
      case ApiMethodId.ACT:
        return "act";
      case ApiMethodId.AWAIT:
        return "await";
      case ApiMethodId.START:
        return "start";
      case ApiMethodId.STOP:
        return "stop";
      case ApiMethodId.CANCEL:
        return "cancel";
      case ApiMethodId.PAUSE:
        return "pause";
      case ApiMethodId.SEEK:
        return "seek";
      case ApiMethodId.NOTIFY_STREAMING_STATUS:
        return "notifyStreamingStatus";
      case ApiMethodId.DELETE:
        return "delete";
      case ApiMethodId.Unknown:
      default:
        return "";
    }
  }

  static ApiMethodId getIdFromWifi(String wifiValue) =>
      ApiMethodId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ApiMethodId, wifiValue);
        return ApiMethodId.Unknown;
      });
}
