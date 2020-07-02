import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

enum AspectRatioId { Ar3_2, Ar16_9, Unknown }

extension AspectRatioIdExtension on AspectRatioId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case AspectRatioId.Ar3_2:
        return 1;
      case AspectRatioId.Ar16_9:
        return 2;
      case AspectRatioId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => "";
}

AspectRatioId getAspectRatioId(int usbValue) {
  return AspectRatioId.values.firstWhere(
      (element) => element.usbValue == usbValue,
      orElse: () => AspectRatioId.Unknown);
}

class AspectRatioValue extends SettingsValue<AspectRatioId> {
  AspectRatioValue(AspectRatioId id) : super(id);

  @override
  factory AspectRatioValue.fromUSBValue(int usbValue) {
    return AspectRatioValue(getAspectRatioId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
