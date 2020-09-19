import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';

abstract class CameraSettings extends ChangeNotifier {
  List<SettingsItem> _settings = new List();

  Future<bool> update();

  //TODO getter future, da wenn current value "leer" evtl nochmal requesten? (vtl einstellbar falls nie ?)
  //TODO update mit boolean request -> falls immer geupdttet werden soll
  SettingsItem getItem(SettingsId settingsId) {
    return _settings.firstWhere((element) => element.settingsId == settingsId,
        orElse: () => null);
  }

  addItem(SettingsItem settingsItem){
    _settings.add(settingsItem);
  }
}
