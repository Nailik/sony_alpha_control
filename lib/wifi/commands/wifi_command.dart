import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version_ids.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';

class WifiCommands {
  //TOdo in json
  static int _id = 0;

  static int get id {
    _id++;
    return _id;
  }
}

class WifiCommand {
  SonyWebApiServiceTypeId service; //for url only

  int id = 0;
  String method;
  WebApiVersionId version;
  List<dynamic> params;

  WifiCommand(this.id, this.method, this.version, this.params, {this.service});

  static WifiCommand createCommand(ApiMethodId method, ItemId apiGroup,
          {SonyWebApiServiceTypeId service = SonyWebApiServiceTypeId.CAMERA,
          WebApiVersionId version =
              WebApiVersionId.V_1_0, //TOp supported version?
          List<dynamic> params = const []}) =>
      WifiCommand(
          0, method.wifiValue + apiGroup.wifiValue.startCap, version, params,
          service: service);

  Future<WifiResponse> send(SonyCameraWifiDevice device,
      {timeout: 10000}) async {
    //url
    //request json
    var url = "${device.getWebApiService(service).url}/${service.wifiValue}";
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
    }on TimeoutException catch (e) {
      print("TimeoutException");
      return WifiResponse(json, "TimeoutException");
      // handle timeout
    } on ClientException catch (error) {
      print("ClientException request");
      return WifiResponse(json, "ClientException");
    }
  }

  logRequestAndResponse(WifiResponse wifiResponse) async {
    var dir =
        Directory("${(await getApplicationSupportDirectory()).path}/wifiLog");
    dir.create(recursive: true);
    var file = File('${dir.path}/${method}_${version}_${params}_.json');
    file.create(recursive: true);
    var text = "$method $version $params \n\n "
        "***************************REQUEST***************************\n\n ${wifiResponse.request}  \n\n "
        "---------------------------RESPONSE--------------------------\n\n  ${wifiResponse.response}  \n\n ";
    if (Platform.isAndroid) {
      await file.writeAsString(text);
    }
  }

  factory WifiCommand.fromJson(Map<String, dynamic> json) => WifiCommand(
        json['id'] as int,
        json['method'] as String,
        WebApiVersionIdExtension.fromWifiValue(json['version'] as String),
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
  String response; //null, error or string
  bool isValid;

  //maybe null
  int errCode;
  int errString;

  WifiResponse(this.request, this.response) {
    var jsonD = jsonDecode(response);
    var result = jsonD["result"];
    if (result != null && result is List && result.isNotEmpty) {
      isValid = result[0] == 0;
      return;
    }
    var error = jsonD["error"];
    if (error != null) {
      isValid = false;
      errCode = error[0];
      errString = error[1];
      return;
    }

    isValid = true;
  }
}
/*
0, "OK"
1, "Any"
2, "Timeout"
3, "Illegal Argument"
4, "Illegal Data Format"
5, "Illegal Request"
6, "Illegal Response"
7, "Illegal State"
8, "Illegal Type"
9, "Index Out Of Bounds"
10, "No Such Element"
11, "No Such Field"
12, "No Such Method"
13, "Null Pointer"
14, "Unsupported Version"
15, "Unsupported Operation"
40400, "Shooting fail"
40401, "Camera Not Ready"
40402, "Already Running Polling Api"
40403, "Still Capturing Not Finished"
41003, "Some content could not be deleted"
401, "Unauthorized"
403, "Forbidden"
404, "Not Found"
406, "Not Acceptable"
413, "Request Entity Too Large"
414, "Request-URI Too Long"
501, "Not Implemented"
503, "Service Unavailable"
 */