//a set function is like "fmode" you have available settings and choose one
import 'package:flutter/material.dart';

class SettingsItem<T> extends ChangeNotifier {
  T value;

  List<T> available = new List();
  List<T> supported = new List();

  SettingsItem(this.value);
}