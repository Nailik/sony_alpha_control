import 'dart:async';

import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/sony_usb_api.dart';
import 'package:sonyalphacontrol/wifi/sony_wifi_api.dart';
import 'package:cross_connectivity/cross_connectivity.dart';

class SonyApi {
  static SonyCameraDevice _connectedCamera;

  static SonyCameraDevice get connectedCamera => _connectedCamera;

  static final _wifiApi = SonyWifiApi();

  static get wifiApi => _wifiApi;
  static final _usbApi = SonyUsbApi();

  static get usbApi => _usbApi;

  static ApiInterface get api {
    switch (_connectedCamera.interfaceType) {
      case InterfaceType.Wifi_Interface:
        return _wifiApi;
      case InterfaceType.USB_Interface:
        return _usbApi;
      default:
        return null;
    }
  }

  static bool get wifiEnabled => _wifiApi.initialized;

  static bool get usbEnabled => _usbApi.initialized;

  ///intitialize usb and wifi api, everything else will call an error if not done
  static Future<bool> initialize({bool usb = true, bool wifi = true}) async {
    if (usb) {
      await _usbApi.initialize();
    }
    if (wifi) {
      await _wifiApi.initialize();
    }
    return _wifiApi.initialized && _usbApi.initialized;
  }

  static Stream<List<SonyCameraDevice>> getDevices(Duration updateDuration) {
    StreamController<List<SonyCameraDevice>> controller;
    controller =
        new StreamController<List<SonyCameraDevice>>(onListen: () async {
      while (controller.hasListener) {
        var devices = new List<SonyCameraDevice>();

        if (usbEnabled) {
          devices.addAll(await _usbApi.getAvailableCameras());
        }

        if (wifiEnabled) {
          devices.addAll(await _wifiApi.getAvailableCameras());
        }
        if (!controller.isClosed) {
          controller.add(devices);
        }
        await Future.delayed(updateDuration);
      }
    }, onCancel: () {
      controller.close();
    });
    return controller.stream;
  }

  static Future<bool> connectToCamera(SonyCameraDevice sonyCameraDevice) async {
    //call the correct api to connect
    // stopUpdatingDevices();
    bool result = false;
    switch (sonyCameraDevice.interfaceType) {
      case InterfaceType.Wifi_Interface:
        if (wifiEnabled) {
          result = await _wifiApi.connectToCamera(sonyCameraDevice);
        }
        break;
      case InterfaceType.USB_Interface:
        if (usbEnabled) {
          result = await _usbApi.connectToCamera(sonyCameraDevice);
        }
        break;
    }

    if (result) {
      //set this to the connected camera
      _connectedCamera = sonyCameraDevice;
    }

    return result;
  }

  ///when the camera is connected it's possible to read the "Available" items, this represents what the camera can do, not whats currently at the moment is supported
  static List<CameraStatusItemType> get availableStatusItems =>
      api.availableStatusItems;

  static List<CameraSettingsItemType> get availableSettingsItems =>
      api.availableSettingsItems;

  static List<CameraFunctionItemType> get availableFunctionItems =>
      api.availableFunctionItems;

  static Future<bool> updateSettings() => api.updateSettings(_connectedCamera);

  ///this loop will update the camera status, current available items and current available settings
  static Future<bool> startUpdateLoop() =>
      api.startUpdateLoop(_connectedCamera);

  ///this will start live view loop
  static Future<bool> startLiveView() => api.startLiveView();

  ///functions

  ///unsafe to use, id and value need to match
  static Future<bool> setSettingsRaw(int id, int value) =>
      api.setSettingsRaw(id, value, _connectedCamera);

  static Future<bool> setAspectRatio(AspectRatioId value) {
    api.setAspectRatio(value, _connectedCamera);
  }
}
