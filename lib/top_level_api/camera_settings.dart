import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/usb/api/settings_item.dart';

abstract class CameraSettings extends ChangeNotifier {

  List<SettingsItem> settings = new List();
  Future<bool> update();

}