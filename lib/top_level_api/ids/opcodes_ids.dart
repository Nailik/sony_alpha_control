import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum OpCodeId {
  Connect,

  /// <summary>
  /// The response contains a list of available main/sub settings (just their top_level_api.ids)
  /// </summary>
  SettingsList,

  /// <summary>
  /// A request to change a "main" setting. Watch the response of <see cref="OpCodes.Settings"/> for the change in value.
  /// </summary>
  MainSetting,

  /// <summary>
  /// A request to change a "sub" setting. Watch the response of <see cref="OpCodes.Settings"/> for the change in value.
  /// </summary>
  SubSetting,

  /// <summary>
  /// All of the camera setting values
  /// </summary>
  Settings,

  /// <summary>
  /// Image info for the live view / captured photo
  /// </summary>
  GetImageInfo,

  /// <summary>
  /// Image data for the live view / captured photo
  /// </summary>
  GetImageData,
  Unknown
}

extension OpCodesExtension on OpCodeId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case OpCodeId.Connect:
        return 0x9201;
      case OpCodeId.SettingsList:
        return 0x9202;
      case OpCodeId.MainSetting:
        return 0x9207;
      case OpCodeId.SubSetting:
        return 0x9205;
      case OpCodeId.Settings:
        return 0x9209;
      case OpCodeId.GetImageInfo:
        return 0x1008;
      case OpCodeId.GetImageData:
        return 0x1009;
      case OpCodeId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => throw UnimplementedError;

  static OpCodeId getIdFromUsb(int usbValue) => OpCodeId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(OpCodeId, usbValue);
        return OpCodeId.Unknown;
      });

  static OpCodeId getIdFromWifi(String wifiValue) => OpCodeId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(OpCodeId, wifiValue);
        return OpCodeId.Unknown;
      });
}
