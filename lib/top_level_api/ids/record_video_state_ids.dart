import 'package:sonyalphacontrol/top_level_api/api/logger.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';

enum RecordVideoStateId { Stopped, Recording, UnableToRecord, Unknown }

extension RecordVideoStateIdExtension on RecordVideoStateId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case RecordVideoStateId.Stopped:
        return 0;
      case RecordVideoStateId.Recording:
        return 1;
      case RecordVideoStateId.UnableToRecord:
        return 2;
      case RecordVideoStateId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue => throw UnimplementedError;

  static RecordVideoStateId getIdFromUsb(int usbValue) =>
      RecordVideoStateId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(RecordVideoStateId, usbValue);
        return RecordVideoStateId.Unknown;
      });

  static RecordVideoStateId getIdFromWifi(String wifiValue) =>
      RecordVideoStateId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(RecordVideoStateId, wifiValue);
        return RecordVideoStateId.Unknown;
      });
}

class RecordVideoStateValue extends SettingsValue<RecordVideoStateId> {
  RecordVideoStateValue(RecordVideoStateId id) : super(id);

  @override
  factory RecordVideoStateValue.fromUSBValue(int usbValue) =>
      RecordVideoStateValue(RecordVideoStateIdExtension.getIdFromUsb(usbValue));

  @override
  factory RecordVideoStateValue.fromWifiValue(String wifiValue) =>
      RecordVideoStateValue(
          RecordVideoStateIdExtension.getIdFromWifi(wifiValue));

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
