import 'dart:core';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/camera_function_id.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_api_method_set.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';
import 'package:sonyalphacontrol/wifi/xml/camera_web_api.dart';
import 'package:sonyalphacontrol/wifi/xml/wifi_camera_xml.dart';

import 'camera_wifi_settings.dart';

class SonyCameraWifiDevice extends SonyCameraDevice<CameraWifiSettings> {
  WifiCameraXML? info;

  SonyCameraWifiDevice(String? name, this.info) : super(name);

  @override
  InterfaceType get interfaceType => InterfaceType.Wifi_Interface;

  CameraWebApiService? getWebApiService(SonyWebApiServiceTypeId? service) =>
      info!.scalarWebApiDeviceInfo!.serviceList!.services!
          .firstWhereOrNull((element) => element!.type == service!.wifiValue);

  @override
  CameraWifiSettings createSettings() => CameraWifiSettings(this);

  @override
  bool operator ==(o) => o is SonyCameraWifiDevice && info == o.info;

  @override
  int get hashCode => info.hashCode;

}

class WifiCameraInfo {
  String? usn;
  String uuid;
  String? location;
  String? server;
  String? st;

  WifiCameraInfo(this.usn, this.uuid, this.location, this.server, this.st);

  @override
  String toString() => "usn: $usn \n uuid: $uuid \n location: $location \n server: $server \n st: $st";
}

class WifiCameraFunctionality {
  final SettingsItem<WebApiVersionsValue> webApiVersions;
  final List<WebApiMethod> webApiMethods;
  final Map<ItemId, List<ApiMethodId>>
      availableApiList; //TODO in settings
  final SettingsItem<Value<CameraFunctionId>>
      cameraWebFunctions; //TODO in settings

  WifiCameraFunctionality(this.webApiVersions, this.webApiMethods,
      this.availableApiList, this.cameraWebFunctions);
}
