import 'package:json_annotation/json_annotation.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';

part 'sony_api_method_set.g.dart';

@JsonSerializable()
class SonyApiMethodSet {
  List<WebApiMethod> webApiMethods;
}

class WebApiMethod {
  SonyWebApiMethod apiName;
  List<String> parameterTypes;
  List<String> responseTypes;
  String version;

  @override
  String toString() =>
      "apiName: $apiName version: $version \n parameterTypes: \n $parameterTypes \n responseTypes: \n $responseTypes";
}

