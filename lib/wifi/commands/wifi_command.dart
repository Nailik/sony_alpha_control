import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
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

  Future<WifiResponse> send(SonyCameraWifiDevice device,
      {timeout: 80000}) async {
    //url
    //request json
    var url = "${device
        .getWebApiService(service)
        .url}/${service.wifiValue}";
    id = WifiCommands.id; //update id right before creating json and sending
    var json = jsonEncode(this);
    try {
      final response = await http
          .post(url, body: json)
          .timeout(Duration(milliseconds: timeout));
      print("request response");

      var wifiResponse = WifiResponse(json, response.body);
      if (SonyApi.analyze) {
        //save this
        logRequestAndResponse(wifiResponse);
      }

      return wifiResponse;
    } on ClientException catch (error) {
      print("ClientException request");
      return WifiResponse("", "");
    }
  }

  logRequestAndResponse(WifiResponse wifiResponse) async {
    var dir = Directory(
        "${(await getApplicationSupportDirectory()).path}/wifiLog");
    dir.create(recursive: true);
    var file = File('${dir.path}/${method}_${version}_${params}_.json');
    file.create(recursive: true);
    var text = "$method $version $params \n\n "
        "***************************REQUEST***************************\n\n ${wifiResponse
        .request}  \n\n "
        "---------------------------RESPONSE--------------------------\n\n  ${wifiResponse
        .response}  \n\n ";
    await file.writeAsString(text);
  }

  factory WifiCommand.fromJson(Map<String, dynamic> json) =>
      WifiCommand(
        json['id'] as int,
        json['method'] as String,
        WebApiVersionExtension.fromWifiValue(json['version'] as String),
        json['params'] as List,
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
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

  get isValid => jsonDecode(response)["result"][0] == 0; //TODO what error code? illegal argument/ unsupported etc
}
