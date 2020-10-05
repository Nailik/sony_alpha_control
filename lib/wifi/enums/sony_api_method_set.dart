import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/ids/web_api_version.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';

class WebApiMethod {
  SonyWebApiMethod apiName;
  List<String> parameterTypes;
  List<String> responseTypes;
  WebApiVersionId version;

  WebApiMethod(
      this.apiName, this.parameterTypes, this.responseTypes, this.version);

  @override
  String toString() =>
      "apiName: $apiName version: $version \n parameterTypes: \n $parameterTypes \n responseTypes: \n $responseTypes";

  factory WebApiMethod.fromJson(List<dynamic> json) => WebApiMethod(
        const SonyWebApiMethodConverter().fromJson(json[0]),
        (json[1] as List)?.map((e) => e as String)?.toList(),
        (json[2] as List)?.map((e) => e as String)?.toList(),
        WebApiVersionIdExtension.fromWifiValue(json[3]),
      );

  List<dynamic> toJson() => <String>[
        const SonyWebApiMethodConverter().toJson(apiName),
        jsonEncode(parameterTypes),
        jsonEncode(responseTypes),
        jsonEncode(version.wifiValue),
      ];
}
