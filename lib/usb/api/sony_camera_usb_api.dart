import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/top_level_api/api/force_update.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
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
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/record_video_state_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/usb/commands/downloader.dart';
import 'package:sonyalphacontrol/usb/commands/response_validation.dart';
import 'package:sonyalphacontrol/usb/device/sony_camera_usb_device.dart';

import '../commands/usb_commands.dart';

//TODO 0000   10 00 00 00 04 00 03 c2 ff ff ff ff 1d d2 00 00 -> URB_INTERRUPT in when sth changed
//TODO register for event notifications
class SonyCameraUsbApi extends CameraApiInterface {
  SonyCameraUsbDevice get device => cameraDevice;

  SonyCameraUsbApi(SonyCameraDevice device) : super(device);

  Future<bool> setSettings(
      //TODO instead of int some SettingsValue<dynamic>
      SettingsId settingsId,
      int value,
      SonyCameraUsbDevice device) async {
    switch (settingsId) {
      case SettingsId.ImageFileFormat:
        return setImageFileFormat(ImageFileFormatValue.fromUSBValue(value));
      case SettingsId.WhiteBalanceMode:
        return setWhiteBalanceMode(WhiteBalanceModeValue.fromUSBValue(value));
      case SettingsId.FNumber:
        return modifyFNumber(value);
      case SettingsId.FocusMode:
        return setFocusMode(FocusModeValue.fromUSBValue(value));
      case SettingsId.MeteringMode:
        return setMeteringMode(MeteringModeValue.fromUSBValue(value));
      case SettingsId.FlashMode:
        return setFlashMode(FlashModeValue.fromUSBValue(value));
      case SettingsId.ShootingMode:
        // TODO: Handle this case.
        break;
      case SettingsId.EV:
        return modifyEV(value);
      case SettingsId.DriveMode:
        return setDriveMode(DriveModeIdExtension.getIdFromUsb(value));
      case SettingsId.FlashValue:
        return setFlashValue(value);
      case SettingsId.DroHdr:
        return setDroHdr(DroHdrIdExtension.getIdFromUsb(value));
      case SettingsId.ImageSize:
        return setImageSize(ImageSizeIdExtension.getIdFromUsb(value));
      case SettingsId.ShutterSpeed:
        return setShutterSpeed(
            ShutterSpeedValue.fromUsbValue(value as double, 0));
      case SettingsId.WhiteBalanceColorTemp:
        return setWhiteBalanceColorTemp(
            WhiteBalanceColorTempValue.fromUSBValue(value));
      case SettingsId.WhiteBalanceGM:
        return setWhiteBalanceGm(WhiteBalanceGmIdExtension.getIdFromUsb(value));
      case SettingsId.AspectRatio:
        return setAspectRatio(AspectRatioIdExtension.getIdFromUsb(value));
      case SettingsId.UnkD212:
        return false;
      case SettingsId.Zoom:
        // TODO: Handle this case.
        break;
      case SettingsId.AutoFocusState:
      case SettingsId.AEL_State:
      case SettingsId.BatteryInfo:
      case SettingsId.RecordVideoState:
      case SettingsId.LiveViewState:
      case SettingsId.FEL_State:
      case SettingsId.FocusMagnifierState:
        // STATE cannot be set
        break;
      case SettingsId.SensorCrop:
        // TODO: Handle this case.
        break;
      case SettingsId.PictureEffect:
        return setPictureEffect(PictureEffectIdExtension.getIdFromUsb(value));
      case SettingsId.WhiteBalanceAB:
        return setWhiteBalanceAb(WhiteBalanceAbIdExtension.getIdFromUsb(value));
      case SettingsId.ISO:
        return setIso(IsoValue(value)); //TODO test
      case SettingsId.FocusArea:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMagnifierPhase:
        // TODO: Handle this case.
        break;
      case SettingsId.PhotoTransferQueue:
        // cannot be set
        break;
      case SettingsId.UnkD20E:
      case SettingsId.UnkD222:
      case SettingsId.UnkD22E:
      case SettingsId.UnkD236:
      case SettingsId.UnkD2D3:
      case SettingsId.UnkD2D4:
        return false;
      case SettingsId.UnkD2C5:
        /*
        return (await FlutterUsb.sendCommand(Command(
                Commands.getCommandMainSettingI16(SettingsId.UnkD2C5, value))))
            .isValidResponse();
        */
        return false;
      case SettingsId.UnkD2C7:
        /*
        return (await FlutterUsb.sendCommand(Command(
                Commands.getCommandMainSettingI16(SettingsId.UnkD2C7, value))))
            .isValidResponse(); //TODO I32, subsettingss??
         */
        return false;
      case SettingsId.Unknown:
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
      case SettingsId.FocusModeToggleResponse:
        // TODO: Handle this case.
        break;
      case SettingsId.HalfPressShutter:
        return pressShutter(ShutterPressType.Half);
      case SettingsId.CapturePhoto:
        // TODO: Handle this case.
        break;
      case SettingsId.AEL:
        return setAel(value == 1);
      case SettingsId.RecordVideo:
        if (value == 1) {
          return startRecordingVideo();
        }
        return stopRecordingVideo();
        break;
      case SettingsId.FEL:
        return setFel(value == 1);
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
      case SettingsId.LiveViewInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.PhotoInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.AvailableSettings:
        // TODO: Handle this case.
        break;
      case SettingsId.CameraInfo:
        // TODO: Handle this case.
        break;
      default:
        break;
    }
    return false;
  }

