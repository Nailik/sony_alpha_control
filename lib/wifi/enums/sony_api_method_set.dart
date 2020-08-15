import 'package:json_annotation/json_annotation.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';

@JsonSerializable()
class SonyApiMethodSet {
  List<WebApiMethod> webApiMethods;

  SonyApiMethodSet(this.webApiMethods);

  factory SonyApiMethodSet.fromJson(Map<String, dynamic> json) =>  SonyApiMethodSet(
    (json['webApiMethods'] as List)
        ?.map((e) =>
    e == null ? null : WebApiMethod.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );

  Map<String, dynamic> toJson()  =>
      <String, dynamic>{
        'webApiMethods': webApiMethods,
      };
}

@SonyWebApiMethodConverter()
@JsonSerializable()
class WebApiMethod {
  SonyWebApiMethod apiName;
  List<String> parameterTypes;
  List<String> responseTypes;
  String version;

  WebApiMethod(
      this.apiName, this.parameterTypes, this.responseTypes, this.version);

  @override
  String toString() =>
      "apiName: $apiName version: $version \n parameterTypes: \n $parameterTypes \n responseTypes: \n $responseTypes";

  factory WebApiMethod.fromJson(Map<String, dynamic> json) =>
      WebApiMethod(
        const SonyWebApiMethodConverter().fromJson(json['apiName'] as String),
        (json['parameterTypes'] as List)?.map((e) => e as String)?.toList(),
        (json['responseTypes'] as List)?.map((e) => e as String)?.toList(),
        json['version'] as String,
      );

  Map<String, dynamic> toJson() =>  <String, dynamic>{
    'apiName': const SonyWebApiMethodConverter().toJson(apiName),
    'parameterTypes': parameterTypes,
    'responseTypes': responseTypes,
    'version': version,
  };
}
