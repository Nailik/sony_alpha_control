//a set function is like "fmode" you have available settings and choose one
import 'package:flutter/material.dart';

abstract class SettingsItem<T> extends ChangeNotifier {
  Future<T> get value;

  List<T> available = new List();
  List<T> supported = new List();
}