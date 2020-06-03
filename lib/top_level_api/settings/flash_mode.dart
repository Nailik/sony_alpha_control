import 'package:sonyalphacontrol/top_level_api/settings/value_settings.dart';

class FlashModeSettings extends ValueSettings<FlashModeValue> {
  @override
  Future<bool> setValue(FlashModeValue newValue) {
    // TODO: implement setValue
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  Future<FlashModeValue> get value => throw UnimplementedError();

}

class FlashModeValue extends Value{
  FlashModeValue(int usbValue, String wifiValue) : super(usbValue, wifiValue);

  @override
  String toReadableValue() {
    // TODO: implement toReadableValue
    throw UnimplementedError();
  }

}

