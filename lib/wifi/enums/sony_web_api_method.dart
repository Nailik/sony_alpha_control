import 'package:json_annotation/json_annotation.dart';

enum SonyWebApiMethod {
  GET,
  SET,
  GET_AVAILABLE,
  GET_SUPPORTED,
  ACT,
  AWAIT,
  START,
  STOP,
  CANCEL,
  PAUSE,
  SEEK,
  REQUEST_TO_NOTIFY_STREAMING_STATUS,
  DELETE_CONTENT,
  UNKNOWN
}

extension SonyWebApiMethodExtension on SonyWebApiMethod {
  String get wifiValue {
    switch (this) {
      case SonyWebApiMethod.GET:
        return "get";
      case SonyWebApiMethod.GET_AVAILABLE:
        return "getAvailable";
      case SonyWebApiMethod.GET_SUPPORTED:
        return "getSupported";
      case SonyWebApiMethod.SET:
        return "set";
      case SonyWebApiMethod.ACT:
        return "act";
      case SonyWebApiMethod.AWAIT:
        return "await";
      case SonyWebApiMethod.START:
        return "start";
      case SonyWebApiMethod.STOP:
        return "stop";
      case SonyWebApiMethod.CANCEL:
        return "cancel";
      case SonyWebApiMethod.PAUSE:
        return "pause";
      case SonyWebApiMethod.SEEK:
        return "seek";
      case SonyWebApiMethod.REQUEST_TO_NOTIFY_STREAMING_STATUS:
        return "requestToNotifyStreamingStatus";
      case SonyWebApiMethod.DELETE_CONTENT:
        return "deleteContent";
      case SonyWebApiMethod.UNKNOWN:
      default:
        return "";
    }
  }

  static SonyWebApiMethod fromWifiValue(String value) {
    switch (value) {
      case "get":
        return SonyWebApiMethod.GET;
      case "set":
        return SonyWebApiMethod.SET;
      case "act":
        return SonyWebApiMethod.ACT;
      case "await":
        return SonyWebApiMethod.AWAIT;
      case "start":
        return SonyWebApiMethod.START;
      case "stop":
        return SonyWebApiMethod.STOP;
      case "cancel":
        return SonyWebApiMethod.CANCEL;
      case "pause":
        return SonyWebApiMethod.PAUSE;
      case "seek":
        return SonyWebApiMethod.SEEK;
      case "requestToNotifyStreamingStatus":
        return SonyWebApiMethod.REQUEST_TO_NOTIFY_STREAMING_STATUS;
      case "deleteContent":
        return SonyWebApiMethod.DELETE_CONTENT;
      default:
        return SonyWebApiMethod.UNKNOWN;
    }
  }
}

class SonyWebApiMethodConverter
    implements JsonConverter<SonyWebApiMethod, String> {
  const SonyWebApiMethodConverter();

  @override
  SonyWebApiMethod fromJson(String json) =>
      SonyWebApiMethodExtension.fromWifiValue(json);

  @override
  String toJson(SonyWebApiMethod value) => value.wifiValue;
}