  @override
  Future<bool> pressShutter(ShutterPressType shutterPressType) =>
      doShutter(shutterPressType, true);

  @override
  Future<bool> releaseShutter(ShutterPressType shutterPressType) =>
      doShutter(shutterPressType, false);

  Future<bool> doShutter(ShutterPressType shutterPressType, bool press) async {
    switch (shutterPressType) {
      case ShutterPressType.Half:
      case ShutterPressType.Full:
        return (await UsbCommands.getCommandSetting(
                    shutterPressType == ShutterPressType.Half
                        ? SettingsId.HalfPressShutter
                        : SettingsId.CapturePhoto,
                    opCodeId: OpCodeId.MainSetting,
                    value1: press ? 2 : 1)
                .send())
            .isValidResponse();
      case ShutterPressType.Both:
        return await doShutter(ShutterPressType.Half, press)
            ? await doShutter(ShutterPressType.Full, press)
            : false;
    }
    return false;
  }

  @override
  Future<bool> setSettingsRaw(SettingsId id, int value) {
    return setSettings(id, value, device);
  }

  @override
  Future<List<CameraImage>> capturePhoto({String filePath}) async {
    await pressShutter(ShutterPressType.Both);
    await releaseShutter(ShutterPressType.Both); //download
    Downloader.device = device;
    return Downloader.download();
  }

  @override
  Future<int> getBatteryPercentage({update = ForceUpdate.Off}) async {
    return device.cameraSettings.getItem(SettingsId.BatteryInfo).value.usbValue;
  }

  @override
  Future<bool> setAel(bool value) async {
    return (await UsbCommands.getCommandSetting(SettingsId.AEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 1 : 2)
                .send())
            .isValidResponse()
        ? (await UsbCommands.getCommandSetting(SettingsId.AEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 2 : 1)
                .send())
            .isValidResponse()
        : false;
  }

