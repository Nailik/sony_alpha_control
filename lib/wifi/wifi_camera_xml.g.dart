// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_camera_xml.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Root _$RootFromJson(Map<String, dynamic> json) {
  return Root(
    json['specVersion'] == null
        ? null
        : SpecVersion.fromJson(json['specVersion'] as Map<String, dynamic>),
    json['device'] == null
        ? null
        : WifiCameraXML.fromJson(json['device'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RootToJson(Root instance) => <String, dynamic>{
      'specVersion': instance.specVersion,
      'device': instance.device,
    };

SpecVersion _$SpecVersionFromJson(Map<String, dynamic> json) {
  return SpecVersion(
    json['major'] as String,
    json['minor'] as String,
  );
}

Map<String, dynamic> _$SpecVersionToJson(SpecVersion instance) =>
    <String, dynamic>{
      'major': instance.major,
      'minor': instance.minor,
    };

WifiCameraXML _$WifiCameraXMLFromJson(Map<String, dynamic> json) {
  return WifiCameraXML(
    json['deviceType'] as String,
    json['friendlyName'] as String,
    json['manufacturer'] as String,
    json['manufacturerURL'] as String,
    json['modelDescription'] as String,
    json['modelName'] as String,
    json['modelUrl'] as String,
    json['UDN'] as String,
    json['standardCDS'] as String,
    json['photoRoot'] as String,
    json['liveViewUrl'] as String,
    (json['serviceListNode'] as List)
        ?.map((e) => e == null
            ? null
            : CameraService.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )..scalarWebApiDeviceInfo = json['av:X_ScalarWebAPI_DeviceInfo'] == null
      ? null
      : CameraWebApi.fromJson(
          json['av:X_ScalarWebAPI_DeviceInfo'] as Map<String, dynamic>);
}

Map<String, dynamic> _$WifiCameraXMLToJson(WifiCameraXML instance) =>
    <String, dynamic>{
      'deviceType': instance.deviceType,
      'friendlyName': instance.friendlyName,
      'manufacturer': instance.manufacturer,
      'manufacturerURL': instance.manufacturerURL,
      'modelDescription': instance.modelDescription,
      'modelName': instance.modelName,
      'modelUrl': instance.modelUrl,
      'UDN': instance.UDN,
      'standardCDS': instance.standardCDS,
      'photoRoot': instance.photoRoot,
      'liveViewUrl': instance.liveViewUrl,
      'serviceListNode': instance.serviceListNode,
      'av:X_ScalarWebAPI_DeviceInfo': instance.scalarWebApiDeviceInfo,
    };

CameraService _$CameraServiceFromJson(Map<String, dynamic> json) {
  return CameraService(
    json['serviceType'] as String,
    json['serviceId'] as String,
    json['SCPDURL'] as String,
    json['controlURL'] as String,
    json['eventSubURL'] as String,
  );
}

Map<String, dynamic> _$CameraServiceToJson(CameraService instance) =>
    <String, dynamic>{
      'serviceType': instance.serviceType,
      'serviceId': instance.serviceId,
      'SCPDURL': instance.SCPDURL,
      'controlURL': instance.controlURL,
      'eventSubURL': instance.eventSubURL,
    };

CameraWebApi _$CameraWebApiFromJson(Map<String, dynamic> json) {
  return CameraWebApi(
    json['av:X_ScalarWebAPI_Version'] as String,
    json['av:X_ScalarWebAPI_ServiceList'] == null
        ? null
        : CameraWebApiServiceList.fromJson(
            json['av:X_ScalarWebAPI_ServiceList'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CameraWebApiToJson(CameraWebApi instance) =>
    <String, dynamic>{
      'av:X_ScalarWebAPI_Version': instance.version,
      'av:X_ScalarWebAPI_ServiceList': instance.serviceList,
    };

CameraWebApiServiceList _$CameraWebApiServiceListFromJson(
    Map<String, dynamic> json) {
  return CameraWebApiServiceList(
    (json['av:X_ScalarWebAPI_Service'] as List)
        ?.map((e) => e == null
            ? null
            : CameraWebAPiService.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CameraWebApiServiceListToJson(
        CameraWebApiServiceList instance) =>
    <String, dynamic>{
      'av:X_ScalarWebAPI_Service': instance.services,
    };

CameraWebAPiService _$CameraWebAPiServiceFromJson(Map<String, dynamic> json) {
  return CameraWebAPiService(
    json['av:X_ScalarWebAPI_ServiceType'] as String,
    json['av:X_ScalarWebAPI_ActionList_URL'] as String,
    json['av:X_ScalarWebAPI_AccessType'] as String,
  );
}

Map<String, dynamic> _$CameraWebAPiServiceToJson(
        CameraWebAPiService instance) =>
    <String, dynamic>{
      'av:X_ScalarWebAPI_ServiceType': instance.type,
      'av:X_ScalarWebAPI_ActionList_URL': instance.url,
      'av:X_ScalarWebAPI_AccessType': instance.accessType,
    };
