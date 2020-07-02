import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

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
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/record_video_state_ids.dart';
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
        return setEV(value, device);
      case SettingsId.DriveMode:
        return setDriveMode(getDriveModeId(value), device);
      case SettingsId.Flash:
        return setFlashMode(getFlashModeId(value), device);
      case SettingsId.DroHdr:
        return setDroHdr(getDroHdrId(value), device);
      case SettingsId.ImageSize:
        // TODO: Handle this case.
        break;
      case SettingsId.ShutterSpeed:
        return setShutterSpeed(value, device);
      case SettingsId.UnkD20E:
        // TODO: Handle this case.
        break;
      case SettingsId.WhiteBalanceColorTemp:
        return setWhiteBalanceColorTemp(value, device);
      case SettingsId.WhiteBalanceGM:
        return setWhiteBalanceGm(getWhiteBalanceGmId(value), device);
      case SettingsId.AspectRatio:
        return setAspectRatio(getAspectRatioId(value), device);
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
        return setPictureEffect(getPictureEffectId(value), device);
      case SettingsId.WhiteBalanceAB:
        return setWhiteBalanceAb(getWhiteBalanceAbId(value), device);
      case SettingsId.RecordVideoState:
        // TODO: Handle this case.
        break;
      case SettingsId.ISO:
        return setIso(value, device);
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
      case SettingsId.LiveViewInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.PhotoInfo:
        // TODO: Handle this case.
        break;
    }
    return false;
  }

  @override
  Future<bool> pressShutter(
          ShutterPressType shutterPressType, SonyCameraDevice device) =>
      doShutter(shutterPressType, true);

  @override
  Future<bool> releaseShutter(
          ShutterPressType shutterPressType, SonyCameraDevice device) =>
      doShutter(shutterPressType, false);

  Future<bool> doShutter(ShutterPressType shutterPressType, bool press) async {
    switch (shutterPressType) {
      case ShutterPressType.Half:
        return (await FlutterUsb.sendCommand(Command(
                Commands.getCommandMainSettingI16(
                    SettingsId.HalfPressShutter, press ? 2 : 1))))
            .isValidResponse();
      case ShutterPressType.Full:
        return (await FlutterUsb.sendCommand(Command(
                Commands.getCommandMainSettingI16(
                    SettingsId.CapturePhoto, press ? 2 : 1))))
            .isValidResponse();
      case ShutterPressType.Both:
        if ((await FlutterUsb.sendCommand(Command(
                Commands.getCommandMainSettingI16(
                    SettingsId.HalfPressShutter, press ? 2 : 1))))
            .isValidResponse()) {
          return (await FlutterUsb.sendCommand(Command(
                  Commands.getCommandMainSettingI16(
                      SettingsId.CapturePhoto, press ? 2 : 1))))
              .isValidResponse();
        }
    }
    return false;
  }

  @override
  Future<bool> setSettingsRaw(
      SettingsId id, int value, SonyCameraDevice device) {
    return setSettings(id, value, device);
  }

  @override
  Future<bool> capturePhoto(SonyCameraDevice device) async {
    await pressShutter(ShutterPressType.Both, device);
    await releaseShutter(ShutterPressType.Both, device);
    //read photo
    await device.cameraSettings.update();
    var item = device.cameraSettings.settings.firstWhere(
        (element) => element.settingsId == SettingsId.PhotoTransferQueue);

    if (item != null) {
      int numPhotos = item.value.usbValue & 0xFF;
      bool photoAvailableForTransfer =
          ((item.value.usbValue >> 8) & 0xFF) == 0x80;
      print("numPhotos $numPhotos");
      if (photoAvailableForTransfer) {
        for (int i = 0; i < numPhotos; i++) {
          var image = await GetImage(false);
        }
      }
    }
  }

  @override
  Future<SettingsItem<BoolValue>> getAel(SonyCameraDevice device) {
    bool value = device.cameraSettings.settings
            .firstWhere((element) => element.settingsId == SettingsId.AEL_State)
            .value
            .usbValue !=
        2;
    //TODO
  }

  @override
  Future<SettingsItem<AspectRatioValue>> getAspectRatio(
      SonyCameraDevice device) async {
    return device.cameraSettings.settings
        .firstWhere((element) => element.settingsId == SettingsId.AEL_State);
  }

  @override
  Future<SettingsItem<AutoFocusStateValue>> getAutoFocusState(
      SonyCameraDevice device) {
    // TODO: implement getAutoFocusState
    throw UnimplementedError();
  }

  @override
  Future<int> getBatteryPercentage(SonyCameraDevice device) async {
    return device.cameraSettings.settings
        .firstWhere((element) => element.settingsId == SettingsId.BatteryInfo)
        .value
        .usbValue;
  }

  @override
  Future<SettingsItem<DriveModeValue>> getDriveMode(SonyCameraDevice device) {
    // TODO: implement getDriveMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DroHdrValue>> getDroHdr(SonyCameraDevice device) {
    // TODO: implement getDroHdr
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<DoubleValue>> getEV(SonyCameraDevice device) {
    // TODO: implement getEV
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getFNumber(SonyCameraDevice device) {
    // TODO: implement getFNumber
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<BoolValue>> getFel(SonyCameraDevice device) {
    // TODO: implement getFel
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FlashModeValue>> getFlashMode(SonyCameraDevice device) {
    // TODO: implement getFlashMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusAreaValue>> getFocusArea(SonyCameraDevice device) {
    // TODO: implement getFocusArea
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<PointValue>> getFocusAreaSpot(SonyCameraDevice device) {
    // TODO: implement getFocusAreaSpot
    throw UnimplementedError();
  }

  @override
  Future<double> getFocusMagnifier(SonyCameraDevice device) {
    // TODO: implement getFocusMagnifier
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusMagnifierDirectionValue>> getFocusMagnifierDirection(
      SonyCameraDevice device) {
    // TODO: implement getFocusMagnifierDirection
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusMagnifierPhaseValue>> getFocusMagnifierPhase(
      SonyCameraDevice device) {
    // TODO: implement getFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<FocusModeValue>> getFocusMode(SonyCameraDevice device) {
    // TODO: implement getFocusMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ImageFileFormatValue>> getImageFileFormat(
      SonyCameraDevice device) {
    // TODO: implement getImageFileFormat
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getIso(SonyCameraDevice device) {
    // TODO: implement getIso
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<MeteringModeValue>> getMeteringMode(
      SonyCameraDevice device) {
    // TODO: implement getMeteringMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<PictureEffectValue>> getPictureEffect(
      SonyCameraDevice device) {
    // TODO: implement getPictureEffect
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<ShootingModeValue>> getShootingMode(
      SonyCameraDevice device) {
    // TODO: implement getShootingMode
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getShutterSpeed(SonyCameraDevice device) {
    // TODO: implement getShutterSpeed
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceValue>> getWhiteBalance(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalance
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceAbValue>> getWhiteBalanceAb(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceAb
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<IntValue>> getWhiteBalanceColorTemp(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceColorTemp
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WhiteBalanceGmValue>> getWhiteBalanceGm(
      SonyCameraDevice device) {
    // TODO: implement getWhiteBalanceGm
    throw UnimplementedError();
  }

  @override
  Future<bool> setAel(bool value, SonyCameraDevice device) {
    if (value) {
      //enable ael?
      FlutterUsb.sendCommand(
          Command(Commands.getCommandMainSettingI16(SettingsId.AEL, 1)));
      FlutterUsb.sendCommand(
          Command(Commands.getCommandMainSettingI16(SettingsId.AEL, 2)));
    } else {
      FlutterUsb.sendCommand(
          Command(Commands.getCommandMainSettingI16(SettingsId.AEL, 2)));
      FlutterUsb.sendCommand(
          Command(Commands.getCommandMainSettingI16(SettingsId.AEL, 1)));
    }
  }

  @override
  Future<bool> setAspectRatio(AspectRatioId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(
        Commands.getCommandSubSettingU8(SettingsId.AspectRatio, value)));
  }

  @override
  Future<bool> setDriveMode(DriveModeId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(
        Command(Commands.getCommandSubSettingI16(SettingsId.DriveMode, value)));
  }

  @override
  Future<bool> setDroHdr(DroHdrId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(
        Command(Commands.getCommandSubSettingI16(SettingsId.DroHdr, value)));
  }

  @override
  Future<bool> setEV(int value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(
        Command(Commands.getCommandMainSettingI16(SettingsId.EV, value)));
  }

  @override
  Future<bool> setFNumber(int value, SonyCameraDevice device) {
    //value = steps
    FlutterUsb.sendCommand(
        Command(Commands.getCommandMainSettingI16(SettingsId.FNumber, value)));
  }

  @override
  Future<bool> setFel(bool value, SonyCameraDevice device) {
    if (value) {
      //enable fel?
      FlutterUsb.sendCommand(
          Command(Commands.getCommandMainSettingI16(SettingsId.FEL, 1)));
      FlutterUsb.sendCommand(
          Command(Commands.getCommandMainSettingI16(SettingsId.FEL, 2)));
    } else {
      FlutterUsb.sendCommand(
          Command(Commands.getCommandMainSettingI16(SettingsId.FEL, 2)));
      FlutterUsb.sendCommand(
          Command(Commands.getCommandMainSettingI16(SettingsId.FEL, 1)));
    }
  }

  @override
  Future<bool> setFlashMode(FlashModeId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(
        Command(Commands.getCommandSubSettingI16(SettingsId.FlashMode, value)));
  }

  Future<bool> setFlashValue(int value, SonyCameraDevice device) {
    //value is steps
    FlutterUsb.sendCommand(
        Command(Commands.getCommandMainSettingI16(SettingsId.Flash, value)));
  }

  @override
  Future<bool> setFocusArea(FocusAreaId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(Commands.getCommandSubSettingI16(
        SettingsId.FocusArea, value.usbValue)));
  }

  @override
  Future<bool> setFocusAreaSpot(Point<num> value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(Commands.getCommandMainSettingI16_2(
        SettingsId.FocusAreaSpot, value.y, value.x)));
  }

  @override
  Future<bool> setFocusDistance(int value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(
        Commands.getCommandMainSettingI16(SettingsId.FocusDistance, value)));
  }

  @override
  Future<bool> setFocusMagnifier(double value, SonyCameraDevice device) {
    for (int i = 0; i < value; i++) {
      FlutterUsb.sendCommand(Command(Commands.getCommandMainSettingI16(
          SettingsId.FocusMagnifierRequest, 2)));
      FlutterUsb.sendCommand(Command(Commands.getCommandMainSettingI16(
          SettingsId.FocusMagnifierRequest, 1)));
    }
  }

  @override
  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps, SonyCameraDevice device) {
    SettingsId opcode;
    switch (value) {
      case FocusMagnifierDirectionId.Left:
        opcode = SettingsId.FocusMagnifierMoveLeftRequest;
        break;
      case FocusMagnifierDirectionId.Right:
        opcode = SettingsId.FocusMagnifierMoveRightRequest;
        break;
      case FocusMagnifierDirectionId.Up:
        opcode = SettingsId.FocusMagnifierMoveUpRequest;
        break;
      case FocusMagnifierDirectionId.Down:
        opcode = SettingsId.FocusMagnifierMoveDownRequest;
        break;
      case FocusMagnifierDirectionId.Unknown:
        opcode = null;
        break;
    }
    if (opcode != null) {
      for (int i = 0; i < steps; i++) {
        FlutterUsb.sendCommand(
            Command(Commands.getCommandMainSettingI16(opcode, 2)));
        FlutterUsb.sendCommand(
            Command(Commands.getCommandMainSettingI16(opcode, 1)));
      }
    }
  }

  @override
  Future<bool> setFocusMagnifierPhase(
      FocusMagnifierPhaseId value, SonyCameraDevice device) {
    // TODO: implement setFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMode(FocusModeId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(
        Command(Commands.getCommandSubSettingI16(SettingsId.FocusMode, value)));
  }

  Future<bool> setFocusModeToggle(
      FocusModeToggleId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(Commands.getCommandMainSettingI16(
        SettingsId.FocusModeToggleRequest, value)));
  }

  @override
  Future<bool> setImageFileFormat(
      ImageFileFormatId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(
        Commands.getCommandSubSettingI16(SettingsId.FileFormat, value)));
  }

  @override
  Future<bool> setIso(int value, SonyCameraDevice device) {
    //value = steps
    FlutterUsb.sendCommand(
        Command(Commands.getCommandMainSettingI32(SettingsId.ISO, value)));
  }

  @override
  Future<bool> setMeteringMode(MeteringModeId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(
        Commands.getCommandSubSettingI16(SettingsId.MeteringMode, value)));
  }

  @override
  Future<bool> setPictureEffect(
      PictureEffectId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(
        Commands.getCommandSubSettingI16(SettingsId.PictureEffect, value)));
  }

  @override
  Future<bool> setShutterSpeed(int value, SonyCameraDevice device) {
    //vlue = steps
    FlutterUsb.sendCommand(Command(
        Commands.getCommandMainSettingI32(SettingsId.ShutterSpeed, value)));
  }

  @override
  Future<bool> setWhiteBalance(WhiteBalanceId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(Commands.getCommandSubSettingI16(
        SettingsId.WhiteBalance, value.usbValue)));
  }

  @override
  Future<bool> setWhiteBalanceAb(
      WhiteBalanceAbId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(Commands.getCommandSubSettingI16(
        SettingsId.WhiteBalanceAB, value.usbValue)));
  }

  @override
  Future<bool> setWhiteBalanceColorTemp(int value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(Commands.getCommandSubSettingI16(
        SettingsId.WhiteBalanceColorTemp, value)));
  }

  @override
  Future<bool> setWhiteBalanceGm(
      WhiteBalanceGmId value, SonyCameraDevice device) {
    FlutterUsb.sendCommand(Command(Commands.getCommandSubSettingI16(
        SettingsId.WhiteBalanceGM, value.usbValue)));
  }

  @override
  Future<bool> startRecordingVideo(SonyCameraDevice device) {
    FlutterUsb.sendCommand(
        Command(Commands.getCommandMainSettingI16(SettingsId.RecordVideo, 2)));
  }

  @override
  Future<bool> stopRecordingVideo(SonyCameraDevice device) {
    FlutterUsb.sendCommand(
        Command(Commands.getCommandMainSettingI16(SettingsId.RecordVideo, 1)));
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

    int nameLength = bytes.getUint8(82);
    int CharSize = 2;
    int totalLength = nameLength * CharSize;
    var namebytes = response.getData().sublist(83, 83 + totalLength);
    var name = new String.fromCharCodes(namebytes);

    print(name);

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

      /*
      Größe: 2779555
bild abfrage:
09 10 00 00 00 00 00 00 00 00 01 C0 FF FF 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00 00 03 00 00 00
ergebnis:
01 20 00 00 00 ...

photoqueue value 32770 -> 2 photos (raw + jpg?)

imagename "DSC01548.ARW" (mit arw!!)

       */
      Uint8List data =
          response.getData().sublist(30, buffer.lengthInBytes - 30);

      print("saveFile $name");
      File file = new File("C:\\Users\\kilia\\Desktop\\$name");
      file.writeAsBytesSync(data);
      return data;
    }
  }

  @override
  Future<RecordVideoStateValue> getRecordingVideoState(
      SonyCameraDevice device) async {
    return device.cameraSettings.settings
        .firstWhere(
            (element) => element.settingsId == SettingsId.RecordVideoState)
        .value as RecordVideoStateValue;
  }

  @override
  Future<SettingsItem<ImageSizeValue>> getImageSize(SonyCameraDevice device) {
    // TODO: implement getImageSize
    throw UnimplementedError();
  }

  @override
  Future<bool> setImageSize(ImageSizeId value, SonyCameraDevice device) {
    // TODO: implement setImageSize
    throw UnimplementedError();
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
