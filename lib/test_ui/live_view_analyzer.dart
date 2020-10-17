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
  ValueNotifier<MemoryImage> memoryImage = ValueNotifier(null);

  Uri uri = Uri.parse('http://192.168.122.1:8080/liveview/liveviewstream');

  static int nextPayloadSize = 0;
  static int nextPayloadPaddingSize = 0;
  static bool payloadIsImage = false; //true = image, false = imageInfo
  int lastImageUpdate = 0;
  int lastImageTimestamp = 0;
  int currentImageTimestamp = 0;

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

  WaitAnalyzerState waitAnalyzerState = WaitAnalyzerState.CommonHeader;

  _analyze(HttpClientResponse response) async {
    response.listen((event) async {
      _buffer.addAll(event);
 //      print("_buffer ${_buffer.length}"); //1 packet = common header + payload header

      bool successful = false;

      if (waitAnalyzerState == WaitAnalyzerState.CommonHeader &&
          _buffer.length >= WaitAnalyzerState.CommonHeader.size) {
        ///read next common header
        //analyze common Header
        successful = await _analyzeCommonHeader(_buffer);
        if (successful) {
          waitAnalyzerState = WaitAnalyzerState.PayloadHeader; //now we wait for payload header
          if (_buffer.length >= WaitAnalyzerState.CommonHeader.size) {
            _buffer.removeRange(0, WaitAnalyzerState.CommonHeader.size);
          } else {
        //    print("ERROR _too small buffer CommonHeader");
            _buffer.clear(); //??
            waitAnalyzerState = WaitAnalyzerState.CommonHeader; //start from beginning
          }
        } else {
        //  print("ERROR _buffer.clear()");
          _buffer.clear(); //??
        }
      }

      if (waitAnalyzerState == WaitAnalyzerState.PayloadHeader) {
        _buffer.removeRange(0, _buffer.indexOf(0x24)); //remove until start of payload header
        if (_buffer.length >= WaitAnalyzerState.PayloadHeader.size) {
          ///read next payload header
          //analyze payload header
          successful = await _analyzePayloadHeader(_buffer);
          if (successful) {
            waitAnalyzerState = WaitAnalyzerState.Payload; //now we wait for payload (next event probably?)
            if (_buffer.length >= WaitAnalyzerState.PayloadHeader.size) {
              _buffer.removeRange(0, WaitAnalyzerState.PayloadHeader.size);
            } else {
        //      print("ERROR _too small buffer PayloadHeader");
              _buffer.clear(); //??
              waitAnalyzerState = WaitAnalyzerState.CommonHeader; //start from beginning
            }
          } else {
       //     print("ERROR _buffer.clear()");
            waitAnalyzerState = WaitAnalyzerState.CommonHeader; //start from beginning
            _buffer.clear(); //?? TODO just wait for next payload??
          }
        }
      }

      if (waitAnalyzerState == WaitAnalyzerState.Payload && _buffer.length >= WaitAnalyzerState.Payload.size) {
        //analyze payload
        successful = await _analyzePayload(_buffer);
        if (successful) {
          waitAnalyzerState = WaitAnalyzerState.CommonHeader; //now we wait for common Header
          if (_buffer.length >= WaitAnalyzerState.Payload.size) {
            _buffer.removeRange(0, WaitAnalyzerState.Payload.size);
          } else {
            _buffer.clear(); //??
       //     print("ERROR _too small buffer Payload");
            waitAnalyzerState = WaitAnalyzerState.CommonHeader; //start from beginning (anyway)
          }
        } else {
      //    print("ERROR _buffer.clear()");
          waitAnalyzerState = WaitAnalyzerState.CommonHeader; //start from beginning
          _buffer.clear(); //??
        }
      }
    });
  }


  Future<bool> _analyzeCommonHeader(List<int> data) async {
    ///Common header
    ByteData byteData = Uint8List.fromList(data).buffer.asByteData();
//    print("commonHeader length ${data.length}");
    //[0] = 0xFF
    if (data[0] != 0xFF) {
      //    print("ERROR Unknown Start byte ${data[0]} ***********************");
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
      // print("ERROR Unknown if image or imageInformation ***********************");
      return false;
    }
    //[2][3]
    var frameNum = byteData.getUint16(2, Endian.big);
    //    print("frameNum $frameNum");
    //[4][5][6][7]
    var timestamp = byteData.getUint32(4, Endian.big);
    lastImageTimestamp = currentImageTimestamp;
     currentImageTimestamp = timestamp;

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
      //   print("ERROR Unknown Payload Header ***********************");
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
        //  print("ERROR wrong reserved flag ***********************");
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
        //    print("ERROR unexpected frame Data size for frame information version 1.0 ***********************");
      }
      //[14]-[128] reserved all 0x00
      //no check useless checking 100+ bytes
    }
    return true;
  }

  Future<bool> _analyzePayload(List<int> data) async {
    ///Payload Data
    if (data.length >= nextPayloadSize) {
      if (payloadIsImage) {
        //no check useless checking 100+ bytes
        //TODO read until payload data is full`?
        //    if(data.length < nextPayloadSize){
        //     print("ERROR data shorter than image size ***********************");
        //      return false;
        //     }

        _updateImage(data); //don't care if it is successful
            int time =  DateTime.now().millisecondsSinceEpoch - lastImageUpdate;
          //var fps = 1000 / time;
          print("diff update image: $time diff update timestap ${currentImageTimestamp - lastImageTimestamp}  time diff: ${time - (currentImageTimestamp - lastImageTimestamp)}");
           lastImageUpdate = DateTime.now().millisecondsSinceEpoch;
      } else {
        //print("isImageInformation");
      }
      return true;
    } else {
      return false;
    }
  }

  _updateImage(List<int> data) async {
    try {
      memoryImage.value = (MemoryImage(Uint8List.fromList(data.take(nextPayloadSize).toList())));
    } on Exception catch (e) {

    }
  }
}