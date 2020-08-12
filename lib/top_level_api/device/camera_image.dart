import 'dart:io';
import 'dart:typed_data';

class CameraImage {
  String name;
  Uint8List data;
  File file; //file may be null

  CameraImage(this.name, this.data, {this.file});
}

class CameraImageRequest {
  bool available;
  int type; //45313 = ARW, 14337 = JPEG
  int size;
  String name;

  CameraImageRequest(this.available, this.type, this.size, this.name);

  @override
  String toString() {
    // TODO: implement toString
    return "CameraImageRequest $available type $type size $size name $name";
  }
}
