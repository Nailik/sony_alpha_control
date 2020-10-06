import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version.dart';

class WebApiMethod {
  SonyWebApiServiceTypeId serviceTypeId;
  SonyWebApiMethodId apiName;

  SettingsId settingsId;
  List<String> parameterTypes;
  List<String> responseTypes;
  WebApiVersionId version;

  WebApiMethod(this.apiName, this.settingsId, this.parameterTypes,
      this.responseTypes, this.version);

  @override
  String toString() =>
      "apiName: $apiName settingsId: $settingsId version: $version \n parameterTypes: \n $parameterTypes \n responseTypes: \n $responseTypes";
}

class WebApiMethodValue extends SettingsValue<WebApiMethod> {
  WebApiMethodValue(WebApiMethod id) : super(id);

  @override
  factory WebApiMethodValue.fromUSBValue(int usbValue) =>
      throw UnsupportedError;

  @override
  factory WebApiMethodValue.fromWifiValue(dynamic wifiValue) {
    var methodId = SonyWebApiMethodId.values
        .firstWhere((element) => wifiValue[0].startsWith(element.wifiValue));
    return WebApiMethodValue(WebApiMethod(
        methodId,
        SettingsIdExtension.getIdFromWifi(
            (wifiValue[0].replaceFirst(methodId.wifiValue, "") as String)
                .startLow),
        (wifiValue[1] as List)?.map((e) => e as String)?.toList(),
        (wifiValue[2] as List)?.map((e) => e as String)?.toList(),
        WebApiVersionIdExtension.fromWifiValue(wifiValue[3])));
  }

  @override
  int get usbValue => throw UnsupportedError;

  @override
  String get wifiValue => id.toString();

  @override
  String get name => id.toString();
}
