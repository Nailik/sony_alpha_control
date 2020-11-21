import 'dart:io';
import 'dart:typed_data';

/*import 'package:flutter_usb/Response.dart';
import 'package:flutter_usb/UsbDevice.dart';*/
//import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/test_ui/test_page.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/device/sony_camera_usb_device.dart';

import 'usb_commands.dart';

class Downloader {
  static SonyCameraDevice? device;

  static Future<List<CameraImage>?> download() async {
   /* fetchPhotos((device as SonyCameraUsbDevice).device.toJson());*/
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
 /* SonyCameraUsbDevice device =
      SonyCameraUsbDevice(UsbDevice.fromJson(deviceJson));
  //wait until available
  //  sleep(Duration(milliseconds: 100));

  //wait until available TODO maybe we get an event
  await device.updateSettings();
  //   FlutterUsb.disableLogger();
  var photoAvailable = await device.api.getPhotoAvailable();
  print(photoAvailable);

  int d = 0;
  await Future.delayed(Duration(milliseconds: 500));
  // sleep(Duration(milliseconds: 500));

  while (!photoAvailable) {
    if (d >= 5) {
      print("Could not get image available: $photoAvailable");
      return null;
    }
    await Future.delayed(Duration(milliseconds: 500));
    //sleep(Duration(milliseconds: 500));
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

  return imageList;*/
}

Future<CameraImage?> getImage(SonyCameraDevice device,
    {bool liveView = false, String? filePath}) async {
/*
  print("requestPhotoAvailable");
  var request = await device.api.requestPhotoAvailable(liveView: liveView);
  print(request);

  var millis = new DateTime.now().millisecondsSinceEpoch;

  print("staGetImage $millis");
//307200
*/

  var mills = DateTime.now().millisecondsSinceEpoch;
 /* Response response = await UsbCommands.getImageCommand(liveView, false,
          imageSizeInBytes: 307200)
      .send();*/

  print("Frame Response ${DateTime.now().millisecondsSinceEpoch - mills}");
  // TODO if (!response.isValidResponse()) {
  //     print("getImageCommand2 Invalid");
  //   return null;
  //  }

  dynamic bytelist = null;// response.inData.toByteList();
  var buffer = bytelist.buffer;
  var bytes = buffer.asByteData();

  //128 57 00 00 //16

  //{01 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  // 00 00 00 00 00 00 00 00 00 00 01 00 01 38 00 00 00 B0 04 00 00 00
  // 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  // 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 0D 44 00 53 00 43
  // 00 30 00 39 00 39 00 39 00 39 00 2E 00 4A 00 50 00 47 00 00 00 00
  // 00 00}
  int offset = 30; //TODO maybe only wia offset?
  if (Platform.isAndroid) {
    offset = 12;
  }

  if (liveView) {
    try {
      print("Frame liveView ${DateTime.now().millisecondsSinceEpoch - mills}");
      if (bytes.lengthInBytes < offset + 4) {
        print("Frame empty");
        return null;
      }
      int? unkBufferSize = bytes.getUint32(offset, Endian.little);
      offset += 4;
      if (unkBufferSize == 0) {
        print("Frame empty");
        return null;
      }
      print(
          "Frame unkBufferSize ${DateTime.now().millisecondsSinceEpoch - mills}  size: ${bytes.lengthInBytes} offset: $offset unkBufferSize. $unkBufferSize ");
      int? liveViewBufferSize = bytes.getUint32(offset, Endian.little);
      offset += 4;
      print(
          "Frame liveViewBufferSize ${DateTime.now().millisecondsSinceEpoch - mills}  size: ${bytes.lengthInBytes} offset: $offset unkBufferSize. $unkBufferSize ");

      var unkBuff = ByteData.view(buffer, offset, unkBufferSize! - 8);
      print("Frame unkBuff ${DateTime.now().millisecondsSinceEpoch - mills}");
      var start = offset + unkBufferSize - 8;
      print(
          "Frame start $start ${DateTime.now().millisecondsSinceEpoch - mills} end: ${bytelist.sublist(bytelist.length - 20)} ind of 0xFF ${bytelist.lastIndexOf(0xFF)} 0xD9  ${bytelist.lastIndexOf(0xD9)}");
      return CameraImage("", bytelist.sublist(start));
    } on Exception catch (e) {
      print("Frame error $e");
      return null;
    }
  } else {
    Uint8List? data = bytelist.sublist(offset);
    var file;
    if (filePath != null) {
      file = new File(
          "${TestsPageState.path.value.toString()}\\${"request.name"}");
      file.writeAsBytes(data);
    }
    return CameraImage("request.name", data, file: file);
  }
}
