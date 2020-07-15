import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_service_type.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';
import 'package:sonyalphacontrol/wifi/sony_camera_wifi_device.dart';

part 'wifi_commands.g.dart';

class WifiCommands {
  //TOdo in json
  static int _id = 0;

  static int get id {
    _id++;
    return _id;
  }
}

@WebApiVersionConverter()
@JsonSerializable()
class WifiCommand {
  @JsonKey(ignore: true)
  SonyWebApiServiceType service; //for url only

  int id = 0;
  String method;
  WebApiVersion version;
  List<dynamic> params;

  WifiCommand(this.id, this.method, this.version, this.params, {this.service});

  static WifiCommand createCommand(SonyWebApiMethod method, SettingsId apiGroup,
          service, WebApiVersion version, List<dynamic> params) =>
      WifiCommand(
          0, method.wifiValue + apiGroup.wifiValue.startCap, version, params, service: service);

  //{"id":7,"method":"getVersions","params":[],"version":"1.0"}
  Future<WifiResponse> send(SonyCameraWifiDevice device) async {
    //url
    //request json
    var url =
        "${device.findCameraWebAPiService(service).url}/${service.wifiValue}";
    id = WifiCommands.id; //update id right before creating json and sending
    var json = jsonEncode(this);

    final response = await http.post(url, body: json);
    print(response.body);
    return WifiResponse();
  }

  factory WifiCommand.fromJson(Map<String, dynamic> json) =>
      _$WifiCommandFromJson(json);

  Map<String, dynamic> toJson() => _$WifiCommandToJson(this);
}

class WifiResponse {}

extension StringExtension on String {
  String get startCap => "${this[0].toUpperCase()}${this.substring(1)}";
}
