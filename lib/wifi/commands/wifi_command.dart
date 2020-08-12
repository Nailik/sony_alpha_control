import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_service_type.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';

class WifiCommands {
  //TOdo in json
  static int _id = 0;

  static int get id {
    _id++;
    return _id;
  }
}

class WifiCommand {
  SonyWebApiServiceType service; //for url only

  int id = 0;
  String method;
  WebApiVersion version;
  List<dynamic> params;

  WifiCommand(this.id, this.method, this.version, this.params, {this.service});

  static WifiCommand createCommand(SonyWebApiMethod method, SettingsId apiGroup,
          {SonyWebApiServiceType service = SonyWebApiServiceType.CAMERA,
          WebApiVersion version = WebApiVersion.V_1_0, //TOp supported version?
          List<dynamic> params = const []}) =>
      WifiCommand(
          0, method.wifiValue + apiGroup.wifiValue.startCap, version, params,
          service: service);

  //send for result
  Future<dynamic> sendR(SonyCameraWifiDevice device, {timeout: 80000}) async {
    //url
    //request json
    var url =
        "${device.getWebApiService(service).url}/${service.wifiValue}";
    id = WifiCommands.id; //update id right before creating json and sending
    var json = jsonEncode(this);
    try {
      return await http
          .post(url, body: json)
          .timeout(Duration(milliseconds: timeout));
    } on ClientException catch (error) {
      print("ClientException request $error");
      return null;
    }
  }

  //{"id":7,"method":"getVersions","params":[],"version":"1.0"}
  Future<bool> send(SonyCameraWifiDevice device, {timeout: 80000}) async {
    //url
    //request json
    var url =
        "${device.getWebApiService(service).url}/${service.wifiValue}";
    id = WifiCommands.id; //update id right before creating json and sending
    var json = jsonEncode(this);
    try {
      final response = await http
          .post(url, body: json)
          .timeout(Duration(milliseconds: timeout));
      print("request response");
      return true;
    } on ClientException catch (error) {
      print("ClientException request");
      return false;
    }
  }

  Future<WifiResponse> sendForResponse(SonyCameraWifiDevice device,
      {timeout: 80000}) async {
    //url
    //request json
    var url =
        "${device.getWebApiService(service).url}/${service.wifiValue}";
    id = WifiCommands.id; //update id right before creating json and sending
    var json = jsonEncode(this);
    try {
      final response = await http
          .post(url, body: json)
          .timeout(Duration(milliseconds: timeout));
      print("request response");
      return WifiResponse(json, response.body);
    } on ClientException catch (error) {
      print("ClientException request");
      return WifiResponse("", "");
    }
  }

  factory WifiCommand.fromJson(Map<String, dynamic> json) => WifiCommand(
        json['id'] as int,
        json['method'] as String,
        WebApiVersionExtension.fromWifiValue(json['version'] as String),
        json['params'] as List,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id,
        'method': this.method,
        'version': this.version.wifiValue,
        'params': this.params,
      };
}

class WifiResponse {
  String request;
  String response;

  WifiResponse(this.request, this.response);
}

extension StringExtension on String {
  String get startCap => "${this[0].toUpperCase()}${this.substring(1)}";
}