import 'camera_web_api.dart';

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
  CameraWebApi scalarWebApiDeviceInfo;

  @override
  bool operator ==(o) => o is WifiCameraXML && this.UDN.toString() == o.UDN.toString();

  @override
  int get hashCode => this.UDN.hashCode;

  WifiCameraXML(
      this.deviceType,
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

  factory WifiCameraXML.fromJson(Map<String, dynamic> json) => WifiCameraXML(
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'deviceType': this.deviceType,
        'friendlyName': this.friendlyName,
        'manufacturer': this.manufacturer,
        'manufacturerURL': this.manufacturerURL,
        'modelDescription': this.modelDescription,
        'modelName': this.modelName,
        'modelUrl': this.modelUrl,
        'UDN': this.UDN,
        'standardCDS': this.standardCDS,
        'photoRoot': this.photoRoot,
        'liveViewUrl': this.liveViewUrl,
        'serviceListNode': this.serviceListNode,
        'av:X_ScalarWebAPI_DeviceInfo': this.scalarWebApiDeviceInfo,
      };
}

class CameraService {
  String serviceType;
  String serviceId;
  String SCPDURL;
  String controlURL;
  String eventSubURL;

  CameraService(this.serviceType, this.serviceId, this.SCPDURL, this.controlURL,
      this.eventSubURL);

  factory CameraService.fromJson(Map<String, dynamic> json) => CameraService(
    json['serviceType'] as String,
    json['serviceId'] as String,
    json['SCPDURL'] as String,
    json['controlURL'] as String,
    json['eventSubURL'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'serviceType': this.serviceType,
    'serviceId': this.serviceId,
    'SCPDURL': this.SCPDURL,
    'controlURL': this.controlURL,
    'eventSubURL': this.eventSubURL,
  };
}
