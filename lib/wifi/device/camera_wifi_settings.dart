import 'dart:collection';
import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';

class CameraWifiSettings extends CameraSettings {
  final SonyCameraWifiDevice sonyCameraWifiDevice;

  CameraWifiSettings(this.sonyCameraWifiDevice);

  ListInfoItem updateListInfoItem(ListInfoItem listInfoItem, String json,
      {WebApiVersionId webApiVersion}) {
    var jsonD = jsonDecode(json);
    var list = jsonD["result"];
    switch (listInfoItem.itemId) {
      case ItemId.Versions:
        listInfoItem.updateItem(listInfoItem.createListFromWifiJson(list[0] as List));
        break;
      case ItemId.StorageInformation:
        //TODO multiple storage items
        List lists = (list[0][0] as LinkedHashMap).entries.map((e) => "${e.key}:${e.value}").toList();
        listInfoItem.updateItem(listInfoItem.createListFromWifiJson(lists));
        break;
      case ItemId.MethodTypes:
        list = jsonD["results"];
        var itemsList = listInfoItem.createListFromWifiJson(list as List);
        List<WebApiMethodValue> newList = new List<WebApiMethodValue>.from(listInfoItem.values);

        itemsList.forEach((element) {
          if (!listInfoItem.values.contains(element)) {
            newList.add(element);
          }
        });

        listInfoItem.updateItem(newList);
        break;
      case ItemId.AvailableSettings: //TODO for now only strings
        listInfoItem.updateItem(listInfoItem.createListFromWifiJson(list));
        break;
      case ItemId.ApplicationInfo:
      default:
        listInfoItem.updateItem(listInfoItem.createListFromWifiJson(list));
        break;
    }
    return listInfoItem;
  }

  @override
  Future<bool> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
