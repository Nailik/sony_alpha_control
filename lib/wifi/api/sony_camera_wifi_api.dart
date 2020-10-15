import 'dart:convert';
import 'dart:math';

import 'package:sonyalphacontrol/top_level_api/api/force_update.dart';
import 'package:sonyalphacontrol/top_level_api/api/function_availability.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_direction_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';

class SonyCameraWifiApi extends CameraApiInterface {
  SonyCameraWifiDevice get device => cameraDevice;

  //TODO modify/set ... maybe available and supported is null, eg when camera is in A mode and uses automatic shutter
  SonyCameraWifiApi(SonyCameraDevice cameraDevice) : super(cameraDevice);

  @override
  Future<List<CameraImage>> capturePhoto() {
    // TODO: implement capturePhoto
    throw UnimplementedError();
  }

  ///Version
  //TODO other Force Update options for info?

  @override
  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsCamera({update = ForceUpdate.IfNull}) async {
    var listInfoItem = await super.getWebApiVersionsCamera();
    if (listInfoItem.values.isEmpty) {
      await _getWebApiVersions(listInfoItem, SonyWebApiServiceTypeId.CAMERA);
    }
    return listInfoItem;
  }

  @override
  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsAvContent({ForceUpdate update}) async {
    var listInfoItem = await super.getWebApiVersionsAvContent();
    if (listInfoItem.values.isEmpty) {
      await _getWebApiVersions(listInfoItem, SonyWebApiServiceTypeId.AV_CONTENT);
    }
    return listInfoItem;
  }

  @override
  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsSystem({ForceUpdate update}) async {
    var listInfoItem = await super.getWebApiVersionsSystem();
    if (listInfoItem.values.isEmpty) {
      await _getWebApiVersions(listInfoItem, SonyWebApiServiceTypeId.SYSTEM);
    }
    return listInfoItem;
  }

  @override
  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsGuide({ForceUpdate update}) async {
    var listInfoItem = await super.getWebApiVersionsGuide();
    if (listInfoItem.values.isEmpty) {
      await _getWebApiVersions(listInfoItem, SonyWebApiServiceTypeId.GUIDE);
    }
    return listInfoItem;
  }

  @override
  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersionsAccessControl({ForceUpdate update}) async {
    var listInfoItem = await super.getWebApiVersionsAccessControl();
    if (listInfoItem.values.isEmpty) {
      await _getWebApiVersions(listInfoItem, SonyWebApiServiceTypeId.ACCESS_CONTROL);
    }
    return listInfoItem;
  }

  _getWebApiVersions(ListInfoItem listInfoItem, SonyWebApiServiceTypeId serviceTypeId) async {
    return await WifiCommand.createCommand(ApiMethodId.GET, ItemId.Versions, service: serviceTypeId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response)
        .then((response) => device.cameraSettings.updateListInfoItem(listInfoItem, response));
  }

  ///MethodTypes (get) accessControl
  //TODO web api version wenn keine angegeben für alle
  //TODO availability only checked at apiList
  //TODO other Force Update options for info?

  @override
  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesCamera(
      {WebApiVersionId webApiVersion, ForceUpdate update}) async {
    ListInfoItem<WebApiMethodValue> listInfoItem = await super.getMethodTypesCamera();
    if (listInfoItem.values.isEmpty) {
      return await _getMethodTypes(listInfoItem, SonyWebApiServiceTypeId.CAMERA, webApiVersion);
    }
    return await super.getMethodTypesCamera();
  }

  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesAvContent(
      {WebApiVersionId webApiVersion, ForceUpdate update}) async {
    ListInfoItem<WebApiMethodValue> listInfoItem = await super.getMethodTypesAvContent();
    if (listInfoItem.values.isEmpty) {
      return await _getMethodTypes(listInfoItem, SonyWebApiServiceTypeId.AV_CONTENT, webApiVersion);
    }
    return listInfoItem;
  }

  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesSystem(
      {WebApiVersionId webApiVersion, ForceUpdate update}) async {
    ListInfoItem<WebApiMethodValue> listInfoItem = await super.getMethodTypesSystem();
    if (listInfoItem.values.isEmpty) {
      return await _getMethodTypes(listInfoItem, SonyWebApiServiceTypeId.SYSTEM, webApiVersion);
    }
    return listInfoItem;
  }

  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesGuide(
      {WebApiVersionId webApiVersion, ForceUpdate update}) async {
    ListInfoItem<WebApiMethodValue> listInfoItem = await super.getMethodTypesGuide();
    if (listInfoItem.values.isEmpty) {
      return await _getMethodTypes(listInfoItem, SonyWebApiServiceTypeId.GUIDE, webApiVersion);
    }
    return listInfoItem;
  }

  Future<ListInfoItem<WebApiMethodValue>> getMethodTypesAccessControl(
      {WebApiVersionId webApiVersion, ForceUpdate update}) async {
    ListInfoItem<WebApiMethodValue> listInfoItem = await super.getMethodTypesAccessControl();
    if (listInfoItem.values.isEmpty) {
      return await _getMethodTypes(listInfoItem, SonyWebApiServiceTypeId.ACCESS_CONTROL, webApiVersion);
    }
    return listInfoItem;
  }

  Future<ListInfoItem> _getMethodTypes(
      ListInfoItem listInfoItem, SonyWebApiServiceTypeId serviceTypeId, WebApiVersionId webApiVersion) async {
    return await WifiCommand.createCommand(ApiMethodId.GET, ItemId.MethodTypes,
            params: [webApiVersion.wifiValue], service: serviceTypeId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response)
        .then((response) =>
            device.cameraSettings.updateListInfoItem(listInfoItem, response, webApiVersion: webApiVersion));
  }

