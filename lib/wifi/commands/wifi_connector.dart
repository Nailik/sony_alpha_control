import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/xml/root.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:xml2json/xml2json.dart';

class WifiConnector {
  static var SSDP_PORT = 1900;
  static var SSDP_MX = 1;
  static var SSDP_ADDRESS = "239.255.255.250";

  // static var SSDP_ST = "ssdp:all";
  static var SSDP_ST = "ssdp:all";

  static var request =
      "M-SEARCH * HTTP/1.1\r\nHOST: $SSDP_ADDRESS:$SSDP_PORT\r\nMAN: \"ssdp:discover\"\r\nMX: $SSDP_MX\r\nST: $SSDP_ST\r\n\r\n";

  static RawDatagramSocket socket;

  static ValueNotifier<
      List<SonyCameraWifiDevice>> availableCameras = ValueNotifier(
      List<SonyCameraWifiDevice>());


  static void stopDiscover() {
    socket.close();
    socket = null;
  }

  static void ssdpDiscover() async {
    //TODo stream der so
    //if (socket == null) {
    //when not on camera cannot access?
    // try {
    if (socket == null) {
      //TODO not bind with my own computer
      try {
          socket = await RawDatagramSocket.bind(InternetAddress("192.168.42.218"), 0); //TODO


        socket.broadcastEnabled = true;
        socket.readEventsEnabled = true;
        socket.multicastHops = 50;
        print("created socket ${socket.address}");
      } on Exception catch (e) {
        print("failed creating socket");
      }

      socket.listen((event) {
        switch (event) {
          case RawSocketEvent.read:
            print("RawSocketEvent read");
            var packet = socket.receive();
            socket.writeEventsEnabled = true;
            socket.readEventsEnabled = true;
            if (packet != null) {
              ///read camera info
              WifiCameraInfo cameraInfo = _SsdMessageProcessor.analyzeResponse(
                  new String.fromCharCodes(packet.data));
              final contents = StringBuffer();
              new HttpClient()
                  .getUrl(Uri.parse(cameraInfo.location))
                  .then((HttpClientRequest request) => request.close())
                  .then((HttpClientResponse response) {
                return response.transform(new Utf8Decoder()).listen((data) {
                  contents.write(data);
                }, onDone: () {
                  Xml2Json xml2Json = new Xml2Json();
                  xml2Json.parse(contents.toString());
                  var jsonString = xml2Json.toParker();
                  var d = Root.fromJson(jsonDecode(jsonString)["root"]);
                  var camera = SonyCameraWifiDevice(
                      d.device.friendlyName, d.device);
                  if (!availableCameras.value.contains(camera)) {
                    availableCameras.value.add(camera);
                  }
                });
              });
            }
            return;
          case RawSocketEvent.write:
            print("RawSocketEvent write");
            break;
        }
      });

      socket.joinMulticast(InternetAddress(SSDP_ADDRESS));
    }

    var i = socket.send(
        request.codeUnits, InternetAddress(SSDP_ADDRESS), SSDP_PORT);
    print("socket.send $i");
  }
}

class _SsdMessageProcessor {
  static WifiCameraInfo analyzeResponse(String response) {
    if (!response.startsWith("M-SEARCH")) {
      var isAdv = response.startsWith("NOTIFY");
      var nt = isAdv ? _findValue(response, "NTS") : null;
      var isFoundAction = !(nt != null && nt == "ssdp:byebye");
      var location = isFoundAction ? _findValue(response, "LOCATION") : null;
      var usn = _findValue(response, "USN");
      var uuid = _findUuidFromUSN(usn);
      var st = isFoundAction ? _findValue(response, isAdv ? "NT" : "ST") : null;
      var server = _findValue(response, "SERVER");
      var maxAge = isFoundAction
          ? _findMaxAgeFromCacheControl(_findValue(response, "CACHE-CONTROL"))
          : -1;

      if (isFoundAction &&
          !((isAdv &&
              location != null &&
              usn != null &&
              st != null &&
              server != null &&
              uuid != null &&
              maxAge != -1) ||
              uuid == null)) {
        return WifiCameraInfo(usn, uuid, location, server, st);
      }
    }
    return null;
  }

  static String _findValue(String message, String key) {
//(?mis) multiline, insensitive, singleline (dot matches new line charakters)
    RegExpMatch regExp = new RegExp(".*^$key:\\s?([^\\r]+).*",
        multiLine: true, caseSensitive: false, dotAll: true)
        .firstMatch(message);
    if (regExp != null) {
      return regExp.group(1);
    }
    return null;
  }

  static int _findMaxAgeFromCacheControl(String cacheControl) {
    var i = -1;
    if (cacheControl != null &&
        cacheControl.toLowerCase().startsWith("max-age")) {
      i = int.tryParse(cacheControl.substring(8));
      if (i == null) {
        i = -1;
      }
    }
    return i;
  }

  static String _findUuidFromUSN(String usn) {
    if (usn != null && usn.toLowerCase().startsWith("uuid:")) {
      var arr = usn.split("::");
      if (arr != null) {
        return arr[0];
      }
    }
    return null;
  }
}
