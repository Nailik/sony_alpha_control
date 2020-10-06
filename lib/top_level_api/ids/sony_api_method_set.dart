import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version.dart';

class WebApiMethod {
  SonyWebApiMethodId apiName;
  List<String> parameterTypes;
  List<String> responseTypes;
  WebApiVersionId version;

  WebApiMethod(
      this.apiName, this.parameterTypes, this.responseTypes, this.version);

  @override
  String toString() =>
      "apiName: $apiName version: $version \n parameterTypes: \n $parameterTypes \n responseTypes: \n $responseTypes";
}

class WebApiMethodValue extends SettingsValue<WebApiMethod> {
  WebApiMethodValue(WebApiMethod id) : super(id);

  @override
  factory WebApiMethodValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory WebApiMethodValue.fromWifiValue(String wifiValue) {
    var jsonD = jsonDecode(wifiValue);
    return WebApiMethodValue(WebApiMethod(
        SonyWebApiMethodId.values
            .firstWhere((element) => jsonD[0].startsWith(element.wifiValue)),
        (jsonD[1] as List)?.map((e) => e as String)?.toList(),
        (jsonD[2] as List)?.map((e) => e as String)?.toList(),
        WebApiVersionIdExtension.fromWifiValue(jsonD[3])));
  }

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.toString();

  @override
  String get name => id.toString();
}
