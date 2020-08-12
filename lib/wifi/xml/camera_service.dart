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
