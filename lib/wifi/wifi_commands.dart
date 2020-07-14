import 'package:http/http.dart' as http;
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_service_type.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';

class WifiCommands {
  //TOdo in json
}

class WifiCommand {

  SonyWebApiMethod method; //TODO set, get, enable, disable, cancel?
  SonyWebApiServiceType service;
  ApiGroupType apiGroup;
  WebApiVersion apiVersion;
  List<dynamic> params;

  //TODO data
  WifiCommand(this.method, this.service, this.apiGroup, this.apiVersion, this.params);

  String createJson(){

  }


  Future<WifiResponse> send() async {
    //url
    //request json
    createJson();

    final response =
        await http.post('https://jsonplaceholder.typicode.com/albums/1');
    return WifiResponse();
  }
}

class WifiResponse {}
