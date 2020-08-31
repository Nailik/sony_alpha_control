import 'dart:convert';

import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';

class WebApiMethod {
  SonyWebApiMethod apiName;
  List<String> parameterTypes;
  List<String> responseTypes;
  WebApiVersion version;

  WebApiMethod(
      this.apiName, this.parameterTypes, this.responseTypes, this.version);

  @override
  String toString() =>
      "apiName: $apiName version: $version \n parameterTypes: \n $parameterTypes \n responseTypes: \n $responseTypes";

  factory WebApiMethod.fromJson(List<dynamic> json) => WebApiMethod(
        const SonyWebApiMethodConverter().fromJson(json[0]),
        (json[1] as List)?.map((e) => e as String)?.toList(),
        (json[2] as List)?.map((e) => e as String)?.toList(),
        const WebApiVersionConverter().fromJson(json[3]),
      );

  List<dynamic> toJson() => <String>[
        const SonyWebApiMethodConverter().toJson(apiName),
        jsonEncode(parameterTypes),
        jsonEncode(responseTypes),
        const WebApiVersionConverter().toJson(version),
      ];
}
