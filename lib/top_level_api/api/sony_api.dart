import 'package:async/async.dart' show StreamGroup;
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/api/sony_usb_api.dart';
import 'package:sonyalphacontrol/wifi/api/sony_wifi_api.dart';

//TODO
//connect, init, get devices
class SonyApi {
  //this will log the responses of every request
  static var analyze = true;

  static SonyCameraDevice _connectedCamera;

  static SonyCameraDevice get connectedCamera => _connectedCamera;

  static SonyWifiApi _wifiApi = SonyWifiApi();
  static SonyUsbApi _usbApi = SonyUsbApi();

  static get wifiApi => _wifiApi;

  static get usbApi => _usbApi;

  static bool get wifiEnabled => _wifiApi.initialized;

  static bool get usbEnabled => _usbApi.initialized;

  ///initialize usb and wifi api, everything else will call an error if not done
  static Future<bool> initialize({bool usb = true, bool wifi = true}) async {
    if (usb) {
      await _usbApi.initialize();
    }
    if (wifi) {
      await _wifiApi.initialize();
    }
    return _wifiApi.initialized && _usbApi.initialized;
  }

  static var streamGroup;

  static Stream<List<SonyCameraDevice>> getDevices(Duration updateDuration) {
    print("getDevices");
    //TODO usb
    //TODO stop
    // Observable.merge([_wifiApi.getAvailableCameras(updateDuration)]).pipe(combineStream);
    if (streamGroup == null) {
      streamGroup =
          StreamGroup.merge([_wifiApi.getAvailableCameras(updateDuration)]);
    }
    return streamGroup;
  }

  static Future<bool> connectCamera(SonyCameraDevice sonyCameraDevice) async {
    //call the correct api to connect
    // stopUpdatingDevices();
    bool result = false;
    switch (sonyCameraDevice.interfaceType) {
      case InterfaceType.Wifi_Interface:
        if (wifiEnabled) {
          result = await _wifiApi.connectCamera(sonyCameraDevice);
        }
        break;
      case InterfaceType.USB_Interface:
        if (usbEnabled) {
          result = await _usbApi.connectCamera(sonyCameraDevice);
        }
        break;
    }

    if (result) {
      //set this to the connected camera
      _connectedCamera = sonyCameraDevice;
    }

    return result;
  }
}

abstract class SonyApiInterface {
  bool get initialized;

  Future<bool> initialize();

  Stream<List<SonyCameraDevice>> getAvailableCameras(Duration updateDuration);

  Future<bool> connectCamera(SonyCameraDevice sonyCameraDevice);
}