  ///AvailableApiList (get)

  @override
  Future<ListInfoItem<ApiFunctionValue>> getAvailableFunctions(
      {update = ForceUpdate.IfNull}) async {
    //TODO other Force Update options for info?
    ListInfoItem<ApiFunctionValue> listInfoItem =
        await super.getAvailableFunctions();

    if ((update == ForceUpdate.IfNull && listInfoItem.values.isEmpty) ||
        update == ForceUpdate.On) {
      await WifiCommand.createCommand(
              ApiMethodId.GET_AVAILABLE, listInfoItem.itemId)
          .send(device)
          .then((wifiResponse) {
        var jsonD = jsonDecode(wifiResponse.response);
        var list = jsonD["result"];

        List<ApiFunctionValue> values = new List();

        list[0].forEach((wifiValue) {
          ApiFunctionValue newItem = ApiFunctionValue.fromWifiValue(wifiValue);

          ApiFunctionValue existingItem = values.firstWhere(
              (element) => element.id == newItem.id,
              orElse: () => null);

          if (existingItem != null) {
            if (!existingItem.methods.contains(newItem.methods)) {
              existingItem.methods.addAll(newItem.methods);
            }
          } else {
            values.add(newItem);
          }
        });
        listInfoItem.updateItem(values);
      });
    }

    return await super.getAvailableFunctions();
  }

  ///ApplicationInfo (get)

  @override
  Future<ListInfoItem<StringValue>> getApplicationInfo(
      {update = ForceUpdate.IfNull}) async {
    //TODO other Force Update options for info?
    ListInfoItem<StringValue> listInfoItem = await super.getApplicationInfo();

    _updateListInfoItem(listInfoItem);

    return await super.getApplicationInfo();
  }

  ///AvailableSettings (get)

  @override
  Future<ListInfoItem<StringValue>> getAvailableSettings(bool longPolling,
      {update = ForceUpdate.IfNull}) async {
    //TODO other Force Update options for info?
    ListInfoItem<StringValue> listInfoItem =
        await super.getAvailableSettings(longPolling);

    await WifiCommand.createCommand(ApiMethodId.GET, listInfoItem.itemId,
            params: [longPolling])
        .send(device)
        .then((wifiResponse) => wifiResponse.response)
        .then((response) =>
            device.cameraSettings.updateListInfoItem(listInfoItem, response));

    return await super.getAvailableSettings(longPolling);
  }

  ///CameraFunction (set, get, getSupported, getAvailable)

  @override
  Future<SettingsItem<CameraFunctionValue>> getCameraFunction(
          {update = ForceUpdate.IfNull}) async =>
      _updateIf(update, await super.getCameraFunction());

