class UsbDevice {
  String name;
  String description;
  String bstr;

  UsbDevice(this.name, this.description, this.bstr);

  /*
   * Json to Location object
   */
  factory UsbDevice.fromJson(Map<String, dynamic> json) => UsbDevice(
        json['name'] as String,
        json['description'] as String,
        json['bstr'] as String,
      );

  /*
   * Location object to json
   */
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'description': description,
        'bstr': bstr,
      };
}
