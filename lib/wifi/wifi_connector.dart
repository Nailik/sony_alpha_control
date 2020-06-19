// find the address
/*


 */
import 'dart:io';

import 'package:sonyalphacontrol/wifi/sony_camera_wifi_device.dart';

class WifiConnector {
  static var SSDP_PORT = 1900;
  static var SSDP_MX = 1;
  static var SSDP_ADDRESS = "239.255.255.250";
  static var SSDP_ST = "ssdp:all";

  static var request =
      "M-SEARCH * HTTP/1.1\r\nHOST: $SSDP_ADDRESS:$SSDP_PORT\r\nMAN: \"ssdp:discover\"\r\nMX: $SSDP_MX\r\nST: $SSDP_ST\r\n\r\n";

  static RawDatagramSocket socket;

  static Future<WifiCameraInfo> ssdpRequest() async {
    //if (socket == null) {
    //when not on camera cannot access?
    socket =
    await RawDatagramSocket.bind(InternetAddress("192.168.122.131"), 0);
    socket.send(request.codeUnits, InternetAddress(SSDP_ADDRESS), SSDP_PORT);

     await socket.forEach((RawSocketEvent event) {
    if (event == RawSocketEvent.read) {
      Datagram dg = socket.receive();
      return _SsdMessageProcessor.analyzeResponse(
          new String.fromCharCodes(dg.data));
    }
       });
    //  }

    return null;
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
      return null;
    }
  }

  static String _findValue(String message, String key) {
    //(?mis) multiline, insensitive, singleline (dot matches new line charakters)
    RegExpMatch regExp =
        new RegExp(".*^$key:\\s?([^\\r]+).*", multiLine: true, caseSensitive: false, dotAll: true).firstMatch(message);
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
