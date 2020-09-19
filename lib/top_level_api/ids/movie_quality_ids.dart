import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum MovieQualityId {
  MP4_PS, //MP4, 1920x1080 60p/50p
  MP4_HQ, //MP4, 1920x1080 30p/25p
  MP4_STD, //MP4, 1280x720 30p/25p
  MP4_VGA, //MP4, 640x480 30p/25p
  MP4_SLOW, //MP4, 1280x720 30p (Imaging frame rate: 60p)
  MP4_SSLOW, //MP4, 1280x720 30p/25p (Imaging frame rate: 120p/100p)
  MP4_HS120, //MP4, 1280x720 120p
  MP4_HS100, //MP4, 1280x720 100p
  MP4_HS240, //MP4, 800x480 240p
  MP4_HS200, //MP4, 800x480 200p
  XAVC_S_50M_60p, //XAVC S, 1920x1080 60p 50Mbps
  XAVC_S_50M_50p, //XAVC S, 1920x1080 50p 50Mbps
  XAVC_S_50M_30p, //XAVC S, 1920x1080 30p 50Mbps
  XAVC_S_50M_25p, //XAVC S, 1920x1080 25p 50Mbps
  XAVC_S_50M_24p, //XAVC S, 1920x1080 24p 50Mbps
  XAVC_S_100M_120p, //XAVC S, 1920x1080 120p 100Mbps
  XAVC_S_100M_100p, //XAVC S, 1920x1080 100p 100Mbps
  XAVC_S_60M_120p, //XAVC S, 1920x1080 120p 60Mbps
  XAVC_S_60M_100p, //XAVC S, 1920x1080 100p 60Mbps
  XAVC_S_100M_240p, //XAVC S, 1280x720 240p 100Mbps
  XAVC_S_100M_200p, //XAVC S, 1280x720 200p 100Mbps
  XAVC_S_60M_240p, //XAVC S, 1280x720 240p 60Mbps
  XAVC_S_60M_200p, //XAVC S, 1280x720 200p 60Mbps
  XAVC_S_100M_30p, //XAVC S, 3840x2160 30p 100Mbps
  XAVC_S_100M_25p, //XAVC S, 3840x2160 25p 100Mbps
  XAVC_S_100M_24p, //XAVC S, 3840x2160 24p 100Mbps
  XAVC_S_60M_30p, //XAVC S, 3840x2160 30p 60Mbps
  XAVC_S_60M_25p, //XAVC S, 3840x2160 25p 60Mbps
  XAVC_S_60M_24p, //XAVC S, 3840x2160 24p 60Mbps
  Unknown
}

extension MovieFileFormatIdExtension on MovieQualityId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case MovieQualityId.MP4_PS:
        return "PS";
      case MovieQualityId.MP4_HQ:
        return "HQ";
      case MovieQualityId.MP4_STD:
        return "STD";
      case MovieQualityId.MP4_VGA:
        return "VGA";
      case MovieQualityId.MP4_SLOW:
        return "SLOW";
      case MovieQualityId.MP4_SSLOW:
        return "SSLOW";
      case MovieQualityId.MP4_HS120:
        return "HS120";
      case MovieQualityId.MP4_HS100:
        return "HS100";
      case MovieQualityId.MP4_HS240:
        return "HS240";
      case MovieQualityId.MP4_HS200:
        return "HS200";
      case MovieQualityId.XAVC_S_50M_60p:
        return "50M 60p";
      case MovieQualityId.XAVC_S_50M_50p:
        return "50M 50p";
      case MovieQualityId.XAVC_S_50M_30p:
        return "50M 30p";
      case MovieQualityId.XAVC_S_50M_25p:
        return "50M 25p";
      case MovieQualityId.XAVC_S_50M_24p:
        return "50M 24p";
      case MovieQualityId.XAVC_S_100M_120p:
        return "100M 120p";
      case MovieQualityId.XAVC_S_100M_100p:
        return "100M 100p";
      case MovieQualityId.XAVC_S_60M_120p:
        return "60M 120p";
      case MovieQualityId.XAVC_S_60M_100p:
        return "60M 100p";
      case MovieQualityId.XAVC_S_100M_240p:
        return "100M 240p";
      case MovieQualityId.XAVC_S_100M_200p:
        return "100M 200p";
      case MovieQualityId.XAVC_S_60M_240p:
        return "60M 240p";
      case MovieQualityId.XAVC_S_60M_200p:
        return "60M 200p";
      case MovieQualityId.XAVC_S_100M_30p:
        return "100M 30p";
      case MovieQualityId.XAVC_S_100M_25p:
        return "100M 25p";
      case MovieQualityId.XAVC_S_100M_24p:
        return "100M 24p";
      case MovieQualityId.XAVC_S_60M_30p:
        return "60M 30p";
      case MovieQualityId.XAVC_S_60M_25p:
        return "60M 25p";
      case MovieQualityId.XAVC_S_60M_24p:
        return "60M 24p";
      case MovieQualityId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static MovieQualityId getIdFromUsb(int usbValue) => throw UnsupportedError;

  static MovieQualityId getIdFromWifi(String wifiValue) {
    return MovieQualityId.values.firstWhere(
        (element) => element.wifiValue == wifiValue,
        orElse: () => MovieQualityId.Unknown);
  }
}

class MovieQualityValue extends SettingsValue<MovieQualityId> {
  MovieQualityValue(MovieQualityId id) : super(id);

  @override
  factory MovieQualityValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory MovieQualityValue.fromWifiValue(String wifiValue) =>
      MovieQualityValue(MovieFileFormatIdExtension.getIdFromWifi(wifiValue));

  @override
  String get name => id.name;

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.wifiValue;
}
