import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_usb/Response.dart';
import 'package:flutter_usb/UsbDevice.dart';
import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/test_ui/test_page.dart';
import 'package:sonyalphacontrol/top_level_api/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/sony_camera_usb_device.dart';

import 'commands.dart';

class Downloader {
  static SonyCameraDevice device;

  static Future<List<CameraImage>> download() async {
    fetchPhotos((device as SonyCameraUsbDevice).device.toJson());
    /*
    var result = await FlutterIsolate.spawn(fetchPhotos, (device as SonyCameraUsbDevice).device.toJson());
    print(result);
    */
    return null;
    //  return compute(fetchPhotos, (device as SonyCameraUsbDevice).device.toJson());
  }
}

//TODO pass sony camera device as json?
Future<List<CameraImage>> fetchPhotos(Map<String, dynamic> deviceJson) async {
  SonyCameraUsbDevice device =
      SonyCameraUsbDevice(UsbDevice.fromJson(deviceJson));
  //wait until available
  //  sleep(Duration(milliseconds: 100));

  //wait until available TODO maybe we get an event
  await device.updateSettings();
  //   FlutterUsb.disableLogger();
  var photoAvailable = await device.api.getPhotoAvailable();
  print(photoAvailable);

  int d = 0;
  sleep(Duration(milliseconds: 500));

  while (!photoAvailable) {
    if (d >= 5) {
      print("Could not get image available: $photoAvailable");
      return null;
    }
    sleep(Duration(milliseconds: 500));
    await device.updateSettings();
    photoAvailable = await device.api.getPhotoAvailable();
    print(photoAvailable);
    d++;
  }
  //   FlutterUsb.enableLogger(maxLogLengthNew: 30);

  if (d >= 5) {
    print("Could not get image2 available: $photoAvailable");
    return null;
  }

  var imageList = List<CameraImage>();
  photoAvailable = await device.api.getPhotoAvailable();
  while (photoAvailable) {
    imageList.add(await getImage(device));
    await device.updateSettings();
    photoAvailable = await device.api.getPhotoAvailable();
    print(photoAvailable);
  }
  return imageList;
}

Future<CameraImage> getImage(SonyCameraDevice device,
    {bool liveView = false, String filePath}) async {
  var request = await device.api.requestPhotoAvailable();
  print(request);

  var millis = new DateTime.now().millisecondsSinceEpoch;

  print("staGetImage $millis");
  Response response = await Commands.getImageCommand(liveView, false,
          imageSizeInBytes: request.size)
      .send();

  print("endGetImage ${new DateTime.now().millisecondsSinceEpoch - millis}");
  // TODO if (!response.isValidResponse()) {
  //     print("getImageCommand2 Invalid");
  //   return null;
  //  }

  var buffer = response.inData.toByteList().buffer;
  var bytes = buffer.asByteData();

  if (liveView) {
    int unkBufferSize = bytes.getUint32(30, Endian.little);
    int liveViewBufferSize = bytes.getUint32(34, Endian.little);
    var unkBuff = ByteData.view(buffer, 38, unkBufferSize - 8);
    var start = 38 + unkBufferSize - 8;
    return CameraImage(
        request.name, response.inData.toByteList().sublist(start));
  } else {
    Uint8List data = response.inData.toByteList().sublist(30);
    var file;
    if (filePath != null) {
      file =
          new File("${TestsPageState.path.value.toString()}\\${request.name}");
      file.writeAsBytes(data);
    }
    return CameraImage(request.name, data, file: file);
  }
}
