import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

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

  String get wifiValue => "";
}

OpCodeId getOpCodeId(int usbValue) {
  return OpCodeId.values.firstWhere((element) => element.usbValue == usbValue,
      orElse: () => OpCodeId.Unknown);
}

class OpCodeValue extends SettingsValue<OpCodeId> {
  OpCodeValue(OpCodeId id) : super(id);

  @override
  factory OpCodeValue.fromUSBValue(int usbValue) {
    return OpCodeValue(getOpCodeId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