  @override
  Future<bool> setAspectRatio(AspectRatioId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.AspectRatio,
                  opCodeId: OpCodeId.SubSetting,
                  value1: value.usbValue,
                  value1DataSize: 1)
              .send())
          .isValidResponse();

  @override
  Future<bool> setDriveMode(DriveModeId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.DriveMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setDroHdr(DroHdrId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.DroHdr,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> modifyEV(int value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.EV,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setEV(EvValue value) async => throw UnimplementedError;

  @override
  Future<bool> modifyFNumber(int value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.FNumber,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFNumber(DoubleValue value) async => throw UnsupportedError;

  @override
  Future<bool> setFel(bool value) async {
    return (await UsbCommands.getCommandSetting(SettingsId.FEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 1 : 2)
                .send())
            .isValidResponse()
        ? (await UsbCommands.getCommandSetting(SettingsId.FEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 2 : 1)
                .send())
            .isValidResponse()
        : false;
  }

  @override
  Future<bool> setFlashMode(FlashModeValue value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.FlashMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFlashValue(int value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.FlashValue,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusArea(FocusAreaId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.FocusArea,
                  opCodeId: OpCodeId.SubSetting, value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusAreaSpot(Point<num> value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.FocusAreaSpot,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value.y,
                  value2: value.x,
                  value1DataSize: 2,
                  value2DataSize: 2)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusDistance(int value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.FocusDistance,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusMagnifier(double value) async {
    for (int i = 0; i < value; i++) {
      if ((await UsbCommands.getCommandSetting(SettingsId.FocusMagnifierRequest,
                  opCodeId: OpCodeId.MainSetting, value1: 2)
              .send())
          .isValidResponse()) {
        if ((await UsbCommands.getCommandSetting(
                    SettingsId.FocusMagnifierRequest,
                    opCodeId: OpCodeId.MainSetting,
                    value1: 1)
                .send())
            .isValidResponse()) {
          //next when successful
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
    return true; //when everything finished it's successful
  }

  @override
  Future<bool> setFocusMagnifierDirection(
      FocusMagnifierDirectionId value, int steps) async {
    SettingsId settingsId;
    switch (value) {
      case FocusMagnifierDirectionId.Left:
        settingsId = SettingsId.FocusMagnifierMoveLeftRequest;
        break;
      case FocusMagnifierDirectionId.Right:
        settingsId = SettingsId.FocusMagnifierMoveRightRequest;
        break;
      case FocusMagnifierDirectionId.Up:
        settingsId = SettingsId.FocusMagnifierMoveUpRequest;
        break;
      case FocusMagnifierDirectionId.Down:
        settingsId = SettingsId.FocusMagnifierMoveDownRequest;
        break;
      case FocusMagnifierDirectionId.Unknown:
        settingsId = null;
        break;
    }
    if (settingsId != null) {
      for (int i = 0; i < steps; i++) {
        if ((await UsbCommands.getCommandSetting(settingsId,
                        opCodeId: OpCodeId.MainSetting, value1: 2)
                    .send())
                .isValidResponse() ==
            false) return false;
        if ((await UsbCommands.getCommandSetting(settingsId,
                        opCodeId: OpCodeId.MainSetting, value1: 1)
                    .send())
                .isValidResponse() ==
            false) return false;
      }
    }
    return true;
  }

  @override
  Future<bool> setFocusMagnifierPhase(FocusMagnifierPhaseId value) {
    // TODO: implement setFocusMagnifierPhase
    throw UnimplementedError();
  }

  @override
  Future<bool> setFocusMode(FocusModeValue value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.FocusMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusModeToggle(FocusModeToggleId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.FocusModeToggleRequest,
                  opCodeId: OpCodeId.MainSetting, value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setImageFileFormat(ImageFileFormatValue value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.ImageFileFormat,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> modifyIso(int direction) async => throw UnimplementedError();

  @override
  Future<bool> setIso(IsoValue value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.ISO,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value.usbValue,
                  value1DataSize: 4)
              .send())
          .isValidResponse();

  @override
  Future<bool> setMeteringMode(MeteringModeValue value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.MeteringMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setPictureEffect(PictureEffectId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.PictureEffect,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setShutterSpeed(ShutterSpeedValue value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.ShutterSpeed,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value.usbValue,
                  value1DataSize: 4)
              .send())
          .isValidResponse();

  @override
  Future<bool> modifyShutterSpeed(int value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.ShutterSpeed,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value,
                  value1DataSize: 4)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceMode(WhiteBalanceModeValue value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.WhiteBalanceMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.WhiteBalanceAB,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceColorTemp(
          WhiteBalanceColorTempValue value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.WhiteBalanceColorTemp,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.WhiteBalanceGM,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> startRecordingVideo() async =>
      (await UsbCommands.getCommandSetting(SettingsId.RecordVideo,
                  opCodeId: OpCodeId.MainSetting, value1: 2)
              .send())
          .isValidResponse();

  @override
  Future<bool> stopRecordingVideo() async =>
      (await UsbCommands.getCommandSetting(SettingsId.RecordVideo,
                  opCodeId: OpCodeId.MainSetting, value1: 1)
              .send())
          .isValidResponse();

  @override
  Future<RecordVideoStateValue> getRecordingVideoState(
          {update = ForceUpdate.Off}) async =>
      device.cameraSettings.getItem(SettingsId.RecordVideoState).value
          as RecordVideoStateValue;

  @override
  Future<SettingsItem<ImageSizeValue>> getImageSize(
          {update = ForceUpdate.Off}) async =>
      device.cameraSettings.getItem(SettingsId.ImageSize);

  @override
  Future<bool> setImageSize(ImageSizeId value) async =>
      (await UsbCommands.getCommandSetting(SettingsId.ImageSize,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

/*
    int numPhotos = item.value.usbValue & 0xFF;
    bool photoAvailableForTransfer =
        ((item.value.usbValue >> 8) & 0xFF) == 0x80;
   */
  @override
  Future<bool> getPhotoAvailable({update = ForceUpdate.Off}) async =>
      ((device.cameraSettings
                  .getItem(SettingsId.PhotoTransferQueue)
                  .value
                  .usbValue >>
              8) &
          0xFF) ==
      0x80;

  @override
  Future<CameraImageRequest> requestPhotoAvailable(
      {bool liveView = false}) async {
    var response = await UsbCommands.getImageCommand(liveView, true).send();

    int offset = 32; //TODO maybe only wia offset?
    if (Platform.isAndroid) {
      offset = 14;
    }

    var bytes = response.inData.toByteList().buffer.asByteData();
    int numImages =
        bytes.getUint16(offset, Endian.little); //not num but true/false
    offset += 2;
    int imageInfoUnk = bytes.getUint32(offset, Endian.little); //TODO type?
    offset += 4;
    int imageSizeInBytes = bytes.getUint32(offset, Endian.little);
    offset += 45;
    var name = String.fromCharCodes(response.inData
            .toByteList()
            .sublist(offset, offset + (bytes.getUint8(offset - 1) * 2)))
        .replaceAll(RegExp(r"\x00"), ""); //replace "NUL" characters

    return CameraImageRequest(
        numImages == 1, imageInfoUnk, imageSizeInBytes, name);
  }

  @override
  Future<bool> startRecordingAudio() {
    // TODO: implement startRecordingAudio
    throw UnimplementedError();
  }

  @override
  Future<bool> stopRecordingAudio() {
    // TODO: implement stopRecordingAudio
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<StringValue>> getRecordingAudio(
      {update = ForceUpdate.Off}) {
    // TODO: implement getRecordingAudio
    throw UnimplementedError();
  }

  @override
  Future<bool> setRecordingAudio(String audioRecordingSetting) {
    // TODO: implement setRecordingAudio
    throw UnimplementedError();
  }

  @override
  Stream<Image> streamLiveView() async* {
    while (true) {
      var mills = DateTime.now().millisecondsSinceEpoch;
      var imgData = (await getImage(device, liveView: true));
      if (imgData != null) {
        var img = Image.memory(imgData.data, key: Key("livviewimage"));
        print("Frame Took ${DateTime.now().millisecondsSinceEpoch - mills}");
        yield img;
      }
    }
  }

  @override
  Future<bool> modifyWhiteBalanceColorTemp(int direction) {
    // TODO: implement modifyWhiteBalanceColorTemp
    throw UnimplementedError();
  }

  @override
  Future<SettingsItem<WebApiVersionValue>> getWebApiVersions(
      {ForceUpdate update}) {
    // TODO: implement getWebApiVersions
    throw UnimplementedError();
  }
}
