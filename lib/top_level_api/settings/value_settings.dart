//a set function is like "fmode" you have available settings and choose one
import 'package:flutter/material.dart';

abstract class ValueSettings<T extends Value> extends ChangeNotifier {
  Future<bool> setValue(T newValue);

  Future<T> get value;

  List<T> available = new List();
  List<T> supported = new List();
}

abstract class Value {
  int usbValue;
  String wifiValue;
  var alternativeUsbValue;

  Value(this.usbValue, this.wifiValue);

  String toReadableValue();
}

class SelfTimerValue extends Value {
  SelfTimerValue(int usbValue, String wifiValue) : super(usbValue, wifiValue);

  @override
  String toReadableValue() {
    // TODO: implement toReadableValue
    throw UnimplementedError();
  }
}
