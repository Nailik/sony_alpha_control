import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutterusb/Command.dart';
import 'package:flutterusb/Response.dart';
import 'package:flutterusb/flutter_usb.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/auto_focus_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_direction_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/top_level_api/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/sony_camera_usb_device.dart';

import 'commands.dart';

class SonyUsbApi extends ApiInterface {
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
  Future<List<SonyCameraUsbDevice>> getAvailableCameras() {
    return FlutterUsb.getUsbDevices
        .then((value) => value.map((e) => new SonyCameraUsbDevice(e)).toList());
  }

  @override
  Future<bool> connectToCamera(SonyCameraDevice device) async {
    SonyCameraUsbDevice usbDevice = device as SonyCameraUsbDevice;
    await FlutterUsb.connectToUsbDevice(usbDevice.device);
    await FlutterUsb.sendCommand(Command(Commands.Connect));
    return true;
  }

  Future<bool> setSettings(
      SettingsId settingsId, int value, SonyCameraUsbDevice device) async {
    switch (settingsId) {
      case SettingsId.FileFormat:
        return setImageFileFormat(getImageFileFormatId(value), device);
      case SettingsId.WhiteBalance:
        return setWhiteBalance(getWhiteBalanceId(value), device);
      case SettingsId.FNumber:
        return setFNumber(value, device);
      case SettingsId.FocusMode:
        return setFocusMode(getFocusModeId(value), device);
      case SettingsId.MeteringMode:
        return setMeteringMode(getMeteringModeId(value), device);
      case SettingsId.FlashMode:
        return setFlashMode(getFlashModeId(value), device);
      case SettingsId.ShootingMode:
        // TODO: Handle this case.
        break;
      case SettingsId.EV:
        // TODO: Handle this case.
        break;
      case SettingsId.DriveMode:
        return setDriveMode(getDriveModeId(value), device);
      case SettingsId.Flash:
        return setFlashMode(getFlashModeId(value), device);
      case SettingsId.DroHdr:
        // TODO: Handle this case.
        break;
      case SettingsId.ImageSize:
        // TODO: Handle this case.
        break;
      case SettingsId.ShutterSpeed:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD20E:
        // TODO: Handle this case.
        break;
      case SettingsId.WhiteBalanceColorTemp:
        // TODO: Handle this case.
        break;
      case SettingsId.WhiteBalanceGM:
        // TODO: Handle this case.
        break;
      case SettingsId.AspectRatio:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD212:
        return false;
      case SettingsId.AutoFocusState:
        // TODO: Handle this case.
        break;
      case SettingsId.Zoom:
        // TODO: Handle this case.
        break;
      case SettingsId.PhotoTransferQueue:
        // TODO: Handle this case.
        break;
      case SettingsId.AEL_State:
        // TODO: Handle this case.
        break;
      case SettingsId.BatteryInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.SensorCrop:
        // TODO: Handle this case.
        break;
      case SettingsId.PictureEffect:
        // TODO: Handle this case.
        break;
      case SettingsId.WhiteBalanceAB:
        // TODO: Handle this case.
        break;
      case SettingsId.RecordVideoState:
        // TODO: Handle this case.
        break;
      case SettingsId.ISO:
        // TODO: Handle this case.
        break;
      case SettingsId.FEL_State:
        // TODO: Handle this case.
        break;
      case SettingsId.LiveViewState:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD222:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusArea:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierPhase:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD22E:
        return false;
      case SettingsId.FocusMagnifier:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierPosition:
        // TODO: Handle this case.
        break;
      case SettingsId.UseLiveViewDisplayEffect:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusAreaSpot:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierState:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusModeToggleResponse:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD236:
        return false;
      case SettingsId.HalfPressShutter:
        // TODO: Handle this case.
        break;
      case SettingsId.CapturePhoto:
        // TODO: Handle this case.
        break;
      case SettingsId.AEL:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2C5:
        return false;
      case SettingsId.UnkD2C7:
        return false;
      case SettingsId.RecordVideo:
        // TODO: Handle this case.
        break;
      case SettingsId.FEL:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierResetRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierMoveUpRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierMoveDownRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierMoveLeftRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierMoveRightRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusDistance:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusModeToggleRequest:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2D3:
        return false;
      case SettingsId.UnkD2D4:
        return false;
      case SettingsId.Unknown:
        return false;
    }
    return false;
  }

