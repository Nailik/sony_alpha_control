import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
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

  String get wifiValue {
    return "";
  }
}

AspectRatioId getAspectRatioId(int value) {
  return AspectRatioId.values.firstWhere((element) => element.usbValue == value,
      orElse: () => AspectRatioId.Unknown);
}

class AspectRadioValue extends SettingsValue<AspectRatioId> {
  AspectRadioValue(AspectRatioId id) : super(id);

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}