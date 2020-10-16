import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

enum WaitAnalyzerState { CommonHeader, PayloadHeader, Payload }

extension WaitAnalyzerStateExtension on WaitAnalyzerState {
  get size {
    switch (this) {
      case WaitAnalyzerState.CommonHeader:
        return 8;
      case WaitAnalyzerState.PayloadHeader:
        return 128;
      case WaitAnalyzerState.Payload:
        return LiveViewAnalyzer.nextPayloadSize + LiveViewAnalyzer.nextPayloadPaddingSize;
    }
  }
}

class LiveViewAnalyzer {
  ValueNotifier<MemoryImage> previousImage = ValueNotifier(null);
  ValueNotifier<MemoryImage> memoryImage = ValueNotifier(null);

  WaitAnalyzerState waitAnalyzerState = WaitAnalyzerState.CommonHeader;
  Uri uri = Uri.parse('http://192.168.122.1:8080/liveview/liveviewstream');

  static int nextPayloadSize = 0;
  static int nextPayloadPaddingSize = 0;
  static bool payloadIsImage = false; //true = image, false = imageInfo
  int lastImageUpdate = 0;

  start() {
    _request();
  }

  _request() async {
    var client = HttpClient();

    var request = await client.getUrl(uri)
      ..headers.contentType = ContentType.binary;

    HttpClientResponse response = await request.close();
    print("response.status ${response.statusCode}");
    _analyze(response);
  }

  List<int> _buffer = List<int>();

  _analyze(HttpClientResponse response) async {
    response.listen((event) async {
      _buffer.addAll(event);
      bool successful = false;

      while (!successful) {
        if (_buffer.length < waitAnalyzerState.size) {
          //wait longer
          successful = true;
        } else {
          successful = await _analyzeData(_buffer.take(waitAnalyzerState.size).toList());
          if (successful) {
            _buffer.removeRange(0, waitAnalyzerState.size);
            switch (waitAnalyzerState) {
              case WaitAnalyzerState.CommonHeader:
                //analyze
                waitAnalyzerState = WaitAnalyzerState.PayloadHeader;
                break;
              case WaitAnalyzerState.PayloadHeader:
                waitAnalyzerState = WaitAnalyzerState.Payload;
                break;
              case WaitAnalyzerState.Payload:
                waitAnalyzerState = WaitAnalyzerState.CommonHeader;
                break;
            }
          } else {
            print("buffer.clear();");
            _buffer.clear();
          }
        }
      }
      successful = false;
    });
  }

  Future<bool> _analyzeData(List<int> data) {
    switch (waitAnalyzerState) {
      case WaitAnalyzerState.CommonHeader:
        return _analyzeCommonHeader(data);
      case WaitAnalyzerState.PayloadHeader:
        return _analyzePayloadHeader(data);
      case WaitAnalyzerState.Payload:
        return _analyzePayload(data);
    }
  }

  Future<bool> _analyzeCommonHeader(List<int> data) async {
    ///Common header
    ByteData byteData = Uint8List.fromList(data).buffer.asByteData();
//    print("commonHeader length ${data.length}");
    //[0] = 0xFF
    if (data[0] != 0xFF) {
      print("ERROR Unknown Start byte ${data[0]} ***********************");
      return false;
    }
    //[1]
    bool isImage = false;
    bool isImageInformation = false;
    if (data[1] == 0x01) {
      isImage = true;
      payloadIsImage = true;
      //    print("streamingImages");
    } else if (data[1] == 0x02) {
      isImageInformation = true;
      payloadIsImage = false;
      //   print("streamingPlayback");
    } else {
      print("ERROR Unknown if image or imageInformation ***********************");
      return false;
    }
    //[2][3]
    var frameNum = byteData.getUint16(2, Endian.big);
    //    print("frameNum $frameNum");
    //[4][5][6][7]
    var timestamp = byteData.getUint32(4, Endian.big);
    //  print("timestamp $timestamp");

    return true;
  }

  Future<bool> _analyzePayloadHeader(List<int> data) async {
    ///Payload header
    ByteData byteData = Uint8List.fromList(data).buffer.asByteData();

    //fixed 4 bytes to detect payload header
    //[1][2][3][4]
    if (data[0] == 0x24 && data[1] == 0x35 && data[2] == 0x68 && data[3] == 0x79) {
      //print("has payload header");
    } else {
      print("ERROR Unknown Payload Header ***********************");
      return false;
    }

    //payload size (image = JpegSize | frameInfo = frameInfoSize)
    //[4][5][6]  [7](last padding only)
    //   nextPayloadSize = byteData.getInt32(4, Endian.big);
    nextPayloadSize = (data[6] & 0xFF) | ((data[5] & 0xFF) << 8) | ((data[4] & 0x0F) << 16);
    //print("payloadDataSize $nextPayloadSize");

    nextPayloadPaddingSize = byteData.getInt8(7);
    //print("nextPayloadPaddingSize $nextPayloadPaddingSize");

    if (payloadIsImage) {
      //[8][9][10][11](reserved)
      //[12](reserved always 0x00)
      if (data[12] != 0x00) {
        print("ERROR wrong reserved flag ***********************");
        return false;
      }
      //[13]-[128] reserved all 0x00
    } else {
      //[8][9] frame information data version
      String frameInformationVersion = "${data[8]}.${data[9]}";
      //     print("frameInformationVersion $frameInformationVersion");
      //[10][11] frame count (number of the frame data)
      var frameCount = byteData.getUint16(10, Endian.big);
     // print("frameCount $frameCount");

      //[12][13] single size of frame data for frameInformationVersion 1.0 should be 16
      var frameDataSize = byteData.getUint16(12, Endian.big);
      if (frameInformationVersion == "1.0" && frameDataSize != 16) {
        print("ERROR unexpected frame Data size for frame information version 1.0 ***********************");
      }
      //[14]-[128] reserved all 0x00
      //no check useless checking 100+ bytes
    }
    return true;
  }

  Future<bool> _analyzePayload(List<int> data) async {
    ///Payload Data
    if (payloadIsImage) {
      //no check useless checking 100+ bytes
      //TODO read until payload data is full`?

       previousImage.value = memoryImage.value;
      memoryImage.value = (MemoryImage(Uint8List.fromList(data)));
      int time =  DateTime.now().millisecondsSinceEpoch - lastImageUpdate;

      var fps = 1000 / time;
    //  print("FPS $fps");

      lastImageUpdate = DateTime.now().millisecondsSinceEpoch;
    } else {
      //print("isImageInformation");
    }
    return true;
  }
}