  @override
  Future<bool> pressShutter(
      ShutterPressType shutterPressType, SonyCameraDevice device) async {
    Response response;
    switch (shutterPressType) {
      case ShutterPressType.Half:
        response = await FlutterUsb.sendCommand(Command(
            Commands.getCommandMainSettingI16(SettingsId.HalfPressShutter, 2)));
        break;
      case ShutterPressType.Full:
        response = await FlutterUsb.sendCommand(Command(
            Commands.getCommandMainSettingI16(SettingsId.CapturePhoto, 2)));
        break;
      case ShutterPressType.Both:
        response = await FlutterUsb.sendCommand(Command(
            Commands.getCommandMainSettingI16(SettingsId.HalfPressShutter, 2)));
        response = await FlutterUsb.sendCommand(Command(
            Commands.getCommandMainSettingI16(SettingsId.CapturePhoto, 2)));
        break;
    }
  }

  @override
  Future<bool> releaseShutter(
      ShutterPressType shutterPressType, SonyCameraDevice device) async {
    Response response;
    switch (shutterPressType) {
      case ShutterPressType.Half:
        response = await FlutterUsb.sendCommand(Command(
            Commands.getCommandMainSettingI16(SettingsId.HalfPressShutter, 1)));
        break;
      case ShutterPressType.Full:
        response = await FlutterUsb.sendCommand(Command(
            Commands.getCommandMainSettingI16(SettingsId.CapturePhoto, 1)));
        break;
      case ShutterPressType.Both:
        response = await FlutterUsb.sendCommand(Command(
            Commands.getCommandMainSettingI16(SettingsId.HalfPressShutter, 1)));
        response = await FlutterUsb.sendCommand(Command(
            Commands.getCommandMainSettingI16(SettingsId.CapturePhoto, 1)));
        break;
    }
  }

  @override
  Future<bool> setSettingsRaw(int id, int value, SonyCameraDevice device) {
    return setSettings(getSettingsId(id), value, device);
  }

  @override
  Future<bool> capturePhoto(SonyCameraDevice device) async {
    await pressShutter(ShutterPressType.Both, device);
    await releaseShutter(ShutterPressType.Both, device);
    //read photo
    await device.cameraSettings.update();
    var item = device.cameraSettings.settings.firstWhere(
        (element) => element.id == SettingsId.PhotoTransferQueue.value);

    if (item != null) {
      int num = item.value & 0xFF;
      bool photoAvailableForTransfer = ((item.value >> 8) & 0xFF) == 0x80;
      print(num);
      if (photoAvailableForTransfer) {
        print("GetImage");
        var image = await GetImage(false);
      //  Image.memory(image);
        print("saveFile");
        File file = new File("C:\\Users\\kilia\\Desktop\\test.jpg");
        file.writeAsBytesSync(image);
        file = new File("C:\\Users\\kilia\\Desktop\\test.ARW");
        file.writeAsBytesSync(image);
      }
    }
  }

