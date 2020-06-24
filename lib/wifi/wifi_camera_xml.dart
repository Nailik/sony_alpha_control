import 'package:json_annotation/json_annotation.dart';

part 'wifi_camera_xml.g.dart';

@JsonSerializable()
class Root {
  SpecVersion specVersion;
  WifiCameraXML device;

  Root(this.specVersion, this.device);

  /*
   * Json to Location object
   */
  factory Root.fromJson(Map<String, dynamic> json) =>
      _$RootFromJson(json);

  /*
   * Location object to json
   */
  Map<String, dynamic> toJson() => _$RootToJson(this);
}


@JsonSerializable()
class SpecVersion {
  int major;
  int minor;

  SpecVersion(this.major, this.minor);

  /*
   * Json to Location object
   */
  factory SpecVersion.fromJson(Map<String, dynamic> json) =>
      _$SpecVersionFromJson(json);

  /*
   * Location object to json
   */
  Map<String, dynamic> toJson() => _$SpecVersionToJson(this);
}

@JsonSerializable()
class WifiCameraXML {
  String deviceType;
  String friendlyName;
  String manufacturer;
  String manufacturerURL;
  String modelDescription;
  String modelName;
  String modelUrl;
  String UDN;
  String standardCDS;
  String photoRoot;
  String liveViewUrl;

  List<CameraService> serviceListNode;
  @JsonKey(name: 'av:X_ScalarWebAPI_DeviceInfo')
  List<CameraWebApi> scalarWebApiDeviceInfo;

  WifiCameraXML(this.deviceType,
      this.friendlyName,
      this.manufacturer,
      this.manufacturerURL,
      this.modelDescription,
      this.modelName,
      this.modelUrl,
      this.UDN,
      this.standardCDS,
      this.photoRoot,
      this.liveViewUrl,
      this.serviceListNode);

  /*
   * Json to Location object
   */
  factory WifiCameraXML.fromJson(Map<String, dynamic> json) =>
      _$WifiCameraXMLFromJson(json);

  /*
   * Location object to json
   */
  Map<String, dynamic> toJson() => _$WifiCameraXMLToJson(this);

}

@JsonSerializable()
class CameraService {
  String serviceType;
  String serviceId;
  String SCPDURL;
  String controlURL;
  String eventSubURL;

  CameraService(this.serviceType, this.serviceId, this.SCPDURL, this.controlURL,
      this.eventSubURL);

  /*
   * Json to Location object
   */
  factory CameraService.fromJson(Map<String, dynamic> json) =>
      _$CameraServiceFromJson(json);

  /*
   * Location object to json
   */
  Map<String, dynamic> toJson() => _$CameraServiceToJson(this);
}

@JsonSerializable()
class CameraWebApi {
  @JsonKey(name: 'av:X_ScalarWebAPI_Version')
  double version;
  @JsonKey(name: 'av:X_ScalarWebAPI_ServiceList')
  CameraWebApiServiceList serviceList;


  CameraWebApi(this.version, this.serviceList);

  /*
   * Json to Location object
   */
  factory CameraWebApi.fromJson(Map<String, dynamic> json) =>
      _$CameraWebApiFromJson(json);

  /*
   * Location object to json
   */
  Map<String, dynamic> toJson() => _$CameraWebApiToJson(this);
}


@JsonSerializable()
class CameraWebApiServiceList {
  @JsonKey(name: 'av:X_ScalarWebAPI_Service')
  List<CameraWebAPiService> services;

  CameraWebApiServiceList(this.services);

  /*
   * Json to Location object
   */
  factory CameraWebApiServiceList.fromJson(Map<String, dynamic> json) =>
      _$CameraWebApiServiceListFromJson(json);

  /*
   * Location object to json
   */
  Map<String, dynamic> toJson() => _$CameraWebApiServiceListToJson(this);
}

@JsonSerializable()
class CameraWebAPiService {

  @JsonKey(name: 'av:X_ScalarWebAPI_ServiceType')
  String type;
  @JsonKey(name: 'av:X_ScalarWebAPI_ActionList_URL')
  String url;
  @JsonKey(name: 'av:X_ScalarWebAPI_AccessType')
  String accessType;

  CameraWebAPiService(this.type, this.url, this.accessType);

  /*
   * Json to Location object
   */
  factory CameraWebAPiService.fromJson(Map<String, dynamic> json) =>
      _$CameraWebAPiServiceFromJson(json);

  /*
   * Location object to json
   */
  Map<String, dynamic> toJson() => _$CameraWebAPiServiceToJson(this);
}