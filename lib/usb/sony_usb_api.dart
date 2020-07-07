import 'package:flutter_usb/Response.dart';
import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/commands.dart';
import 'package:sonyalphacontrol/usb/response_validation.dart';
import 'package:sonyalphacontrol/usb/sony_camera_usb_device.dart';

class SonyUsbApi extends SonyApiInterface {
  var _initialized = false;

  @override
  bool get initialized => _initialized;

  @override
  Future<bool> initialize() async {
    await FlutterUsb.initializeUsb;
    _initialized = true;
    return _initialized;
  }

  @override
  Future<List<SonyCameraUsbDevice>> getAvailableCameras() => FlutterUsb
      .getUsbDevices
      .then((value) => value.map((e) => new SonyCameraUsbDevice(e)).toList());

  @override
  Future<bool> connectCamera(SonyCameraDevice device) async {
    var str = await FlutterUsb.connectToUsbDevice(
        (device as SonyCameraUsbDevice).device);
    Response response = await FlutterUsb.sendCommand(
        Commands.getSettingsXCommand(OpCodeId.Connect, 1, 3, 0, 3, 0,
            length: 38));
    return response.isValidResponse();
  }
}