  @override
  Future<SettingsItem<bool>> getAel(SonyCameraDevice device) {
    // TODO: implement getAel
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<AspectRatioId>> getAspectRatio(SonyCameraDevice device) {
    // TODO: implement getAspectRatio
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<AutoFocusStateId>> getAutoFocusState(
      SonyCameraDevice device) {
    // TODO: implement getAutoFocusState
    throw UnimplementedError();
  }

  @override
  Future<int> getBatteryPercentage(SonyCameraDevice device) {
    // TODO: implement getBatteryPercentage
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DriveModeId>> getDriveMode(SonyCameraDevice device) {
    // TODO: implement getDriveMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DroHdrId>> getDroHdr(SonyCameraDevice device) {
    // TODO: implement getDroHdr
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<double>> getEV(SonyCameraDevice device) {
    // TODO: implement getEV
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<int>> getFNumber(SonyCameraDevice device) {
    // TODO: implement getFNumber
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<bool>> getFel(SonyCameraDevice device) {
    // TODO: implement getFel
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FlashModeId>> getFlashMode(SonyCameraDevice device) {
    // TODO: implement getFlashMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusAreaId>> getFocusArea(SonyCameraDevice device) {
    // TODO: implement getFocusArea
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<Point<num>>> getFocusAreaSpot(SonyCameraDevice device) {
    // TODO: implement getFocusAreaSpot
    throw UnimplementedError();
  }

  @override
  Future<double> getFocusMagnifier(SonyCameraDevice device) {
    // TODO: implement getFocusMagnifier
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusMagnifierDirectionId>> getFocusMagnifierDirection(
      SonyCameraDevice device) {
    // TODO: implement getFocusMagnifierDirection
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusMagnifierPhaseId>> getFocusMagnifierPhase(
      SonyCameraDevice device) {
    // TODO: implement getFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusModeId>> getFocusMode(SonyCameraDevice device) {
    // TODO: implement getFocusMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ImageFileFormatId>> getImageFileFormat(
      SonyCameraDevice device) {
    // TODO: implement getImageFileFormat
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<int>> getIso(SonyCameraDevice device) {
    // TODO: implement getIso
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<MeteringModeId>> getMeteringMode(
      SonyCameraDevice device) {
    // TODO: implement getMeteringMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<PictureEffectId>> getPictureEffect(
      SonyCameraDevice device) {
    // TODO: implement getPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ShootingModeId>> getShootingMode(
      SonyCameraDevice device) {
    // TODO: implement getShootingMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<int>> getShutterSpeed(SonyCameraDevice device) {
    // TODO: implement getShutterSpeed
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceId>> getWhiteBalance(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalance
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceAbId>> getWhiteBalanceAb(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceAb
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<int>> getWhiteBalanceColorTemp(SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceColorTemp
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceGmId>> getWhiteBalanceGm(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceGm
    throw UnimplementedError();
  }

  @override
  Future<bool> setAel(bool value, SonyCameraDevice device) {
    // TODO: implement setAel
    throw UnimplementedError();
  }

  @override
  Future<bool> setAspectRatio(AspectRatioId value, SonyCameraDevice device) {
    // TODO: implement setAspectRatio
    throw UnimplementedError();
  }

  @override
  Future<bool> setDriveMode(DriveModeId value, SonyCameraDevice device) {
    // TODO: implement setDriveMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setDroHdr(DroHdrId value, SonyCameraDevice device) {
    // TODO: implement setDroHdr
    throw UnimplementedError();
  }

  @override
  Future<bool> setEV(double value, SonyCameraDevice device) {
    // TODO: implement setEV
    throw UnimplementedError();
  }

  @override
  Future<bool> setFNumber(int value, SonyCameraDevice device) {
    // TODO: implement setFNumber
    throw UnimplementedError();
  }

  @override
  Future<bool> setFel(bool value, SonyCameraDevice device) {
    // TODO: implement setFel
    throw UnimplementedError();
  }

  @override
  Future<bool> setFlashMode(FlashModeId value, SonyCameraDevice device) {
    // TODO: implement setFlashMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusArea(FocusAreaId value, SonyCameraDevice device) {
    // TODO: implement setFocusArea
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusAreaSpot(Point<num> value, SonyCameraDevice device) {
    // TODO: implement setFocusAreaSpot
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusDistance(int value, SonyCameraDevice device) {
    // TODO: implement setFocusDistance
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifier(double value, SonyCameraDevice device) {
    // TODO: implement setFocusMagnifier
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps, SonyCameraDevice device) {
    // TODO: implement setFocusMagnifierDirection
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMagnifierPhase(
      FocusMagnifierPhaseId value, SonyCameraDevice device) {
    // TODO: implement setFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMode(FocusModeId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(
        Commands.getCommand(OpCodeId.SubSetting, SettingsId.FocusMode, value)));
  }

  @override
  Future<bool> setImageFileFormat(
      ImageFileFormatId value, SonyCameraDevice device) {
    // TODO: implement setImageFileFormat
    throw UnimplementedError();
  }

  @override
  Future<bool> setIso(int value, SonyCameraDevice device) {
    // TODO: implement setIso
    throw UnimplementedError();
  }

  @override
  Future<bool> setMeteringMode(MeteringModeId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(Commands.getCommand(
        OpCodeId.SubSetting, SettingsId.MeteringMode, value)));
  }

  @override
  Future<bool> setPictureEffect(
      PictureEffectId value, SonyCameraDevice device) {
    // TODO: implement setPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<bool> setShutterSpeed(int value, SonyCameraDevice device) {
    // TODO: implement setShutterSpeed
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalance(WhiteBalanceId value, SonyCameraDevice device) {
    // TODO: implement setWhiteBalance
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceAb(
      WhiteBalanceAbId value, SonyCameraDevice device) {
    // TODO: implement setWhiteBalanceAb
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceColorTemp(int value, SonyCameraDevice device) {
    // TODO: implement setWhiteBalanceColorTemp
    throw UnimplementedError();
  }

  @override
  Future<bool> setWhiteBalanceGm(
      WhiteBalanceGmId value, SonyCameraDevice device) {
    // TODO: implement setWhiteBalanceGm
    throw UnimplementedError();
  }

  @override
  Future<bool> startRecordingVideo(SonyCameraDevice device) {
    // TODO: implement startRecordingVideo
    throw UnimplementedError();
  }

  @override
  Future<bool> stopRecordingVideo(SonyCameraDevice device) {
    // TODO: implement stopRecordingVideo
    throw UnimplementedError();
  }

  Future<Uint8List> GetImage(bool liveView) async {
    var response =
        await FlutterUsb.sendCommand(Commands.getImageCommand(liveView, true));

    print("response valid ${response.isValidResponse()}");
    if (!response.isValidResponse()) return null;

    var bytes = response.getData().buffer.asByteData();
    int numImages = bytes.getUint16(32, Endian.little);

    print("images $numImages");
    if (numImages != 1) return null;

    int imageInfoUnk = bytes.getUint32(34, Endian.little);
    int imageSizeInBytes = bytes.getUint32(38, Endian.little); //24 630 528
                                                               //2 643 449
                                                                //24 000 000
    //26 883 8912

    if (imageSizeInBytes <= 0) return null;
    print("images $imageSizeInBytes");

    String imageName = bytes.getUint8(82).toString();
    //TODO in chunks, very slow at the moment? loading slow or json slow?
    response = await FlutterUsb.sendCommand(Commands.getImageCommand(
        liveView, false,
        imageSizeInBytes: imageSizeInBytes.truncateToDouble()));

    if (!response.isValidResponse()) return null;
    var buffer = response.getData().buffer;
    bytes = buffer.asByteData();

    if (liveView) {
      int unkBufferSize = bytes.getUint32(30, Endian.little);
      int liveViewBufferSize = bytes.getUint32(34, Endian.little);
      var unkBuff = ByteData.view(buffer, 38, unkBufferSize - 8);
      var start = 38 + unkBufferSize - 8;
      return response.getData().sublist(start, buffer.lengthInBytes - start);
    } else {
      //10 27 00 00 d4 05 00 00
      //10 27 00 00 27 0c 00 00
      //10 27 00 00 71 18 00 00
      //10 27 00 00 78 02 00 00
      //10 27 00 00 c3 00 00 00
      //10 27 00 00 61 02 00 00
      //10 27 00 00 16 1d 00 00
      //10 27 00 00 27 00 9a 82
      //05 00 01 00 00

      //05 d4 = 20692
      //d4 05 = 54352

      //2c 07 = 9996
      //2190540839

      //ohne 10 ...
      return response.getData().sublist(0, buffer.lengthInBytes);
    }
  }
}

extension ResponseValidation on Response {
  bool isSuccess() {
    return true;
  }

  bool isValidResponse() {
    return inData[0] == 1 && inData[1] == 0x20;
  }
}
