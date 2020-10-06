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
  REQUEST_TO_NOTIFY_STREAMING_STATUS,
  DELETE_CONTENT,
  UNKNOWN
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
      case SonyWebApiMethodId.REQUEST_TO_NOTIFY_STREAMING_STATUS:
        return "requestToNotifyStreamingStatus";
      case SonyWebApiMethodId.DELETE_CONTENT:
        return "deleteContent";
      case SonyWebApiMethodId.UNKNOWN:
      default:
        return "";
    }
  }

  static SonyWebApiMethodId fromWifiValue(String value) {
    switch (value) {
      case "get":
        return SonyWebApiMethodId.GET;
      case "set":
        return SonyWebApiMethodId.SET;
      case "act":
        return SonyWebApiMethodId.ACT;
      case "await":
        return SonyWebApiMethodId.AWAIT;
      case "start":
        return SonyWebApiMethodId.START;
      case "stop":
        return SonyWebApiMethodId.STOP;
      case "cancel":
        return SonyWebApiMethodId.CANCEL;
      case "pause":
        return SonyWebApiMethodId.PAUSE;
      case "seek":
        return SonyWebApiMethodId.SEEK;
      case "requestToNotifyStreamingStatus":
        return SonyWebApiMethodId.REQUEST_TO_NOTIFY_STREAMING_STATUS;
      case "deleteContent":
        return SonyWebApiMethodId.DELETE_CONTENT;
      default:
        return SonyWebApiMethodId.UNKNOWN;
    }
  }
}