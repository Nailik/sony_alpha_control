import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

import 'Command.dart';
import 'Response.dart';
import 'UsbDevice.dart';

class FlutterUsb {
  static var logger = Logger(printer: PrettyPrinter());
  static bool _loggingEnabled = false;
  static int maxLogLength = 100;
  static const MethodChannel _channel = const MethodChannel('flutter_usb');
  static int receiveTimeout = 500;
  static int sendTimeout = 500;

  static setTimeouts(int sendTimeout, int receiveTimeout) {
    FlutterUsb.sendTimeout = sendTimeout;
    FlutterUsb.receiveTimeout = receiveTimeout;
  }

  static Future<String> get platformVersion async {
    logD("platformVersion called");
    var version = await _channel.invokeMethod('getPlatformVersion');
    logD("platformVersion result: $version");
    return version;
  }

  static Future<String> get initializeUsb async {
    logD("initializeUsb called");
    var result = await _channel.invokeMethod('initializeUsb');
    logD("initializeUsb result: $result");
    return result;
  }

  static Future<List<UsbDevice>> get getUsbDevices async {
    logD("getUsbDevices called");
    String devices = await (_channel.invokeMethod('getUsbDevices') as Future<String>);
    devices = devices.replaceAll(r'\', r'\\');
    logD("getUsbDevices result: $devices");
    return (jsonDecode(devices) as List)
        .map((e) => UsbDevice.fromJson(e))
        .toList();
  }

  static Future<String> connectToUsbDevice(UsbDevice usbDevice) async {
    Completer completer = Completer();
    _channel
        .invokeMethod('connectToUsbDevice', usbDevice.bstr)
        .then((value) => completer.complete(value));
    logD("connectToUsbDevice return future");
    return await (completer.future as Future<String>);
  }

  static Future<Response> sendCommand(Command command) async {
    Completer completer = Completer<Response>();
    logD("sendCommand ${command.inData.createString()}");

    //TODO event
    List<dynamic> commandList = command.commandList;

    _channel.invokeMethod('sendCommand', commandList).then((result) {
      logD("sendCommand result: $result");
      Response response = Response(result[0], result[1], result[2]);
      logD("sendCommand response: ${command.inData.createString()}");
      completer.complete(response);
    });

    logD("sendCommand return future");
    return completer.future as Future<Response>;
  }

  static void enableLogger({int maxLogLengthNew = 100}) {
    maxLogLength = maxLogLengthNew;
    _loggingEnabled = true;
    logD("loggingEnabled max length $maxLogLength --------------------------");
  }

  static void disableLogger() {
    _loggingEnabled = false;
    logD("loggingDisabled ---------------------------------------------------");
  }

  static void logD(String string) {
    if (_loggingEnabled) {
      logger.d(string);
    }
  }
}

extension ListFunctions on List<int> {
  String createString() {
    String result = "";
    for (var i = 0; i < this.length && i < FlutterUsb.maxLogLength; i++) {
      String part = this[i].toRadixString(16).toString();
      if (part.length == 1) {
        result += "0";
      }
      result += "$part ";
    }
    return result;
  }

  toByteList() {
    return new Uint8List.fromList(this);
  }
}
