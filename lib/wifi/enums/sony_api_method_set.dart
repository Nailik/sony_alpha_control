import 'package:json_annotation/json_annotation.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';

@JsonSerializable()
class SonyApiMethodSet {
  List<WebApiMethod> webApiMethods;

  SonyApiMethodSet(this.webApiMethods);

  factory SonyApiMethodSet.fromJson(Map<String, dynamic> json) =>
      _$SonyApiMethodSetFromJson(json);

  Map<String, dynamic> toJson() => _$SonyApiMethodSetToJson(this);
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
      _$WebApiMethodFromJson(json);

  Map<String, dynamic> toJson() => _$WebApiMethodToJson(this);
}
