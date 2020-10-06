import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/api/force_update.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_direction_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/record_video_state_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_api_method_set.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
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

  //TOdo servicetypeid null _> all else only one
  Future<SettingsItem<WebApiVersionsValue>> getWebApiVersions(
      SonyWebApiServiceTypeId serviceTypeId,
      {update = ForceUpdate.IfNull}) async {
    var settingsItem = await super.getWebApiVersions(serviceTypeId);

    switch (update) {
      case ForceUpdate.Available:
      case ForceUpdate.Supported:
      case ForceUpdate.IfNull:
        if (settingsItem.supported == null ||
            settingsItem.supported.isEmpty ||
            settingsItem.available == null ||
            settingsItem.available.isEmpty) {
          //supported is necessary for available to now the step sizes
          await _getWebApiVersions(settingsItem, serviceTypeId);
        }
        break;
      case ForceUpdate.Current:
      case ForceUpdate.On:
        await _getWebApiVersions(settingsItem, serviceTypeId);
        break;
    }
    return await super.getWebApiVersions(serviceTypeId);
  }

  Future _getWebApiVersions(
      SettingsItem settingsItem, SonyWebApiServiceTypeId serviceTypeId) async {
    return await WifiCommand.createCommand(
            SonyWebApiMethodId.GET, SettingsId.MethodTypes,
            service: serviceTypeId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response)
        .then((response) =>
            device.cameraSettings.updateCurrent(settingsItem, response));
  }

  //TODO web api version wenn keine angegeben für alle
  //WebApiVersionId webApiVersion,
  //wip
  Future<SettingsItem<WebApiMethodValue>> getMethodTypes(
      {SonyWebApiServiceTypeId serviceTypeId,
      WebApiVersionId webApiVersion,
      update = ForceUpdate.IfNull}) async {
    var settingsItem = await super.getMethodTypes();

    switch (update) {
      case ForceUpdate.Available:
      case ForceUpdate.Supported:
        if (settingsItem.supported == null ||
            settingsItem.supported.isEmpty ||
            settingsItem.available == null ||
            settingsItem.available.isEmpty) {
          if (webApiVersion != null) {
            //supported is necessary for available to now the step sizes
            await _getMethodTypes(settingsItem, webApiVersion);
          } else {}
        }
        break;
      case ForceUpdate.Current:
      case ForceUpdate.IfNull:
      //TODO null für eine unterstützte web api version, oder für diese unterstützte web api version?
      case ForceUpdate.On:
        await _getMethodTypes(settingsItem, webApiVersion);
        break;
    }
    return await super.getMethodTypes();
  }

  Future _getMethodTypes(
      SettingsItem settingsItem, WebApiVersionId webApiVersion) async {
    return await WifiCommand.createCommand(
            SonyWebApiMethodId.GET, SettingsId.MethodTypes,
            params: [webApiVersion.wifiValue])
        .send(device)
        .then((wifiResponse) => wifiResponse.response)
        .then((response) =>
            device.cameraSettings.updateCurrent(settingsItem, response));
  }

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
    return await WifiCommand.createCommand(
        SonyWebApiMethodId.SET, SettingsId.FNumber,
        params: [value.wifiValue]).send(device).then((result) {
      if (result.isValid) {
        SettingsItem<DoubleValue> item =
            device.cameraSettings.getItem<DoubleValue>(SettingsId.FNumber);
        item.updateItem(value, item.subValue, item.available, item.supported);
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
    return await WifiCommand.createCommand(
            SonyWebApiMethodId.SET, SettingsId.ISO, params: [value.wifiValue])
        .send(device)
        .then((result) {
      if (result.isValid) {
        SettingsItem<IsoValue> item =
            device.cameraSettings.getItem<IsoValue>(SettingsId.ISO);
        item.updateItem(value, item.subValue, item.available, item.supported);
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
    return await WifiCommand.createCommand(
        SonyWebApiMethodId.SET, SettingsId.ShutterSpeed,
        params: [value.wifiValue]).send(device).then((result) {
      if (result.isValid) {
        SettingsItem<ShutterSpeedValue> item = device.cameraSettings
            .getItem<ShutterSpeedValue>(SettingsId.ShutterSpeed);
        item.updateItem(value, item.subValue, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///EV

  @override
  Future<SettingsItem<EvValue>> getEV({update = ForceUpdate.IfNull}) async {
    SettingsItem<EvValue> settingsItem =
        device.cameraSettings.getItem<EvValue>(SettingsId.EV);
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

    return device.cameraSettings.getItem(settingsItem.settingsId);
  }

  @override
  Future<bool> modifyEV(int direction) async {
    SettingsItem<EvValue> ev = await getEV();
    var newItem = ev.available
        .firstWhere((element) => element.index == (ev.value.index + direction));
    if (newItem == null) {
      return false; //would be out of range
    }
    return _setEVIndex(newItem);
  }

  @override
  Future<bool> setEV(EvValue value) async => _setEVIndex(value);

  Future<bool> _setEVIndex(EvValue value) async {
    return await WifiCommand.createCommand(
            SonyWebApiMethodId.SET, SettingsId.EV, params: [value.index])
        .send(device)
        .then((result) {
      if (result.isValid) {
        SettingsItem<EvValue> item =
            device.cameraSettings.getItem<EvValue>(SettingsId.EV);
        item.updateItem(value, item.subValue, item.available, item.supported);
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
    return await WifiCommand.createCommand(
        SonyWebApiMethodId.SET, SettingsId.FlashMode,
        params: [value.wifiValue]).send(device).then((result) {
      if (result.isValid) {
        SettingsItem<FlashModeValue> item =
            device.cameraSettings.getItem<FlashModeValue>(SettingsId.FlashMode);
        item.updateItem(value, item.subValue, item.available, item.supported);
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
      WifiCommand.createCommand(SonyWebApiMethodId.SET, SettingsId.FocusMode,
          params: [value.wifiValue]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<FocusModeValue> item = device.cameraSettings
              .getItem<FocusModeValue>(SettingsId.FocusMode);
          item.updateItem(value, item.subValue, item.available, item.supported);
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
      WifiCommand.createCommand(
              SonyWebApiMethodId.SET, SettingsId.WhiteBalanceMode,
              params: [value.wifiValue, false, 0])
          .send(device)
          .then((result) async {
        if (result.isValid) {
          SettingsItem<WhiteBalanceModeValue> item = device.cameraSettings
              .getItem<WhiteBalanceModeValue>(SettingsId.WhiteBalanceMode);
          item.updateItem(value, item.subValue, item.available, item.supported);
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
        await _getAvailable(SettingsId.WhiteBalanceMode).then((response) =>
            device.cameraSettings
                .updateAvailable(settingsItemWhiteBalanceMode, response));
        break;
      case ForceUpdate.Supported:
        await _getSupported(SettingsId.WhiteBalanceMode).then((response) =>
            device.cameraSettings
                .updateSupported(settingsItemWhiteBalanceMode, response));
        break;
      case ForceUpdate.On:
        await _getSupported(SettingsId.WhiteBalanceMode).then((response) =>
            device.cameraSettings
                .updateSupported(settingsItemWhiteBalanceMode, response));
        await _getAvailable(SettingsId.WhiteBalanceMode).then((response) =>
            device.cameraSettings
                .updateAvailable(settingsItemWhiteBalanceMode, response));
        break;
      //TODO ForceUpdate.Current
      case ForceUpdate.IfNull:
        if (settingsItemWhiteColorTemp.available == null ||
            settingsItemWhiteColorTemp.available.isEmpty) {
          await _getAvailable(SettingsId.WhiteBalanceMode).then((response) =>
              device.cameraSettings
                  .updateAvailable(settingsItemWhiteBalanceMode, response));
        }
        if (settingsItemWhiteColorTemp.supported == null ||
            settingsItemWhiteColorTemp.supported.isEmpty) {
          await _getSupported(SettingsId.WhiteBalanceMode).then((response) =>
              device.cameraSettings
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

    return WifiCommand.createCommand(
        SonyWebApiMethodId.SET, SettingsId.WhiteBalanceMode, params: [
      settingsItemWhiteBalanceMode.value.wifiValue,
      true,
      value.id
    ]).send(device).then((result) {
      if (result.isValid) {
        //TODO valid result but not actually working maybe?? (white balance not color temp but setting a color temp returns valid result)
        SettingsItem<WhiteBalanceColorTempValue> item = device.cameraSettings
            .getItem<WhiteBalanceColorTempValue>(
                SettingsId.WhiteBalanceColorTemp);
        item.updateItem(value, item.subValue, item.available, item.supported);
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
        SonyWebApiMethodId.SET, SettingsId.ImageFileFormat,
        params: [value.wifiValue]).send(device).then((result) {
      if (result.isValid) {
        SettingsItem<ImageFileFormatValue> item = device.cameraSettings
            .getItem<ImageFileFormatValue>(SettingsId.ImageFileFormat);
        item.updateItem(value, item.subValue, item.available, item.supported);
      }
      return result.isValid;
    });
  }

  ///Metering Mode TODO unsupported?

  @override
  Future<SettingsItem<MeteringModeValue>> getMeteringMode(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getMeteringMode(update: update));

  @override
  Future<bool> setMeteringMode(MeteringModeValue value) =>
      WifiCommand.createCommand(SonyWebApiMethodId.SET, SettingsId.MeteringMode,
          params: [value.wifiValue]).send(device).then((result) {
        if (result.isValid) {
          SettingsItem<MeteringModeValue> item = device.cameraSettings
              .getItem<MeteringModeValue>(SettingsId.MeteringMode);
          item.updateItem(value, item.subValue, item.available, item.supported);
        }
        return result.isValid;
      });

  //TODO

  @override
  Future<SettingsItem<BoolValue>> getAel({update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getAel(update: update));

  @override
  Future<SettingsItem<AspectRatioValue>> getAspectRatio(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getAspectRatio(update: update));

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
  Future<SettingsItem<ImageSizeValue>> getImageSize(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getImageSize(update: update));

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
  Future<SettingsItem<DriveModeValue>> getShootingMode(
          {update = ForceUpdate.IfNull}) async =>
      await _updateIf(update, await super.getShootingMode(update: update));

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
  Future<bool> setAspectRatio(AspectRatioId value) {
    // TODO: implement setAspectRatio
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
  Future<bool> setImageSize(ImageSizeId value) {
    // TODO: implement setImageSize
    throw UnimplementedError();
  }

  @override
  Future<bool> setPictureEffect(PictureEffectId value) {
    // TODO: implement setPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<bool> setSettingsRaw(SettingsId id, int value) {
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
  Future<bool> startRecordingVideo() => WifiCommand.createCommand(
          SonyWebApiMethodId.START, SettingsId.RecordVideo)
      .send(device)
      .then((value) => value.response == "true");

  @override
  Future<bool> stopRecordingVideo() =>
      WifiCommand.createCommand(SonyWebApiMethodId.STOP, SettingsId.RecordVideo)
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
  Future<bool> startRecordingAudio() => WifiCommand.createCommand(
          SonyWebApiMethodId.START, SettingsId.AudioRecording)
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
  Future<bool> stopRecordingAudio() => WifiCommand.createCommand(
          SonyWebApiMethodId.STOP, SettingsId.AudioRecording)
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
      WifiCommand.createCommand(
              SonyWebApiMethodId.SET, SettingsId.AudioRecording,
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

  @override
  Stream<Image> streamLiveView() {
    // TODO: implement streamLiveView
    throw UnimplementedError();
  }

  //update for the getters
  //TODO update only current?? (if developer only wants to show things without change no need for supported)
  Future<SettingsItem<T>> _updateIf<T extends SettingsValue>(
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

    return device.cameraSettings.getItem(settingsItem.settingsId);
  }

  Future _updateCurrent(SettingsItem settingsItem) async {
    return await _getCurrent(settingsItem.settingsId).then((response) =>
        device.cameraSettings.updateCurrent(settingsItem, response));
  }

  Future _updateAvailable(SettingsItem settingsItem) async {
    return await _getAvailable(settingsItem.settingsId).then((response) =>
        device.cameraSettings.updateAvailable(settingsItem, response));
  }

  Future _updateSupported(SettingsItem settingsItem) async {
    return await _getSupported(settingsItem.settingsId).then((response) =>
        device.cameraSettings.updateSupported(settingsItem, response));
  }

  Future<String> _getSupported(SettingsId settingsId) async {
    return await WifiCommand.createCommand(
            SonyWebApiMethodId.GET_SUPPORTED, settingsId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response);
  }

  Future<String> _getAvailable(SettingsId settingsId) async {
    return await WifiCommand.createCommand(
            SonyWebApiMethodId.GET_AVAILABLE, settingsId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response);
  }

  Future<String> _getCurrent(SettingsId settingsId) async {
    return await WifiCommand.createCommand(SonyWebApiMethodId.GET, settingsId)
        .send(device)
        .then((wifiResponse) => wifiResponse.response);
  }
}
