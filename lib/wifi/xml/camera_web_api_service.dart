class CameraWebAPiService {
  String type;
  String url;
  String accessType;

  CameraWebAPiService(this.type, this.url, this.accessType);

  factory CameraWebAPiService.fromJson(Map<String, dynamic> json) =>
      CameraWebAPiService(
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
