import 'camera_web_api_service.dart';

class CameraWebApiServiceList {
  List<CameraWebApiService> services;

  CameraWebApiServiceList(this.services);

  factory CameraWebApiServiceList.fromJson(Map<String, dynamic> json) =>
      CameraWebApiServiceList(
        (json['av:X_ScalarWebAPI_Service'] as List)
            ?.map((e) => e == null
                ? null
                : CameraWebApiService.fromJson(e as Map<String, dynamic>))
            ?.toList(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'av:X_ScalarWebAPI_Service': this.services,
      };
}
