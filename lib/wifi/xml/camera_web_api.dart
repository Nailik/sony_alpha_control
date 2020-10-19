import 'package:sonyalphacontrol/top_level_api/ids/web_api_version_ids.dart';

class CameraWebApi {
  String version;
  CameraWebApiServiceList serviceList;

  CameraWebApi(this.version, this.serviceList);

  factory CameraWebApi.fromJson(Map<String, dynamic> json) => CameraWebApi(
        json['av:X_ScalarWebAPI_Version'] as String,
        json['av:X_ScalarWebAPI_ServiceList'] == null
            ? null
            : CameraWebApiServiceList.fromJson(json['av:X_ScalarWebAPI_ServiceList'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'av:X_ScalarWebAPI_Version': this.version,
        'av:X_ScalarWebAPI_ServiceList': this.serviceList,
      };
}

class CameraWebApiServiceList {
  List<CameraWebApiService> services;

  CameraWebApiServiceList(this.services);

  factory CameraWebApiServiceList.fromJson(Map<String, dynamic> json) => CameraWebApiServiceList(
        (json['av:X_ScalarWebAPI_Service'] as List)
            ?.map((e) => e == null ? null : CameraWebApiService.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'av:X_ScalarWebAPI_Service': this.services,
      };
}

class CameraWebApiService {
  String type;
  String url;
  String accessType;
  List<WebApiVersionId> supportedVersions;

  get maxVersion => supportedVersions.reduce((x, y) => x.index > y.index ? x : y);

  CameraWebApiService(this.type, this.url, this.accessType);

  factory CameraWebApiService.fromJson(Map<String, dynamic> json) => CameraWebApiService(
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
