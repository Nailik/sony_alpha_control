import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/top_level_api/camera_image.dart';
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
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/record_video_state_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/shooting_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/top_level_api/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';
import 'package:sonyalphacontrol/usb/downloader.dart';
import 'package:sonyalphacontrol/usb/response_validation.dart';
import 'package:sonyalphacontrol/usb/sony_camera_usb_device.dart';

import 'commands.dart';

//TODO 0000   10 00 00 00 04 00 03 c2 ff ff ff ff 1d d2 00 00 -> URB_INTERRUPT in when sth changed
//TODO register for event notifications
class SonyCameraUsbApi extends CameraApiInterface {
  SonyCameraUsbDevice get device => cameraDevice;

  SonyCameraUsbApi(SonyCameraDevice device) : super(device);

  Future<bool> setSettings(
      SettingsId settingsId, int value, SonyCameraUsbDevice device) async {
    switch (settingsId) {
      case SettingsId.FileFormat:
        return setImageFileFormat(getImageFileFormatId(value));
      case SettingsId.WhiteBalance:
        return setWhiteBalance(getWhiteBalanceId(value));
      case SettingsId.FNumber:
        return setFNumber(value);
      case SettingsId.FocusMode:
        return setFocusMode(getFocusModeId(value));
      case SettingsId.MeteringMode:
        return setMeteringMode(getMeteringModeId(value));
      case SettingsId.FlashMode:
        return setFlashMode(getFlashModeId(value));
      case SettingsId.ShootingMode:
        // TODO: Handle this case.
        break;
      case SettingsId.EV:
        return setEV(value);
      case SettingsId.DriveMode:
        return setDriveMode(getDriveModeId(value));
      case SettingsId.FlashValue:
        return setFlashValue(value);
      case SettingsId.DroHdr:
        return setDroHdr(getDroHdrId(value));
      case SettingsId.ImageSize:
        return setImageSize(getImageSizeId(value));
      case SettingsId.ShutterSpeed:
        return setShutterSpeed(value);
      case SettingsId.WhiteBalanceColorTemp:
        return setWhiteBalanceColorTemp(value);
      case SettingsId.WhiteBalanceGM:
        return setWhiteBalanceGm(getWhiteBalanceGmId(value));
      case SettingsId.AspectRatio:
        return setAspectRatio(getAspectRatioId(value));
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
        return setPictureEffect(getPictureEffectId(value));
      case SettingsId.WhiteBalanceAB:
        return setWhiteBalanceAb(getWhiteBalanceAbId(value));
      case SettingsId.ISO:
        return setIso(value);
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
        return (await Commands.getCommandSetting(
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
  Future<SettingsItem<BoolValue>> getAel() async =>
      device.cameraSettings.settings.firstWhere((element) =>
          element.settingsId ==
          SettingsId.AEL_State); //TODO differenc ael and ael state?

  @override
  Future<SettingsItem<AspectRatioValue>> getAspectRatio() async => device
      .cameraSettings.settings
      .firstWhere((element) => element.settingsId == SettingsId.AspectRatio);

  @override
  Future<SettingsItem<AutoFocusStateValue>> getAutoFocusState() async =>
      device.cameraSettings.getItem(SettingsId.AutoFocusState);

  @override
  Future<int> getBatteryPercentage() async {
    return device.cameraSettings.settings
        .firstWhere((element) => element.settingsId == SettingsId.BatteryInfo)
        .value
        .usbValue;
  }

  @override
  Future<SettingsItem<DriveModeValue>> getDriveMode() async =>
      device.cameraSettings.getItem(SettingsId.DriveMode);

  @override
  Future<SettingsItem<DroHdrValue>> getDroHdr() async =>
      device.cameraSettings.getItem(SettingsId.DroHdr);

  @override
  Future<SettingsItem<DoubleValue>> getEV() async =>
      device.cameraSettings.getItem(SettingsId.EV);

  @override
  Future<SettingsItem<IntValue>> getFNumber() async =>
      device.cameraSettings.getItem(SettingsId.FNumber);

  @override
  Future<SettingsItem<BoolValue>> getFel() async =>
      device.cameraSettings.getItem(SettingsId.FEL);

  @override
  Future<SettingsItem<FlashModeValue>> getFlashMode() async =>
      device.cameraSettings.getItem(SettingsId.FlashMode);

  @override
  Future<SettingsItem<FocusAreaValue>> getFocusArea() async =>
      device.cameraSettings.getItem(SettingsId.FocusArea);

  @override
  Future<SettingsItem<PointValue>> getFocusAreaSpot() async =>
      device.cameraSettings.getItem(SettingsId.FocusAreaSpot);

  @override
  Future<SettingsItem<DoubleValue>> getFocusMagnifier() async =>
      device.cameraSettings.getItem(SettingsId.FocusMagnifier);

  @override //TODO SettingsId.FocusMagnifierDirection?
  Future<SettingsItem<FocusMagnifierDirectionValue>>
      getFocusMagnifierDirection() async =>
          device.cameraSettings.getItem(SettingsId.FocusMagnifier);

  @override
  Future<SettingsItem<FocusMagnifierPhaseValue>>
      getFocusMagnifierPhase() async =>
          device.cameraSettings.getItem(SettingsId.FocusMagnifierPhase);

  @override
  Future<SettingsItem<FocusModeValue>> getFocusMode() async =>
      device.cameraSettings.getItem(SettingsId.FocusMode);

  @override
  Future<SettingsItem<ImageFileFormatValue>> getImageFileFormat() async =>
      device.cameraSettings.getItem(SettingsId.FileFormat);

  @override
  Future<SettingsItem<IntValue>> getIso() async =>
      device.cameraSettings.getItem(SettingsId.ISO);

  @override
  Future<SettingsItem<MeteringModeValue>> getMeteringMode() async =>
      device.cameraSettings.getItem(SettingsId.MeteringMode);

  @override
  Future<SettingsItem<PictureEffectValue>> getPictureEffect() async =>
      device.cameraSettings.getItem(SettingsId.PictureEffect);

  @override
  Future<SettingsItem<ShootingModeValue>> getShootingMode() async =>
      device.cameraSettings.getItem(SettingsId.ShootingMode);

  @override
  Future<SettingsItem<IntValue>> getShutterSpeed() async =>
      device.cameraSettings.getItem(SettingsId.FocusMagnifier);

  @override
  Future<SettingsItem<WhiteBalanceValue>> getWhiteBalance() async =>
      device.cameraSettings.getItem(SettingsId.WhiteBalance);

  @override
  Future<SettingsItem<WhiteBalanceAbValue>> getWhiteBalanceAb() async =>
      device.cameraSettings.getItem(SettingsId.WhiteBalanceAB);

  @override
  Future<SettingsItem<IntValue>> getWhiteBalanceColorTemp() async =>
      device.cameraSettings.getItem(SettingsId.WhiteBalanceColorTemp);

  @override
  Future<SettingsItem<WhiteBalanceGmValue>> getWhiteBalanceGm() async =>
      device.cameraSettings.getItem(SettingsId.WhiteBalanceGM);

  @override
  Future<bool> setAel(bool value) async {
    return (await Commands.getCommandSetting(SettingsId.AEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 1 : 2)
                .send())
            .isValidResponse()
        ? await setAel(!value)
        : false;
  }

  @override
  Future<bool> setAspectRatio(AspectRatioId value) async =>
      (await Commands.getCommandSetting(SettingsId.AspectRatio,
                  opCodeId: OpCodeId.SubSetting,
                  value1: value.usbValue,
                  value1DataSize: 1)
              .send())
          .isValidResponse();

  @override
  Future<bool> setDriveMode(DriveModeId value) async =>
      (await Commands.getCommandSetting(SettingsId.DriveMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setDroHdr(DroHdrId value) async =>
      (await Commands.getCommandSetting(SettingsId.DroHdr,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setEV(int value) async =>
      (await Commands.getCommandSetting(SettingsId.EV,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFNumber(int value) async =>
      (await Commands.getCommandSetting(SettingsId.FNumber,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFel(bool value) async {
    return (await Commands.getCommandSetting(SettingsId.FEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 1 : 2)
                .send())
            .isValidResponse()
        ? await setAel(!value)
        : false;
  }

  @override
  Future<bool> setFlashMode(FlashModeId value) async =>
      (await Commands.getCommandSetting(SettingsId.FlashMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFlashValue(int value) async =>
      (await Commands.getCommandSetting(SettingsId.FlashValue,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusArea(FocusAreaId value) async =>
      (await Commands.getCommandSetting(SettingsId.FocusArea,
                  opCodeId: OpCodeId.SubSetting, value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusAreaSpot(Point<num> value) async =>
      (await Commands.getCommandSetting(SettingsId.FocusAreaSpot,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value.y,
                  value2: value.x,
                  value1DataSize: 2,
                  value2DataSize: 2)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusDistance(int value) async =>
      (await Commands.getCommandSetting(SettingsId.FocusDistance,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusMagnifier(double value) async {
    for (int i = 0; i < value; i++) {
      if ((await Commands.getCommandSetting(SettingsId.FocusMagnifierRequest,
                  opCodeId: OpCodeId.MainSetting, value1: 2)
              .send())
          .isValidResponse()) {
        if ((await Commands.getCommandSetting(SettingsId.FocusMagnifierRequest,
                    opCodeId: OpCodeId.MainSetting, value1: 1)
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
        if ((await Commands.getCommandSetting(settingsId,
                        opCodeId: OpCodeId.MainSetting, value1: 2)
                    .send())
                .isValidResponse() ==
            false) return false;
        if ((await Commands.getCommandSetting(settingsId,
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
  Future<bool> setFocusMode(FocusModeId value) async =>
      (await Commands.getCommandSetting(SettingsId.FocusMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusModeToggle(FocusModeToggleId value) async =>
      (await Commands.getCommandSetting(SettingsId.FocusModeToggleRequest,
                  opCodeId: OpCodeId.MainSetting, value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setImageFileFormat(ImageFileFormatId value) async =>
      (await Commands.getCommandSetting(SettingsId.FileFormat,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setIso(int value) async =>
      (await Commands.getCommandSetting(SettingsId.ISO,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value,
                  value1DataSize: 4)
              .send())
          .isValidResponse();

  @override
  Future<bool> setMeteringMode(MeteringModeId value) async =>
      (await Commands.getCommandSetting(SettingsId.MeteringMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setPictureEffect(PictureEffectId value) async =>
      (await Commands.getCommandSetting(SettingsId.PictureEffect,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setShutterSpeed(int value) async =>
      (await Commands.getCommandSetting(SettingsId.ShutterSpeed,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value,
                  value1DataSize: 4)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalance(WhiteBalanceId value) async =>
      (await Commands.getCommandSetting(SettingsId.WhiteBalance,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value) async =>
      (await Commands.getCommandSetting(SettingsId.WhiteBalanceAB,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceColorTemp(int value) async =>
      (await Commands.getCommandSetting(SettingsId.WhiteBalanceColorTemp,
                  value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value) async =>
      (await Commands.getCommandSetting(SettingsId.WhiteBalanceGM,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> startRecordingVideo() async =>
      (await Commands.getCommandSetting(SettingsId.RecordVideo,
                  opCodeId: OpCodeId.MainSetting, value1: 2)
              .send())
          .isValidResponse();

  @override
  Future<bool> stopRecordingVideo() async =>
      (await Commands.getCommandSetting(SettingsId.RecordVideo,
                  opCodeId: OpCodeId.MainSetting, value1: 1)
              .send())
          .isValidResponse();

  @override
  Future<RecordVideoStateValue> getRecordingVideoState() async =>
      device.cameraSettings.settings
          .firstWhere(
              (element) => element.settingsId == SettingsId.RecordVideoState)
          .value as RecordVideoStateValue;

  @override
  Future<SettingsItem<ImageSizeValue>> getImageSize() async =>
      device.cameraSettings.getItem(SettingsId.ImageSize);

  @override
  Future<bool> setImageSize(ImageSizeId value) async =>
      (await Commands.getCommandSetting(SettingsId.ImageSize,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<SettingsItem<IntValue>> getFlashValue() async =>
      device.cameraSettings.getItem(SettingsId.FlashValue);

  @override
  Future<SettingsItem<FocusModeToggleValue>> getFocusModeToggle() async =>
      device.cameraSettings.getItem(SettingsId.FocusModeToggleResponse);

/*
    int numPhotos = item.value.usbValue & 0xFF;
    bool photoAvailableForTransfer =
        ((item.value.usbValue >> 8) & 0xFF) == 0x80;
   */
  @override
  Future<bool> getPhotoAvailable() async =>
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
    var response = await Commands.getImageCommand(liveView, true).send();

    var bytes = response.inData.toByteList().buffer.asByteData();
    int numImages = bytes.getUint16(32, Endian.little); //not num but true/false
    int imageInfoUnk = bytes.getUint32(34, Endian.little); //TODO type?
    int imageSizeInBytes = bytes.getUint32(38, Endian.little);
    var name = String.fromCharCodes(response.inData
            .toByteList()
            .sublist(83, 83 + (bytes.getUint8(82) * 2)))
        .replaceAll(RegExp(r"\x00"), ""); //replace "NUL" characters

    return CameraImageRequest(
        numImages == 1, imageInfoUnk, imageSizeInBytes, name);
  }
}
