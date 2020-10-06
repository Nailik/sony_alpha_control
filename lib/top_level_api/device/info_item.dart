import 'package:flutter/cupertino.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';

//TODO also settingsId and Info list
class InfoItem<T extends Value> extends ChangeNotifier {
  final ItemId itemId;

  T get value => _value;
  T _value;

  updateItem(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  InfoItem(this.itemId);
}
