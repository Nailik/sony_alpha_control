import 'package:sonyalphacontrol/top_level_api/settings/value_settings.dart';

class FNumberSettings extends ValueSettings<FNumberValue> {
  @override
  Future<bool> setValue(FNumberValue newValue) {
    // TODO: implement setValue
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  Future<Value> get value => throw UnimplementedError();

}

class FNumberValue extends Value{
  FNumberValue(int usbValue, String wifiValue) : super(usbValue, wifiValue);

  @override
  String toReadableValue() {
    // TODO: implement toReadableValue
    throw UnimplementedError();
  }

}

