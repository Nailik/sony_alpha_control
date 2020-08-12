import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';

class CameraWebApiService {
  String type;
  String url;
  String accessType;
  List<WebApiVersion> supportedVersions;

  get maxVersion =>
      supportedVersions.reduce((x, y) => x.index > y.index ? x : y);

  CameraWebApiService(this.type, this.url, this.accessType);

  factory CameraWebApiService.fromJson(Map<String, dynamic> json) =>
      CameraWebApiService(
        json['av:X_ScalarWebAPI_ServiceType'] as String,
        json['av:X_ScalarWebAPI_ActionList_URL'] as String,
        json['av:X_ScalarWebAPI_AccessType'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'av:X_ScalarWebAPI_ServiceType': this.type,
        'av:X_ScalarWebAPI_ActionList_URL': this.url,
        'av:X_ScalarWebAPI_AccessType': this.accessType,
      };
}
