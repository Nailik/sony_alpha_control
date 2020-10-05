import 'file:///C:/Users/kilia/CloudStation/Dokumente/Projects/sony_alpha_control/lib/top_level_api/ids/web_api_version.dart';

class CameraWebApiService {
  String type;
  String url;
  String accessType;
  List<WebApiVersionId> supportedVersions;

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
