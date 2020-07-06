import 'dart:typed_data';

class CameraImage{

  String name;
  Uint8List data;

  CameraImage(this.name, this.data);

}

class CameraImageRequest{

  bool available;
  int type;
  int size;

  CameraImageRequest(this.available, this.type, this.size);

  @override
  String toString() {
    // TODO: implement toString
    return "CameraImageRequest $available type $type size $size";
  }
}