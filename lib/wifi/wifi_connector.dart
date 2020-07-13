// find the address
/*


 */
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sonyalphacontrol/wifi/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/wifi_camera_xml.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:xml2json/xml2json.dart';

class WifiConnector {
  static var SSDP_PORT = 1900;
  static var SSDP_MX = 1;
  static var SSDP_ADDRESS = "239.255.255.250";
  static var SSDP_ST = "ssdp:all";

  static var request =
      "M-SEARCH * HTTP/1.1\r\nHOST: $SSDP_ADDRESS:$SSDP_PORT\r\nMAN: \"ssdp:discover\"\r\nMX: $SSDP_MX\r\nST: $SSDP_ST\r\n\r\n";

  static RawDatagramSocket socket;

  static Future<SonyCameraWifiDevice> getCamera() async {
    WifiCameraInfo cameraInfo = await ssdpRequest();

    if (cameraInfo != null) {
      //else it will use mobile internet on android when trying to read camera info
      if (Platform.isAndroid) {
        WiFiForIoTPlugin.forceWifiUsage(true);
      }

      final completer = Completer<SonyCameraWifiDevice>();
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
          completer
              .complete(SonyCameraWifiDevice(d.device.friendlyName, d.device));
        });
      });

      return completer.future;
    }
    return null;
  }

  static Future<WifiCameraInfo> ssdpRequest() async {
    //TODo stream der so
    //if (socket == null) {
    //when not on camera cannot access?
    try {
      if (socket == null) {
        socket =
            await RawDatagramSocket.bind(InternetAddress("192.168.122.131"), 0);
      }

      socket.send(request.codeUnits, InternetAddress(SSDP_ADDRESS), SSDP_PORT);

      //   await socket.forEach((RawSocketEvent event) {
      //  if (event == RawSocketEvent.read) {
      Datagram dg;
      while (dg == null) {
        dg = socket.receive();
      }
      return _SsdMessageProcessor.analyzeResponse(
          new String.fromCharCodes(dg.data));
      //     }
      //    });

    } on SocketException catch (e) {
      socket = null;
      print(e);
      return null;
      //camera not connected
    }
    //  }
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
      return null;
    }
  }
}
