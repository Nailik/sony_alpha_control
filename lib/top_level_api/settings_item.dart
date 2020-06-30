//a set function is like "fmode" you have available settings and choose one
import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';

class SettingsItem<T> extends ChangeNotifier {
  T value;
  T subValue;
  SettingsId settingsId;

  List<T> available = new List();
  List<T> supported = new List();

  SettingsItem(this.settingsId);

  bool hasSubValue() {
    return (settingsId == SettingsId.FocusAreaSpot ||
        settingsId == SettingsId.FocusMagnifierPosition ||
        settingsId == SettingsId.ShutterSpeed);
  }
}

class Value<T> {
  T value;

  Value(this.value);
}
