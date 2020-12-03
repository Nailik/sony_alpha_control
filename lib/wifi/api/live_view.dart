import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';

enum PayloadType { Image, FrameInformation, Unknown }

enum Category { Invalid, Contrast_Af, Phase_Detection_Af, Face, Tracking, Unknown }

enum Status { Invalid, Normal, Main, Sub, Focused, Unknown }

enum AdditionalStatus { Invalid, Selected, Large_Frame, Unknown }

class Payload {}

class LiveViewPayload extends Payload {
  final MemoryImage image;

  LiveViewPayload(this.image);
}

class FrameInformationData extends Payload {
  //top left
  final int topX;
  final int topY;

  //bottom right
  final int bottomX;
  final int bottomY;

  final Category category;
  final Status status;
  final AdditionalStatus additionalStatus;

  FrameInformationData(
      this.topX, this.topY, this.bottomX, this.bottomY, this.category, this.status, this.additionalStatus);
}

class LiveView {
  final SonyCameraWifiDevice? cameraDevice;

  LiveView(this.cameraDevice);

  bool _running = false;
  Completer<Payload> _completedPayload = Completer();

  int lasImageMillis = DateTime.now().millisecondsSinceEpoch;

  //this yields either a LiveViewPayload or FrameInformationData
  Stream<Payload> streamLiveView() async* {
    if (!_running) {
      _request();
      _running = true;
      while (_running) {
        Payload payload = await _completedPayload.future;
        if (payload != null) {
          /*
          int currTiem = DateTime.now().millisecondsSinceEpoch;
          int time = currTiem - lasImageMillis;
          lasImageMillis = currTiem;
          var fps = (1000 / time).toInt();
          print("fps $fps");
           */
          yield payload;
        }
      }
    }
  }

  stopLiveView() {
    _running = false;
    _completedPayload.complete(null);
  }

  _request() async {
    var client = HttpClient();

    var request = await client.getUrl(Uri.parse('http://192.168.122.1:8080/liveview/liveviewstream'))
      ..headers.contentType = ContentType.binary;

    List<int> _buffer = List.empty();

    (await request.close()).listen((event) async {
      _buffer.addAll(event);
      if (!analyzing) {
        analyzing = true;
        int size = 1;
        //analyze until size is 0 so we don't have to wait for event because there is maybe already data for next payload
        while(size != 0 && _buffer.length > 136) { //make sure buffer has at least header
          size = _analyzePayload(List.from(_buffer)); //copy
          _buffer.removeRange(0, size);
        }
        analyzing = false;
      }
    });
  }

  bool liveViewLogger = true;
  bool analyzing = false;

  int _analyzePayload(List<int> data) {
    ByteData byteData = Uint8List.fromList(data).buffer.asByteData();

    ///Common Header
    //[0] = 0xFF
    if (data[0] != 0xFF) {
      liveViewLogger ? print("ERROR Unknown Start byte ${data[0]} ***********************") : {};
      //TODO
      return 0;
    }
    //[1]
    PayloadType payloadType = PayloadType.Unknown;
    if (data[1] == 0x01) {
      payloadType = PayloadType.Image;
    } else if (data[1] == 0x02) {
      payloadType = PayloadType.FrameInformation;
    } else {
      liveViewLogger ? print("ERROR Unknown if image or imageInformation ***********************") : {};
      //TODO
      return 0;
    }
    //[2][3]
    int frameNum = byteData.getUint16(2, Endian.big);
    //[4][5][6][7]
    int timestamp = byteData.getUint32(4, Endian.big);

    ///Payload header
    //fixed 4 bytes to detect payload header
    //[8][9][10][11]
    if (!(data[8] == 0x24 && data[9] == 0x35 && data[10] == 0x68 && data[11] == 0x79)) {
      print("ERROR Unknown Payload Header ***********************");
      //TODO
      return 0;
    }

    //payload size (image = JpegSize | frameInfo = frameInfoSize)
    //[12][13][14]  [15](last padding only)
    //   nextPayloadSize = byteData.getInt32(4, Endian.big);
    int payloadSize = (data[14] & 0xFF) | ((data[13] & 0xFF) << 8) | ((data[12] & 0x0F) << 16);
    int payloadPaddingSize = byteData.getInt8(15);

    switch (payloadType) {
      case PayloadType.Image:
        //[16][17][18][19](reserved)
        //[20](reserved always 0x00)
        if (data[20] != 0x00) {
          print("ERROR wrong reserved flag ***********************");
          //TODO
          return 0;
        }
        //[21]-[128] reserved all 0x00
        break;
      case PayloadType.FrameInformation: //[16][17] frame information data version
        String frameInformationVersion = "${data[16]}.${data[17]}";
        //[18][19] frame count (number of the frame data)
        var frameCount = byteData.getUint16(18, Endian.big);

        //[20][21] single size of frame data for frameInformationVersion 1.0 should be 16
        var frameDataSize = byteData.getUint16(20, Endian.big);
        if (frameInformationVersion == "1.0" && frameDataSize != 16) {
          print("ERROR unexpected frame Data size for frame information version 1.0 ***********************");
        }
        //[22]-[128] reserved all 0x00
        //no check useless checking 100+ bytes
        break;
      case PayloadType.Unknown:
        //TODO
        return 0;
    }

    ///Payload Data
    data.removeRange(0, 136);
    if (data.length >= payloadSize + payloadPaddingSize) {
      switch (payloadType) {
        case PayloadType.Image:
          _completedPayload.complete(LiveViewPayload(MemoryImage(Uint8List.fromList(data.take(payloadSize).toList()))));
          _completedPayload = Completer();
          return 136 + payloadSize + payloadPaddingSize;
          //TODO padding
          break;
        case PayloadType.FrameInformation:
          //TODO
          break;
        case PayloadType.Unknown:
          //TODO
          return 0;
      }
    } else {
      return 0;
    }
    return 0;
  }
}