  @override
  Future<bool> setCameraFunction(CameraFunctionValue value) async =>
      await WifiCommand.createCommand(ApiMethodId.SET, ItemId.CameraFunction,
          params: [value.wifiValue]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<CameraFunctionValue> item =
              device.cameraSettings.cameraFunction;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///CapturePhoto (act)

  @override
  Future<ListInfoItem<StringValue>> actCapturePhoto() async =>
      await WifiCommand.createCommand(ApiMethodId.ACT, ItemId.CapturePhoto)
          .send(device)
          .then((result) {
        var jsonD = jsonDecode(result.response);
        var list = jsonD["result"][0];
        //TODo event -> same as postview urls
        List<StringValue> values =
            device.cameraSettings.capturePhoto.createListFromWifiJson(list);
        device.cameraSettings.capturePhoto.updateItem(values);
        return device.cameraSettings.capturePhoto;
      });

  @override
  Future<ListInfoItem<StringValue>> awaitCapturePhoto() async =>
      await WifiCommand.createCommand(ApiMethodId.AWAIT, ItemId.CapturePhoto)
          .send(device)
          .then((result) {
        var jsonD = jsonDecode(result.response);
        var list = jsonD["result"][0];
        //TODo event -> same as postview urls
        List<StringValue> values =
            device.cameraSettings.capturePhoto.createListFromWifiJson(list);
        device.cameraSettings.capturePhoto.updateItem(values);
        return device.cameraSettings.capturePhoto;
      });

  ///Camera Setup

  @override
  Future<bool> startRecMode() async =>
      await WifiCommand.createCommand(ApiMethodId.ACT, ItemId.CapturePhoto)
          .send(device)
          .then((result) => result.isValid);

  @override
  Future<bool> stopRecMode() async =>
      await WifiCommand.createCommand(ApiMethodId.AWAIT, ItemId.CapturePhoto)
          .send(device)
          .then((result) => result.isValid);

  /// FNumber

  @override
  Future<SettingsItem<DoubleValue>> getFNumber(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf<DoubleValue>(
          update, await super.getFNumber(update: update));

  @override
  Future<bool> modifyFNumber(int direction) async {
    var fNumber = await getFNumber();
    var currentIndex = fNumber.available
        .indexWhere((element) => element.wifiValue == fNumber.value.wifiValue);
    if ((currentIndex == 0 && direction == -1) ||
        (currentIndex == fNumber.available.length - 1 && direction == 1)) {
      return false; //would be out of range
    }
    var newIndex = currentIndex + direction;
    return setFNumber(fNumber.available[newIndex]);
  }

  @override
  Future<bool> setFNumber(DoubleValue value) async {
    return await WifiCommand.createCommand(ApiMethodId.SET, ItemId.FNumber,
        params: [value.wifiValue]).send(device).then((result) {
      if (result.isValid) {
        SettingsItem<DoubleValue> item = device.cameraSettings.fNumber;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  /// ISO
  @override
  Future<SettingsItem<IsoValue>> getIso({update = ForceUpdate.IfNull}) async =>
      await _updateIf<IsoValue>(update, await super.getIso(update: update));

  @override
  Future<bool> modifyIso(int direction) async {
    var iso = await getIso();
    var currentIndex = iso.available
        .indexWhere((element) => element.wifiValue == iso.value.wifiValue);
    if ((currentIndex == 0 && direction == -1) ||
        (currentIndex == iso.available.length - 1 && direction == 1)) {
      return false; //would be out of range
    }
    var newIndex = currentIndex + direction;
    return setIso(iso.available[newIndex]);
  }

  @override
  Future<bool> setIso(IsoValue value) async {
    return await WifiCommand.createCommand(ApiMethodId.SET, ItemId.ISO,
        params: [value.wifiValue]).send(device).then((result) {
      if (result.isValid) {
        SettingsItem<IsoValue> item = device.cameraSettings.iso;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  /// Shutter Speed
  ///
  @override
  Future<SettingsItem<ShutterSpeedValue>> getShutterSpeed(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getShutterSpeed(update: update));

  @override
  Future<bool> modifyShutterSpeed(int direction) async {
    var shutterSpeed = await getShutterSpeed();
    var currentIndex = shutterSpeed.available.indexWhere(
        (element) => element.wifiValue == shutterSpeed.value.wifiValue);
    if ((currentIndex == 0 && direction == -1) ||
        (currentIndex == shutterSpeed.available.length - 1 && direction == 1)) {
      return false; //would be out of range
    }
    var newIndex = currentIndex + direction;
    return setShutterSpeed(shutterSpeed.available[newIndex]);
  }

  @override
  Future<bool> setShutterSpeed(ShutterSpeedValue value) async {
    return await WifiCommand.createCommand(ApiMethodId.SET, ItemId.ShutterSpeed,
        params: [value.wifiValue]).send(device).then((result) {
      if (result.isValid) {
        SettingsItem<ShutterSpeedValue> item =
            device.cameraSettings.shutterSpeed;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///EV

  @override
  Future<SettingsItem<EvValue>> getExposureCompensation({update = ForceUpdate.IfNull}) async {
    SettingsItem<EvValue> settingsItem = device.cameraSettings.exposureCompensation;
    switch (update) {
      case ForceUpdate.Available:
        if (settingsItem.supported == null || settingsItem.supported.isEmpty) {
          //supported is necessary for available to now the step sizes
          await _updateSupported(settingsItem);
        }
        await _updateAvailable(settingsItem);
        break;
      case ForceUpdate.Supported:
        await _updateSupported(settingsItem);
        break;
      case ForceUpdate.Current:
        if (settingsItem.supported == null || settingsItem.supported.isEmpty) {
          //supported is necessary for available to now the step sizes
          await _updateSupported(settingsItem);
        }
        await _updateCurrent(settingsItem);
        break;
      case ForceUpdate.On:
        await _updateSupported(settingsItem);
        await _updateAvailable(settingsItem);
        break;
      case ForceUpdate.IfNull:
        if (settingsItem.available == null || settingsItem.available.isEmpty) {
          await _updateAvailable(settingsItem);
        }
        if (settingsItem.supported == null || settingsItem.supported.isEmpty) {
          await _updateSupported(settingsItem);
        }
        break;
    }

    return settingsItem;
  }

  @override
  Future<bool> modifyExposureCompensation(int direction) async {
    SettingsItem<EvValue> ev = await getExposureCompensation();
    var newItem = ev.available.firstWhere((element) => element.index == (ev.value.index + direction));
    if (newItem == null) {
      return false; //would be out of range
    }
    return _setExposureCompensationIndex(newItem);
  }

  @override
  Future<bool> setExposureCompensation(EvValue value) async => _setExposureCompensationIndex(value);

  Future<bool> _setExposureCompensationIndex(EvValue value) async {
    return await WifiCommand.createCommand(ApiMethodId.SET, ItemId.ExposureCompensation, params: [value.index])
        .send(device)
        .then((result) {
      if (result.isValid) {
        SettingsItem<EvValue> item = device.cameraSettings.exposureCompensation;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///FlashMode

  @override
  Future<SettingsItem<FlashModeValue>> getFlashMode(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getFlashMode(update: update));

  @override
  Future<bool> setFlashMode(FlashModeValue value) async {
    return await WifiCommand.createCommand(ApiMethodId.SET, ItemId.FlashMode,
        params: [value.wifiValue]).send(device).then((result) {
      if (result.isValid) {
        SettingsItem<FlashModeValue> item = device.cameraSettings.flashMode;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///FocusMode

  @override
  Future<SettingsItem<FocusModeValue>> getFocusMode(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getFocusMode(update: update));

  @override
  Future<bool> setFocusMode(FocusModeValue value) =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.FocusMode,
          params: [value.wifiValue]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<FocusModeValue> item = device.cameraSettings.focusMode;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Zoom Setting

  @override
  Future<SettingsItem<ZoomSettingValue>> getZoomSetting(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getZoomSetting(update: update));

  @override
  Future<bool> setZoomSetting(ZoomSettingValue value) async =>
      await WifiCommand.createCommand(ApiMethodId.SET, ItemId.ZoomSetting, params: [
        <String, dynamic>{'zoom': value.wifiValue}
      ]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<ZoomSettingValue> item = device.cameraSettings.zoomSetting;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Storage Information

  @override
  Future<ListInfoItem<StringValue>> getStorageInformation({update = ForceUpdate.IfNull}) async =>
      await _updateListInfoItem(await super.getStorageInformation(update: update));

  ///Zoom

  //direction: in/out  movementparameter: start, stop, 1shot -> when started, has to bee stopped with same direction param
  //zoom item in settions updated by event (availablesettings) only
  //TODO save direction and movement param in zoom settings item and autostop when reached end?
  @override
  Future<bool> actZoom(String direction, String movementparameter) async =>
      await WifiCommand.createCommand(ApiMethodId.ACT, ItemId.Zoom, params: [direction, movementparameter])
          .send(device)
          .then((result) => result.isValid);

  ///Half Press Shutter

  @override
  Future<bool> actHalfPressShutter() async => //TODO error if not cancelled?
      await WifiCommand.createCommand(ApiMethodId.ACT, ItemId.HalfPressShutter)
          .send(device)
          .then((result) {
        if (result.isValid) {
          InfoItem<BoolValue> item = device.cameraSettings.halfPressShutter;
          item.updateItem(BoolValue(true));
        }
        return result.isValid;
      });

  @override
  Future<bool> cancelHalfPressShutter() async => //TODO error if not act?
      await WifiCommand.createCommand(
              ApiMethodId.CANCEL, ItemId.HalfPressShutter)
          .send(device)
          .then((result) {
        if (result.isValid) {
          InfoItem<BoolValue> item = device.cameraSettings.halfPressShutter;
          item.updateItem(BoolValue(false));
        }
        return result.isValid;
      });

  ///Self Timer

  @override
  Future<SettingsItem<IntValue>> getSelfTimer(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getSelfTimer(update: update));

  @override
  Future<bool> setSelfTimer(IntValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.SelfTimer,
          params: [value.id]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<IntValue> item = device.cameraSettings.selfTimer;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Live View Size

  @override
  Future<SettingsItem<LiveViewSizeValue>> getLiveViewSize(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getLiveViewSize(update: update));

  @override
  Future<bool> startLiveViewWithSize(LiveViewSizeValue value) async =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.LiveViewWithSize,
          params: [value.wifiValue]).send(device).then((result) {
        if (result.isValid) {
          //TODO store url
          SettingsItem<LiveViewSizeValue> item =
              device.cameraSettings.liveViewSize;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Post View Image Size

  @override
  Future<SettingsItem<PostViewImageSizeValue>> getPostViewImageSize(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getPostViewImageSize(update: update));

  @override
  Future<bool> setPostViewImageSize(PostViewImageSizeValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.PostViewImageSize,
          params: [value.wifiValue]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<PostViewImageSizeValue> item =
              device.cameraSettings.postViewImageSize;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Program Shift

  @override
  Future<SettingsItem<IntValue>> getProgramShift(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getProgramShift(update: update));

  @override
  Future<bool> setProgramShift(IntValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.ProgramShift,
          params: [value.wifiValue]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<IntValue> item = device.cameraSettings.programShift;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///White Balance Mode

  @override
  Future<SettingsItem<WhiteBalanceModeValue>> getWhiteBalanceMode(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getWhiteBalanceMode(update: update));

  @override
  Future<bool> setWhiteBalanceMode(WhiteBalanceModeValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.WhiteBalanceMode,
              params: [value.wifiValue, false, 0])
          .send(device)
          .then((result) async {
        if (result.isValid) {
          SettingsItem<WhiteBalanceModeValue> item =
              device.cameraSettings.whiteBalanceMode;
          item.updateItem(value, item.available, item.supported);
        }

        await getWhiteBalanceColorTemp(update: ForceUpdate.Available);
        return result.isValid;
      });

  /// WhiteBalance Color Temp

  @override
  Future<SettingsItem<WhiteBalanceColorTempValue>> getWhiteBalanceColorTemp(
      {update = ForceUpdate.IfNull}) async {
    SettingsItem<WhiteBalanceColorTempValue> settingsItemWhiteColorTemp =
        await super.getWhiteBalanceColorTemp(update: update);

    SettingsItem<WhiteBalanceModeValue> settingsItemWhiteBalanceMode =
        await super.getWhiteBalanceMode(update: update);

    switch (update) {
      case ForceUpdate.Available:
        await _getAvailable(ItemId.WhiteBalanceMode).then((response) => device
            .cameraSettings
            .updateAvailable(settingsItemWhiteBalanceMode, response));
        break;
      case ForceUpdate.Supported:
        await _getSupported(ItemId.WhiteBalanceMode).then((response) => device
            .cameraSettings
            .updateSupported(settingsItemWhiteBalanceMode, response));
        break;
      case ForceUpdate.On:
        await _getSupported(ItemId.WhiteBalanceMode).then((response) => device
            .cameraSettings
            .updateSupported(settingsItemWhiteBalanceMode, response));
        await _getAvailable(ItemId.WhiteBalanceMode).then((response) => device
            .cameraSettings
            .updateAvailable(settingsItemWhiteBalanceMode, response));
        break;
      //TODO ForceUpdate.Current
      case ForceUpdate.IfNull:
        if (settingsItemWhiteColorTemp.available == null ||
            settingsItemWhiteColorTemp.available.isEmpty) {
          await _getAvailable(ItemId.WhiteBalanceMode).then((response) => device
              .cameraSettings
              .updateAvailable(settingsItemWhiteBalanceMode, response));
        }
        if (settingsItemWhiteColorTemp.supported == null ||
            settingsItemWhiteColorTemp.supported.isEmpty) {
          await _getSupported(ItemId.WhiteBalanceMode).then((response) => device
              .cameraSettings
              .updateSupported(settingsItemWhiteBalanceMode, response));
        }
        break;
    }

    return settingsItemWhiteColorTemp;
  }

  @override
  Future<bool> modifyWhiteBalanceColorTemp(int direction) async {
    SettingsItem<WhiteBalanceColorTempValue> temp =
        await getWhiteBalanceColorTemp();
    var newIndex = temp.available.indexWhere((element) =>
            element.id == temp.value.id &&
            element.whiteBalanceModeId == temp.value.whiteBalanceModeId) +
        direction;
    if (newIndex == temp.available.length || newIndex < 0) {
      return false;
    }
    return setWhiteBalanceColorTemp(temp.available[newIndex]);
  }

  @override
  Future<bool> setWhiteBalanceColorTemp(
      WhiteBalanceColorTempValue value) async {
    SettingsItem<WhiteBalanceModeValue> settingsItemWhiteBalanceMode =
        await super.getWhiteBalanceMode();

    return WifiCommand.createCommand(ApiMethodId.SET, ItemId.WhiteBalanceMode,
        params: [
          settingsItemWhiteBalanceMode.value.wifiValue,
          true,
          value.id
        ]).send(device).then((result) {
      if (result.isValid) {
        //TODO valid result but not actually working maybe?? (white balance not color temp but setting a color temp returns valid result)
        SettingsItem<WhiteBalanceColorTempValue> item =
            device.cameraSettings.whiteBalanceColorTemp;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///Image File Format

  @override
  Future<SettingsItem<ImageFileFormatValue>> getImageFileFormat(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getImageFileFormat(update: update));

  @override
  Future<bool> setImageFileFormat(ImageFileFormatValue value) async {
    return await WifiCommand.createCommand(
            ApiMethodId.SET, ItemId.ImageFileFormat, params: [value.wifiValue])
        .send(device)
        .then((result) {
      if (result.isValid) {
        SettingsItem<ImageFileFormatValue> item =
            device.cameraSettings.imageFileFormat;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///Silent Shooting

  @override
  Future<SettingsItem<OnOffValue>> getSilentShooting(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getSilentShooting(update: update));

  @override
  Future<bool> setSilentShooting(OnOffValue value) async {
    return await WifiCommand.createCommand(ApiMethodId.SET, ItemId.SilentShooting, params: [value.wifiValue])
        .send(device)
        .then((result) {
      if (result.isValid) {
        SettingsItem<OnOffValue> item = device.cameraSettings.silentShooting;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///Shoot Mode

  @override
  Future<SettingsItem<ShootModeValue>> getShootMode({update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getShootMode(update: update));

  @override
  Future<bool> setShootMode(ShootModeValue value) async {
    return await WifiCommand.createCommand(ApiMethodId.SET, ItemId.ShootMode, params: [value.wifiValue])
        .send(device)
        .then((result) {
      if (result.isValid) {
        SettingsItem<ShootModeValue> item = device.cameraSettings.shootMode;
        item.updateItem(value, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///Metering Mode TODO unsupported?

  @override
  Future<SettingsItem<MeteringModeValue>> getMeteringMode({update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getMeteringMode(update: update));

  @override
  Future<bool> setMeteringMode(MeteringModeValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.MeteringMode, params: [value.wifiValue])
          .send(device)
          .then((result) {
        if (result.isValid) {
          SettingsItem<MeteringModeValue> item = device.cameraSettings.meteringMode;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Continuous Shooting Mode

  @override
  Future<SettingsItem<ContShootingModeValue>> getContShootingMode({ForceUpdate update}) async =>
      await _updateIf(update, await super.getContShootingMode(update: update));

  @override
  Future<bool> setContShootingMode(ContShootingModeValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.ContShootingMode, params: [<String, dynamic>{'contShootingMode': value.wifiValue}])
          .send(device)
          .then((result) {
        if (result.isValid) {
          SettingsItem<ContShootingModeValue> item = device.cameraSettings.contShootingMode;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Continuous Shooting Speed

  @override
  Future<SettingsItem<ContShootingSpeedValue>> getContShootingSpeed({ForceUpdate update}) async =>
      await _updateIf(update, await super.getContShootingSpeed(update: update));

  @override
  Future<bool> setContShootingSpeed(ContShootingSpeedValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.ContShootingSpeed, params: [
        <String, dynamic>{'contShootingSpeed': value.wifiValue}
      ]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<ContShootingSpeedValue> item = device.cameraSettings.contShootingSpeed;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Image Size

  @override
  Future<SettingsItem<ImageSizeValue>> getImageSize({ForceUpdate update}) async =>
      await _updateIf(update, await super.getImageSize(update: update));

  @override
  Future<bool> setImageSize(ImageSizeValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.ImageSize, params: [
        //TODO current aspect ratio
        <String, dynamic>{'contShootingSpeed': value.wifiValue}
      ]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<ImageSizeValue> item = device.cameraSettings.imageSize;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Aspect Ratio

  @override
  Future<SettingsItem<AspectRatioValue>> getAspectRatio({ForceUpdate update}) async =>
      await _updateIf(update, await super.getAspectRatio(update: update)); //TODO update item id image size?

  @override
  Future<bool> setAspectRatio(AspectRatioValue value) async =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.AspectRatio, params: [
        //TODO current image Size
        <String, dynamic>{'contShootingSpeed': value.wifiValue}
      ]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<AspectRatioValue> item = device.cameraSettings.aspectRatio;
          item.updateItem(value, item.available, item.supported);
        }
        return result.isValid;
      });

  ///Continuous Shooting

  @override
  Future<bool> startContShooting() async =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.ContShooting).send(device).then((result) {
        if (result.isValid) {
          InfoItem<BoolValue> item = device.cameraSettings.contShooting;
          item.updateItem(BoolValue(true));
        }
        return result.isValid;
      });

  @override
  Future<bool> stopContShooting() async =>
      WifiCommand.createCommand(ApiMethodId.STOP, ItemId.ContShooting).send(device).then((result) {
        if (result.isValid) {
          InfoItem<BoolValue> item = device.cameraSettings.contShooting;
          item.updateItem(BoolValue(false));
        }
        return result.isValid;
      });

  ///Movie Recording

  @override
  Future<bool> startMovieRecording() async =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.MovieRecording).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.movieRecording.updateItem(BoolValue(true));
        }
        return result.isValid;
      });

  @override
  Future<bool> stopMovieRecording() async =>
      WifiCommand.createCommand(ApiMethodId.STOP, ItemId.MovieRecording).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.movieRecording.updateItem(BoolValue(false));
        }
        return result.isValid;
      });

  ///Audio Recording

  @override
  Future<bool> startAudioRecording() async =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.AudioRecording).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.audioRecording.updateItem(BoolValue(true));
        }
        return result.isValid;
      });

  @override
  Future<bool> stopAudioRecording() async =>
      WifiCommand.createCommand(ApiMethodId.STOP, ItemId.AudioRecording).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.audioRecording.updateItem(BoolValue(false));
        }
        return result.isValid;
      });

  ///Audio Recording

  @override
  Future<bool> startIntervalStillRecording() async =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.IntervalStillRecording).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.intervalStillRecording.updateItem(BoolValue(true));
        }
        return result.isValid;
      });

  @override
  Future<bool> stopIntervalStillRecording() async =>
      WifiCommand.createCommand(ApiMethodId.STOP, ItemId.IntervalStillRecording).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.intervalStillRecording.updateItem(BoolValue(false));
        }
        return result.isValid;
      });

  ///Loop Recording

  @override
  Future<bool> startLoopRecording() async =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.LoopRecording).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.loopRecording.updateItem(BoolValue(true));
        }
        return result.isValid;
      });

  @override
  Future<bool> stopLoopRecording() async =>
      WifiCommand.createCommand(ApiMethodId.STOP, ItemId.LoopRecording).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.loopRecording.updateItem(BoolValue(false));
        }
        return result.isValid;
      });

  ///Live View

  @override
  Future<bool> startLiveView() async =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.LiveView).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.liveView.updateItem(BoolValue(true)); //TODO url?
        }
        return result.isValid;
      });

  @override
  Future<bool> stopLiveView() async =>
      WifiCommand.createCommand(ApiMethodId.STOP, ItemId.LiveView).send(device).then((result) {
        if (result.isValid) {
          device.cameraSettings.liveView.updateItem(BoolValue(false));
        }
        return result.isValid;
      });


  //TODO

  @override
  Future<SettingsItem<BoolValue>> getAel({update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getAel(update: update));

  @override
  Future<SettingsItem<AutoFocusStateValue>> getAutoFocusState(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getAutoFocusState(update: update));

  @override
  Future<int> getBatteryPercentage({update = ForceUpdate.IfNull}) {
    //TODO only get
  }

  @override
  Future<SettingsItem<DriveModeValue>> getDriveMode(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getDriveMode(update: update));

  @override
  Future<SettingsItem<DroHdrValue>> getDroHdr(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getDroHdr(update: update));

  @override
  Future<SettingsItem<BoolValue>> getFel({update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getFel(update: update));

  @override
  Future<SettingsItem<IntValue>> getFlashValue(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getFlashValue(update: update));

  @override
  Future<SettingsItem<FocusAreaValue>> getFocusArea(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getFocusArea(update: update));

  @override
  Future<SettingsItem<PointValue>> getFocusAreaSpot(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getFocusAreaSpot(update: update));

  @override
  Future<SettingsItem<DoubleValue>> getFocusMagnifier(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getFocusMagnifier(update: update));

  @override
  Future<SettingsItem<FocusMagnifierDirectionValue>> getFocusMagnifierDirection(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(
          update, await super.getFocusMagnifierDirection(update: update));

  @override
  Future<SettingsItem<FocusMagnifierPhaseValue>> getFocusMagnifierPhase(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(
          update, await super.getFocusMagnifierPhase(update: update));

  @override
  Future<SettingsItem<FocusModeToggleValue>> getFocusModeToggle(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getFocusModeToggle(update: update));

  @override
  Future<bool> getPhotoAvailable({update = ForceUpdate.IfNull}) {
    // TODO: implement getPhotoAvailable
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<PictureEffectValue>> getPictureEffect(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getPictureEffect(update: update));


  @override
  Future<SettingsItem<WhiteBalanceAbValue>> getWhiteBalanceAb(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getWhiteBalanceAb(update: update));

  @override
  Future<SettingsItem<WhiteBalanceGmValue>> getWhiteBalanceGm(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getWhiteBalanceGm(update: update));

  @override
  Future<bool> pressShutter(ShutterPressType shutterPressType) {
    // TODO: implement pressShutter
    throw UnimplementedError();
  }

  @override
  Future<bool> releaseShutter(ShutterPressType shutterPressType) {
    // TODO: implement releaseShutter
    throw UnimplementedError();
  }

  @override
  Future<CameraImageRequest> requestPhotoAvailable({bool liveView = false}) {
    // TODO: implement requestPhotoAvailable
    throw UnimplementedError();
  }

  @override
  Future<bool> setAel(bool value) {
    // TODO: implement setAel
    throw UnimplementedError();
  }

  @override
  Future<bool> setDriveMode(DriveModeId value) {
    // TODO: implement setDriveMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setDroHdr(DroHdrId value) {
    // TODO: implement setDroHdr
    throw UnimplementedError();
  }

  @override
  Future<bool> setFel(bool value) {
    // TODO: implement setFel
    throw UnimplementedError();
  }

  @override
  Future<bool> setFlashValue(int value) {
    // TODO: implement setFlashValue
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusArea(FocusAreaId value) {
    // TODO: implement setFocusArea
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusAreaSpot(Point<num> value) {
    // TODO: implement setFocusAreaSpot
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusDistance(int value) {
    // TODO: implement setFocusDistance
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifier(double value) {
    // TODO: implement setFocusMagnifier
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps) {
    // TODO: implement setFocusMagnifierDirection
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifierPhase(FocusMagnifierPhaseId value) {
    // TODO: implement setFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusModeToggle(FocusModeToggleId value) {
    // TODO: implement setFocusModeToggle
    throw UnimplementedError();
  }


  @override
  Future<bool> setPictureEffect(PictureEffectId value) {
    // TODO: implement setPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<bool> setSettingsRaw(ItemId id, int value) {
    // TODO: implement setSettingsRaw
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value) {
    // TODO: implement setWhiteBalanceAb
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value) {
    // TODO: implement setWhiteBalanceGm
    throw UnimplementedError();
  }

  @override
  Future<bool> startRecordingVideo() =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.RecordVideo)
          .send(device)
          .then((value) => value.response == "true");

  @override
  Future<bool> stopRecordingVideo() =>
      WifiCommand.createCommand(ApiMethodId.STOP, ItemId.RecordVideo)
          .send(device)
          .then((value) => value.response == "true");

  /// This API provides a function to start audio recording.
  ///
  ///
  /// This API instructs the server side to start audio recording.
  /// When this API is called and the server starts audio recording,
  /// the camera status will change as follows.
  /// The camera status can be obtained by [EventNotificationApi.getEvent].
  ///
  ///
  /// [Client calls this]
  ///
  ///
  /// Camera status: [CameraShootingStatusParam.IDLE] <br></br>
  /// -> [CameraShootingStatusParam.AudioWaitRecStart] <br></br>
  /// -> [CameraShootingStatusParam.AudioRecording].
  ///
  ///
  /// After the recording has started, the client may stop the recording.
  /// To stop the recording, [.stopAudioRec] must be called,
  /// and the camera status will change as follows.
  ///
  ///
  /// [Client calls [.stopAudioRec]]
  ///
  ///
  /// Camera status: [CameraShootingStatusParam.AudioRecording]
  /// -> [CameraShootingStatusParam.AudioWaitRecStop]
  /// -> [CameraShootingStatusParam.AudioSaving]
  /// -> [CameraShootingStatusParam.IDLE].
  ///
  ///
  /// Note that this sequence is the example of typical case.
  ///
  ///
  /// The client should check the [EventNotificationApi.getEvent]
  /// parameter ([Event.cameraStatus]) and check if it is [CameraShootingStatusParam.IDLE]
  /// before calling this.
  ///
  ///
  /// This API is only available when the shoot mode is [ShootModeParam.Audio].
  ///
  ///
  /// Note that the server may disable the liveview function when the
  /// shoot mode is [ShootModeParam.Audio].
  /// The client should check liveview availability by [Event.liveViewStatus] of
  /// [EventNotificationApi.getEvent].
  /// The APIs availability will also be changed.
  /// The client should check the APIs availability by available API list.
  /// When the client switches the shoot mode from [ShootModeParam.Audio] to others,
  /// the client can restart the liveview by calling [LiveViewApi.startLiveView].
  ///
  ///
  /// @return see [ApiCallSet]
  @override
  Future<bool> startRecordingAudio() =>
      WifiCommand.createCommand(ApiMethodId.START, ItemId.AudioRecording)
          .send(device)
          .then((value) => value.response == "true");

  /// This API provides a function to stop audio recording.
  ///
  ///
  /// This API is only available when the shoot mode is [ShootModeParam.Audio].
  /// Even if this API is successful, the server may not be ready to start the next recording.
  /// The next recording is prohibited until the client could make sure,
  /// that the server is ready to start the next recording, through the
  /// [EventNotificationApi.getEvent] callback parameter [Event.cameraStatus].
  ///
  ///
  /// @return see [ApiCallSet]
  @override
  Future<bool> stopRecordingAudio() =>
      WifiCommand.createCommand(ApiMethodId.STOP, ItemId.AudioRecording)
          .send(device)
          .then((value) => value.response == "true");

  /// This API provides a function to set a value of audio recording setting.
  ///
  ///
  /// Even if the response is successful, the setting may not be finished on the server.
  /// Therefore, the client can check [Event.audioRecordingSetting] result in
  /// [EventNotificationApi.getEvent] callback to recognize the timing of a change
  /// in the parameter of the server.
  ///
  ///
  /// @param audioRecordingSetting Audio recording setting
  /// (See Audio recording setting parameters of Parameter description)
  /// @return see [ApiCallSet]
  @override
  Future<bool> setRecordingAudio(String audioRecordingSetting) =>
      WifiCommand.createCommand(ApiMethodId.SET, ItemId.AudioRecording,
              params: [audioRecordingSetting])
          .send(device)
          .then((value) => value.response == "true");

  @override
  Future<SettingsItem<StringValue>> getRecordingAudio(
      {update = ForceUpdate.IfNull}) {
    // TODO: implement setFocusMode
    throw UnimplementedError();
  }

  @override
  Future<RecordVideoStateValue> getRecordingVideoState({ForceUpdate update}) {
    // TODO: implement getRecordingVideoState
    throw UnimplementedError();
  }

  //update for the getters
  //TODO update only current?? (if developer only wants to show things without change no need for supported)
  Future<SettingsItem<T>> _updateIf<T extends Value>(
      ForceUpdate update, SettingsItem settingsItem) async {
    switch (update) {
      case ForceUpdate.Available:
        await _updateAvailable(settingsItem);
        break;
      case ForceUpdate.Supported:
        await _updateSupported(settingsItem);
        break;
      case ForceUpdate.Current:
        await _updateCurrent(settingsItem);
        break;
      case ForceUpdate.On:
        await _updateSupported(settingsItem);
        await _updateAvailable(settingsItem);
        break;
      case ForceUpdate.IfNull:
        if (settingsItem.available == null || settingsItem.available.isEmpty) {
          await _updateAvailable(settingsItem);
        }
        if (settingsItem.supported == null || settingsItem.supported.isEmpty) {
          await _updateSupported(settingsItem);
        }
        break;
    }

    return settingsItem;
  }

  Future _updateCurrent(SettingsItem settingsItem) async {
    //TODO
    return await _get(settingsItem.itemId)
        .then((response) => throw UnimplementedError());
  }

  Future _updateListInfoItem(ListInfoItem listInfoItem) async =>
      await WifiCommand.createCommand(ApiMethodId.GET, listInfoItem.itemId)
          .send(device)
          .then((wifiResponse) => wifiResponse.response)
          .then((response) =>
              device.cameraSettings.updateListInfoItem(listInfoItem, response));

  Future _updateAvailable(SettingsItem settingsItem) async {
    if (checkFunctionAvailability(
            settingsItem.itemId, ApiMethodId.GET_AVAILABLE) ==
        FunctionAvailability.Available) {
      return await _getAvailable(settingsItem.itemId).then((response) =>
          device.cameraSettings.updateAvailable(settingsItem, response));
    }
    return;
  }

  Future _updateSupported(SettingsItem settingsItem) async {
    if (checkFunctionAvailability(
            settingsItem.itemId, ApiMethodId.GET_AVAILABLE) ==
        FunctionAvailability.Available) {
      return await _getSupported(settingsItem.itemId).then((response) =>
          device.cameraSettings.updateSupported(settingsItem, response));
    }
    return;
  }

  Future<String> _getSupported(ItemId settingsId) async {
    return await WifiCommand.createCommand(
            ApiMethodId.GET_SUPPORTED, settingsId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response);
  }

  Future<String> _getAvailable(ItemId settingsId) async {
    return await WifiCommand.createCommand(
            ApiMethodId.GET_AVAILABLE, settingsId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response);
  }

  Future<String> _get(ItemId settingsId) async {
    return await WifiCommand.createCommand(ApiMethodId.GET, settingsId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response);
  }

  @override
  FunctionAvailability checkFunctionAvailability(
      ItemId itemId, ApiMethodId apiMethodId,
      {SonyWebApiServiceTypeId service = SonyWebApiServiceTypeId.CAMERA}) {
    FunctionAvailability functionAvailability = FunctionAvailability.Unsupported;

    if (itemId == ItemId.AspectRatio) {
      itemId = ItemId.ImageSize; // paired together
    }

    //check sonyWebApiServiceTypeId first
    if (device.getWebApiService(service) != null) {
      if (itemId == ItemId.Versions || itemId == ItemId.MethodTypes) {
        //for versions function or MethodTypes the method Types function is not yet executed
        return FunctionAvailability.Available;
      }
      //check itemId and apiMethodId
      //TODO initialized flag?
      ListInfoItem listInfoItem;
      switch (service) {
        case SonyWebApiServiceTypeId.CAMERA:
          listInfoItem = device.cameraSettings.methodTypesCamera;
          break;
        case SonyWebApiServiceTypeId.AV_CONTENT:
          listInfoItem = device.cameraSettings.methodTypesAvContent;
          break;
        case SonyWebApiServiceTypeId.SYSTEM:
          listInfoItem = device.cameraSettings.methodTypesSystem;
          break;
        case SonyWebApiServiceTypeId.GUIDE:
          listInfoItem = device.cameraSettings.methodTypesGuide;
          break;
        case SonyWebApiServiceTypeId.ACCESS_CONTROL:
          listInfoItem = device.cameraSettings.methodTypesAccessControl;
          break;
        case SonyWebApiServiceTypeId.Unknown:
        default:
          throw UnsupportedError;
      }

      WebApiMethodValue webApiMethod = listInfoItem.values.firstWhere(
          (element) =>
              element.id.settingsId == itemId &&
              element.id.apiName == apiMethodId,
          orElse: () => null);
      if (webApiMethod != null) {
        functionAvailability = FunctionAvailability.Supported;
      }
    }

    if (functionAvailability == FunctionAvailability.Supported) {
      if (itemId == ItemId.ApiList) {
        return FunctionAvailability.Available;
      }
      if (service == SonyWebApiServiceTypeId.CAMERA) {
        //now check if available
        ListInfoItem<ApiFunctionValue> functions =
            device.cameraSettings.availableFunctions;
        ApiFunctionValue apiFunctionValue = functions.values.firstWhere(
            (element) =>
                element.id == itemId && element.methods.contains(apiMethodId),
            orElse: () => null);

        if (apiFunctionValue != null) {
          return FunctionAvailability.Available;
        }
      } else {
        //all functions that are supported and not from "camera" are available (i hope)
        return FunctionAvailability.Available;
      }
    }

    return functionAvailability;
  }
}
