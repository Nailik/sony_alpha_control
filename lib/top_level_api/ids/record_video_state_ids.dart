enum RecordVideoStateId { Stopped, Recording, UnableToRecord, Unknown }

extension RecordVideoStateIdExtension on RecordVideoStateId {
  String get name => toString().split('.')[1];

  int get value {
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
}

RecordVideoStateId getRecordVideoStateId(int value) {
  return RecordVideoStateId.values.firstWhere(
          (element) => element.value == value,
      orElse: () => RecordVideoStateId.Unknown);
}

class RecordVideoStateValue extends SettingsValue<RecordVideoStateId> {
  RecordVideoStateValue(RecordVideoStateId id) : super(id);

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}