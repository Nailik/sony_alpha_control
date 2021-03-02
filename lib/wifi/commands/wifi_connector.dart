import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/xml/root.dart';
import 'package:xml2json/xml2json.dart';

class WifiConnector {
  static var SSDP_PORT = 1900;
  static var SSDP_MX = 5;
  static var SSDP_ADDRESS = "239.255.255.250";

  // static var SSDP_ST = "ssdp:all";
  static var SSDP_ST = "urn:schemas-sony-com:service:ScalarWebAPI:1";

  static var request =
      "M-SEARCH * HTTP/1.1\r\nHOST: $SSDP_ADDRESS:$SSDP_PORT\r\nMAN: \"ssdp:discover\"\r\nMX: $SSDP_MX\r\nST: $SSDP_ST\r\n\r\n";

  static RawDatagramSocket? socket;

  static Stream<List<SonyCameraDevice>>? _availableCamerasStream;
  static StreamController<List<SonyCameraDevice>>? _controller;

  static List<SonyCameraDevice> _devices = new List.empty(growable: true);

  static Stream<List<SonyCameraDevice>> getAvailableCameras(
      Duration updateDuration) {
    if (_controller == null) {
      print("getAvailableCameras _controller == null");
      _controller =
          new StreamController<List<SonyCameraDevice>>(onListen: () async {
        while (_controller != null && _controller!.hasListener) {
          //calls ssdp discover until stream is closed in loop
          ssdpDiscover();
          await Future.delayed(updateDuration);
        }
      }, onCancel: () {
        print("Stream onCancel");
        _controller!.close();
        _controller = null;
        _devices.clear();
      });

     // readCameraDevice("http://192.168.122.1:64321/scalarwebapi_dd.xml");
    }
    return _controller!.stream;
  }

  static void stopDiscover() {
    socket!.close();
    socket = null;
  }

  static var inet = InternetAddress(SSDP_ADDRESS);

  static void ssdpDiscover() async {
    if (socket == null) {
      await createSocket();
    }
    if (socket != null) {
      var i = socket!.send(request.codeUnits, inet, SSDP_PORT);
      print("socket.send $i");
    }
  }

  static createSocket() async {
    socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0, ttl: SSDP_MX);

    socket!.broadcastEnabled = true;
    socket!.readEventsEnabled = true;
    socket!.multicastHops = SSDP_MX;
    print("created socket ${socket!.address}");

    socket!.listen((event) {
      switch (event) {
        case RawSocketEvent.read:
          print("RawSocketEvent read");
          var packet = socket!.receive();
          socket!.writeEventsEnabled = true;
          socket!.readEventsEnabled = true;
          if (packet != null) {
            ///read camera info
            WifiCameraInfo cameraInfo = _SsdMessageProcessor.analyzeResponse(
                new String.fromCharCodes(packet.data))!;
            readCameraDevice(cameraInfo.location!);
          }
          return;
        case RawSocketEvent.write:
          print("RawSocketEvent write");
          return;
      }
    });

    var _interfaces = await NetworkInterface.list();
    for (var interface in _interfaces) {
      socket!.joinMulticast(inet, interface);
      print("joinMulticast ${interface.name}");
    }
  }

  static readCameraDevice(String url) {
    final contents = StringBuffer();
    new HttpClient()
        .getUrl(Uri.parse(url))
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
            d.device!.friendlyName, d.device); //TODO store wifi camera info
        print("new device ${d.device!.friendlyName}");
        //TODO check if sony CAMERA device?
        if (!_devices.contains(camera)) {
          print(" _devices.add");
          _devices.add(camera);
          if (_controller != null && !_controller!.isClosed) {
            _controller!.add(_devices);
          }
        }
      });
    });
  }
}

class _SsdMessageProcessor {
  static WifiCameraInfo? analyzeResponse(String response) {
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

  static String? _findValue(String message, String key) {
//(?mis) multiline, insensitive, singleline (dot matches new line charakters)
    RegExpMatch? regExp = new RegExp(".*^$key:\\s?([^\\r]+).*",
            multiLine: true, caseSensitive: false, dotAll: true)
        .firstMatch(message);
    if (regExp != null) {
      return regExp.group(1);
    }
    return null;
  }

  static int? _findMaxAgeFromCacheControl(String? cacheControl) {
    int? i = -1;
    if (cacheControl != null &&
        cacheControl.toLowerCase().startsWith("max-age")) {
      i = int.tryParse(cacheControl.substring(8));
      if (i == null) {
        i = -1;
      }
    }
    return i;
  }

  static String? _findUuidFromUSN(String? usn) {
    if (usn != null && usn.toLowerCase().startsWith("uuid:")) {
      var arr = usn.split("::");
      if (arr != null) {
        return arr[0];
      }
    }
    return null;
  }
}
