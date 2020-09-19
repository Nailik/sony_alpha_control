import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum LiveViewSizeId { L, M, Unknown }

extension LiveViewSizeIdExtension on LiveViewSizeId {
  String get name => toString().split('.')[1];

  String get wifiValue {
    switch (this) {
      case LiveViewSizeId.L:
        return "L";
      case LiveViewSizeId.M:
        return "M";
      case LiveViewSizeId.Unknown:
        return "Unknown";
      default:
        return "Unsupported";
    }
  }

  static LiveViewSizeId getIdFromWifi(String wifiValue) => LiveViewSizeId.values
      .firstWhere((element) => element.wifiValue == wifiValue,
      orElse: () => LiveViewSizeId.Unknown);
}

class LiveViewSizeValue extends SettingsValue<LiveViewSizeId> {
  LiveViewSizeValue(LiveViewSizeId id) : super(id);

  @override
  factory LiveViewSizeValue.fromUSBValue(int usbValue) => throw UnimplementedError;

  @override
  factory LiveViewSizeValue.fromWifiValue(String wifiValue) =>
      LiveViewSizeValue(LiveViewSizeIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => throw UnimplementedError;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
