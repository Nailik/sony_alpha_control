//a set function is like "fmode" you have available settings and choose one

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';

//TODO functions within this to update items when function is available ************ (NEXT)

//TODO settingsItem and info item

//TODO speichern welche methoden möglich sind für dieses "settingsid" item
//TODO für wifi available apilist nutzen, für usb nur ob diese funktion implementiert ist
//TODO methoden beim erstellen hinzufügen?

//TODO stillsize(usb) - size and aspect ratio (wifi)
//TODO drivemode cont and timer (usb) - single on wifi (different methods) TODO test
//TODO cont shooting on wifi - on off via "start cont shooting" (bracket not wupporte?)
//TODO cont shooting speed and state together in usb, different in wifi

//TODO zusammengefasstes "teilen" auch in usb -> man wählt das eine aus,

class SettingsItem<T extends Value?> extends ChangeNotifier {
  final ItemId itemId;

  T? get value => _value;
  T? _value;

  List<T> get available => _available;
  List<T> _available = new List.unmodifiable({});

  List<T> get supported => _supported;
  List<T> _supported = new List.unmodifiable({});

  List<ApiMethodId> get supportedMethods =>
      new List.unmodifiable({}); //TODO setup this

  //not different setter to not notify layout changes too often when multiple values are updated at the same time one after another
  updateItem(T newValue, List<T> newAvailable, List<T> newSupported) {
    if (_value != newValue ||
        !const DeepCollectionEquality().equals(_available, newAvailable) ||
        !const DeepCollectionEquality().equals(_supported, newSupported)) {
      _value = newValue;
      _available = new List.unmodifiable(newAvailable);
      _supported = new List.unmodifiable(newSupported);
      notifyListeners();
    }
  }

  updateCurrentItem(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  SettingsItem(this.itemId);

  bool hasSubValue() {
    return (itemId == ItemId.FocusAreaSpot ||
        itemId == ItemId.FocusMagnifierPosition ||
        itemId == ItemId.ShutterSpeed);
  }

  createListFromWifiJson(List<dynamic> list) =>
      list.map<T?>((e) => Value.fromWifi(itemId, e) as T?).toList();
}

class InfoItem<T extends Value?> extends ChangeNotifier {
  final ItemId itemId;

  T? get value => _value;
  T? _value;

  updateItem(T newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  InfoItem(this.itemId);

  createListFromWifiJson(List<dynamic> list) =>
      list.map<T?>((e) => Value.fromWifi(itemId, e) as T?).toList();
}

class ListInfoItem<T extends Value> extends ChangeNotifier {
  final ItemId itemId;

  List<T> get values => _value;
  List<T> _value = new List.unmodifiable({});

  updateItem(List<T> newValue) {
    if (_value != newValue) {
      _value = newValue;
      notifyListeners();
    }
  }

  ListInfoItem(this.itemId);

  createListFromWifiJson(List<dynamic> list) =>
      list.map<T>((e) => Value.fromWifi(itemId, e) as T).toList();
}
