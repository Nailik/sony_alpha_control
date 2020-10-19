import 'package:sonyalphacontrol/wifi/xml/spec_version.dart';
import 'package:sonyalphacontrol/wifi/xml/wifi_camera_xml.dart';

class Root {
  SpecVersion specVersion;
  WifiCameraXML device;

  Root(this.specVersion, this.device);

  factory Root.fromJson(Map<String, dynamic> json) => Root(
        json['specVersion'] == null
            ? null
            : SpecVersion.fromJson(json['specVersion'] as Map<String, dynamic>),
        json['device'] == null
            ? null
            : WifiCameraXML.fromJson(json['device'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'specVersion': this.specVersion,
        'device': this.device,
      };
}

class SpecVersion {
  String major;
  String minor;

  SpecVersion(this.major, this.minor);

  factory SpecVersion.fromJson(Map<String, dynamic> json) => SpecVersion(
    json['major'] as String,
    json['minor'] as String,
  );

  Map<String, dynamic> toJson() => <String, dynamic>{
    'major': this.major,
    'minor': this.minor,
  };
}
