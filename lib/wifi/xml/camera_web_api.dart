import 'camera_web_api_service_list.dart';

class CameraWebApi {
  String version;
  CameraWebApiServiceList serviceList;

  CameraWebApi(this.version, this.serviceList);

  factory CameraWebApi.fromJson(Map<String, dynamic> json) => CameraWebApi(
        json['av:X_ScalarWebAPI_Version'] as String,
        json['av:X_ScalarWebAPI_ServiceList'] == null
            ? null
            : CameraWebApiServiceList.fromJson(
                json['av:X_ScalarWebAPI_ServiceList'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'av:X_ScalarWebAPI_Version': this.version,
        'av:X_ScalarWebAPI_ServiceList': this.serviceList,
      };
}
