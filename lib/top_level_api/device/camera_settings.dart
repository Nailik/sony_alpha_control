import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';

abstract class CameraSettings extends ChangeNotifier {
  List<SettingsItem> _settings = new List();

  Future<bool> update();

  //TODO getter future, da wenn current value "leer" evtl nochmal requesten? (vtl einstellbar falls nie ?)
  //TODO update mit boolean request -> falls immer geupdttet werden soll
  SettingsItem<T> getItem<T extends SettingsValue>(SettingsId settingsId) {
    var item = _settings.firstWhere(
        (element) => element?.settingsId == settingsId,
        orElse: () => null);
    if (item == null) {
      switch (settingsId) {
        case SettingsId.FNumber:
          item = SettingsItem<DoubleValue>(settingsId);
          break;
        case SettingsId.EV:
          item = SettingsItem<EvValue>(settingsId);
          break;
        case SettingsId.ISO:
          item = SettingsItem<IsoValue>(settingsId);
          break;
        case SettingsId.ShutterSpeed:
          item = SettingsItem<ShutterSpeedValue>(settingsId);
          break;
        case SettingsId.AEL_State:
          item = SettingsItem<BoolValue>(settingsId);
          break;
        case SettingsId.FlashMode:
          item = SettingsItem<FlashModeValue>(settingsId);
          break;
      }
      _settings.add(item);
    }
    return item;
  }

  addItem(SettingsItem settingsItem) {
    _settings.add(settingsItem);
  }
}
