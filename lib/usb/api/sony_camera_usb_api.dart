import 'dart:math';

import 'package:flutter/material.dart';

//import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/top_level_api/api/force_update.dart';
import 'package:sonyalphacontrol/top_level_api/api/function_availability.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_image.dart';
import 'package:sonyalphacontrol/top_level_api/device/items.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_direction_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_magnifier_phase_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_gm_ids.dart';
import 'package:sonyalphacontrol/usb/commands/downloader.dart';
import 'package:sonyalphacontrol/usb/device/sony_camera_usb_device.dart';

import '../commands/usb_commands.dart';

//TODO 0000   10 00 00 00 04 00 03 c2 ff ff ff ff 1d d2 00 00 -> URB_INTERRUPT in when sth changed
//TODO register for event notifications
class SonyCameraUsbApi extends CameraApiInterface {
  SonyCameraUsbDevice get device => cameraDevice;

  SonyCameraUsbApi(SonyCameraDevice device) : super(device);

  Future<bool> setSettings(
      //TODO instead of int some SettingsValue<dynamic>
      ItemId settingsId,
      int value,
      SonyCameraUsbDevice device) async {
    switch (settingsId) {
      case ItemId.ImageFileFormat:
        return setImageFileFormat(ImageFileFormatValue.fromUSBValue(value));
      case ItemId.WhiteBalanceMode:
        return setWhiteBalanceMode(WhiteBalanceModeValue.fromUSBValue(value));
      case ItemId.FNumber:
        return modifyFNumber(value);
      case ItemId.FocusMode:
        return setFocusMode(FocusModeValue.fromUSBValue(value));
      case ItemId.MeteringMode:
        return setMeteringMode(MeteringModeValue.fromUSBValue(value));
      case ItemId.FlashMode:
        return setFlashMode(FlashModeValue.fromUSBValue(value));
      case ItemId.ShootMode:
        // TODO: Handle this case.
        break;
      case ItemId.ExposureCompensation:
        return modifyExposureCompensation(value);
      case ItemId.DriveMode:
        return setDriveMode(DriveModeIdExtension.getIdFromUsb(value));
      case ItemId.FlashValue:
        return setFlashValue(value);
      case ItemId.DroHdr:
        return setDroHdr(DroHdrIdExtension.getIdFromUsb(value));
      case ItemId.ImageSize:
        return setImageSize(ImageSizeIdExtension.getIdFromUsb(value));
      case ItemId.ShutterSpeed:
        return setShutterSpeed(
            ShutterSpeedValue.fromUsbValue(value as double, 0));
      case ItemId.WhiteBalanceColorTemp:
        return setWhiteBalanceColorTemp(
            WhiteBalanceColorTempValue.fromUSBValue(value));
      case ItemId.WhiteBalanceGM:
        return setWhiteBalanceGm(WhiteBalanceGmIdExtension.getIdFromUsb(value));
      case ItemId.AspectRatio:
        return setAspectRatio(AspectRatioIdExtension.getIdFromUsb(value));
      case ItemId.UnkD212:
        return false;
      case ItemId.Zoom:
        // TODO: Handle this case.
        break;
      case ItemId.AutoFocusState:
      case ItemId.AEL_State:
      case ItemId.BatteryInfo:
      case ItemId.RecordVideoState:
      case ItemId.LiveViewState:
      case ItemId.FEL_State:
      case ItemId.FocusMagnifierState:
        // STATE cannot be set
        break;
      case ItemId.SensorCrop:
        // TODO: Handle this case.
        break;
      case ItemId.PictureEffect:
        return setPictureEffect(PictureEffectIdExtension.getIdFromUsb(value));
      case ItemId.WhiteBalanceAB:
        return setWhiteBalanceAb(WhiteBalanceAbIdExtension.getIdFromUsb(value));
      case ItemId.ISO:
        return setIso(IsoValue(value)); //TODO test
      case ItemId.FocusArea:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierPhase:
        // TODO: Handle this case.
        break;
      case ItemId.PhotoTransferQueue:
        // cannot be set
        break;
      case ItemId.UnkD20E:
      case ItemId.UnkD222:
      case ItemId.UnkD22E:
      case ItemId.UnkD236:
      case ItemId.UnkD2D3:
      case ItemId.UnkD2D4:
        return false;
      case ItemId.UnkD2C5:
        /*
        return (await FlutterUsb.sendCommand(Command(
                Commands.getCommandMainSettingI16(SettingsId.UnkD2C5, value))))
            .isValidResponse();
        */
        return false;
      case ItemId.UnkD2C7:
        /*
        return (await FlutterUsb.sendCommand(Command(
                Commands.getCommandMainSettingI16(SettingsId.UnkD2C7, value))))
            .isValidResponse(); //TODO I32, subsettingss??
         */
        return false;
      case ItemId.Unknown:
        return false;
      case ItemId.FocusMagnifier:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierPosition:
        // TODO: Handle this case.
        break;
      case ItemId.UseLiveViewDisplayEffect:
        // TODO: Handle this case.
        break;
      case ItemId.FocusAreaSpot:
        // TODO: Handle this case.
        break;
      case ItemId.FocusModeToggleResponse:
        // TODO: Handle this case.
        break;
      case ItemId.HalfPressShutter:
        return pressShutter(ShutterPressType.Half);
      case ItemId.CapturePhoto:
        // TODO: Handle this case.
        break;
      case ItemId.AEL:
        return setAel(value == 1);
      case ItemId.RecordVideo:
        if (value == 1) {
          return startRecordingVideo();
        }
        return stopRecordingVideo();
        break;
      case ItemId.FEL:
        return setFel(value == 1);
      case ItemId.FocusMagnifierRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierResetRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierMoveUpRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierMoveDownRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierMoveLeftRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusMagnifierMoveRightRequest:
        // TODO: Handle this case.
        break;
      case ItemId.FocusDistance:
        // TODO: Handle this case.
        break;
      case ItemId.FocusModeToggleRequest:
        // TODO: Handle this case.
        break;
      case ItemId.LiveViewInfo:
        // TODO: Handle this case.
        break;
      case ItemId.PhotoInfo:
        // TODO: Handle this case.
        break;
      case ItemId.AvailableSettings:
        // TODO: Handle this case.
        break;
      case ItemId.CameraInfo:
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
                        ? ItemId.HalfPressShutter
                        : ItemId.CapturePhoto,
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
  Future<bool> setSettingsRaw(ItemId id, int value) {
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
  Future<int> getBatteryPercentage({ForceUpdate update}) async {
    return device.cameraSettings.batteryInfo.value.usbValue;
  }

  @override
  Future<bool> setAel(bool value) async {
    return (await UsbCommands.getCommandSetting(ItemId.AEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 1 : 2)
                .send())
            .isValidResponse()
        ? (await UsbCommands.getCommandSetting(ItemId.AEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 2 : 1)
                .send())
            .isValidResponse()
        : false;
  }

  @override
  Future<bool> setAspectRatio(AspectRatioId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.AspectRatio,
                  opCodeId: OpCodeId.SubSetting,
                  value1: value.usbValue,
                  value1DataSize: 1)
              .send())
          .isValidResponse();

  @override
  Future<bool> setDriveMode(DriveModeId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.DriveMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setDroHdr(DroHdrId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.DroHdr,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> modifyExposureCompensation(int value) async =>
      (await UsbCommands.getCommandSetting(ItemId.ExposureCompensation,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setExposureCompensation(EvValue value) async => throw UnimplementedError;

  @override
  Future<bool> modifyFNumber(int value) async =>
      (await UsbCommands.getCommandSetting(ItemId.FNumber,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFNumber(DoubleValue value) async => throw UnsupportedError;

  @override
  Future<bool> setFel(bool value) async {
    return (await UsbCommands.getCommandSetting(ItemId.FEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 1 : 2)
                .send())
            .isValidResponse()
        ? (await UsbCommands.getCommandSetting(ItemId.FEL,
                    opCodeId: OpCodeId.MainSetting, value1: value ? 2 : 1)
                .send())
            .isValidResponse()
        : false;
  }

  @override
  Future<bool> setFlashMode(FlashModeValue value) async =>
      (await UsbCommands.getCommandSetting(ItemId.FlashMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFlashValue(int value) async =>
      (await UsbCommands.getCommandSetting(ItemId.FlashValue,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusArea(FocusAreaId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.FocusArea,
                  opCodeId: OpCodeId.SubSetting, value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusAreaSpot(Point<num> value) async =>
      (await UsbCommands.getCommandSetting(ItemId.FocusAreaSpot,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value.y,
                  value2: value.x,
                  value1DataSize: 2,
                  value2DataSize: 2)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusDistance(int value) async =>
      (await UsbCommands.getCommandSetting(ItemId.FocusDistance,
                  opCodeId: OpCodeId.MainSetting, value1: value)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusMagnifier(double value) async {
    for (int i = 0; i < value; i++) {
      if ((await UsbCommands.getCommandSetting(ItemId.FocusMagnifierRequest,
                  opCodeId: OpCodeId.MainSetting, value1: 2)
              .send())
          .isValidResponse()) {
        if ((await UsbCommands.getCommandSetting(ItemId.FocusMagnifierRequest,
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
    ItemId settingsId;
    switch (value) {
      case FocusMagnifierDirectionId.Left:
        settingsId = ItemId.FocusMagnifierMoveLeftRequest;
        break;
      case FocusMagnifierDirectionId.Right:
        settingsId = ItemId.FocusMagnifierMoveRightRequest;
        break;
      case FocusMagnifierDirectionId.Up:
        settingsId = ItemId.FocusMagnifierMoveUpRequest;
        break;
      case FocusMagnifierDirectionId.Down:
        settingsId = ItemId.FocusMagnifierMoveDownRequest;
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
      (await UsbCommands.getCommandSetting(ItemId.FocusMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setFocusModeToggle(FocusModeToggleId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.FocusModeToggleRequest,
                  opCodeId: OpCodeId.MainSetting, value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setImageFileFormat(ImageFileFormatValue value) async =>
      (await UsbCommands.getCommandSetting(ItemId.ImageFileFormat,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> modifyIso(int direction) async => throw UnimplementedError();

  @override
  Future<bool> setIso(IsoValue value) async =>
      (await UsbCommands.getCommandSetting(ItemId.ISO,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value.usbValue,
                  value1DataSize: 4)
              .send())
          .isValidResponse();

  @override
  Future<bool> setMeteringMode(MeteringModeValue value) async =>
      (await UsbCommands.getCommandSetting(ItemId.MeteringMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setPictureEffect(PictureEffectId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.PictureEffect,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setShutterSpeed(ShutterSpeedValue value) async =>
      (await UsbCommands.getCommandSetting(ItemId.ShutterSpeed,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value.usbValue,
                  value1DataSize: 4)
              .send())
          .isValidResponse();

  @override
  Future<bool> modifyShutterSpeed(int value) async =>
      (await UsbCommands.getCommandSetting(ItemId.ShutterSpeed,
                  opCodeId: OpCodeId.MainSetting,
                  value1: value,
                  value1DataSize: 4)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceMode(WhiteBalanceModeValue value) async =>
      (await UsbCommands.getCommandSetting(ItemId.WhiteBalanceMode,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceAb(WhiteBalanceAbId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.WhiteBalanceAB,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceColorTemp(
          WhiteBalanceColorTempValue value) async =>
      (await UsbCommands.getCommandSetting(ItemId.WhiteBalanceColorTemp,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> setWhiteBalanceGm(WhiteBalanceGmId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.WhiteBalanceGM,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

  @override
  Future<bool> startRecordingVideo() async =>
      (await UsbCommands.getCommandSetting(ItemId.RecordVideo,
                  opCodeId: OpCodeId.MainSetting, value1: 2)
              .send())
          .isValidResponse();

  @override
  Future<bool> stopRecordingVideo() async =>
      (await UsbCommands.getCommandSetting(ItemId.RecordVideo,
                  opCodeId: OpCodeId.MainSetting, value1: 1)
              .send())
          .isValidResponse();

  @override
  Future<RecordVideoStateValue> getRecordingVideoState(
          {ForceUpdate update}) async =>
      device.cameraSettings.recordVideoState.value;

  @override
  Future<SettingsItem<ImageSizeValue>> getImageSize(
          {ForceUpdate update}) async =>
      device.cameraSettings.imageSize;

  @override
  Future<bool> setImageSize(ImageSizeId value) async =>
      (await UsbCommands.getCommandSetting(ItemId.ImageSize,
                  value1: value.usbValue)
              .send())
          .isValidResponse();

/*
    int numPhotos = item.value.usbValue & 0xFF;
    bool photoAvailableForTransfer =
        ((item.value.usbValue >> 8) & 0xFF) == 0x80;
   */
  @override
  Future<bool> getPhotoAvailable({ForceUpdate update}) async =>
      ((device.cameraSettings
                  .photoTransferQueue
                  .value
                  .usbValue >>
              8) &
          0xFF) ==
      0x80;

  @override
  Future<CameraImageRequest> requestPhotoAvailable(
      {bool liveView = false}) async {
    /*
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

     */
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
  Future<SettingsItem<StringValue>> getRecordingAudio({ForceUpdate update}) {
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
        var img = Image.memory(imgData.data, key: Key("liveviewimage"));
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
  Future<ListInfoItem<WebApiVersionsValue>> getWebApiVersions(
      SonyWebApiServiceTypeId serviceTypeId,
      {ForceUpdate update}) {
    // TODO: implement getWebApiVersions
    throw UnimplementedError();
  }

  //TODO difference only by itemId? because "get" and set then always available? or battery only info = only get
  @override
  FunctionAvailability checkFunction(ItemId itemId, ApiMethodId apiMethodId,
      {SonyWebApiServiceTypeId service = SonyWebApiServiceTypeId.CAMERA}) {
    // TODO: implement getInfo
    throw UnimplementedError();
  }

  @override
  Future<bool> setCameraFunction(CameraFunctionValue value) {
    // TODO: implement setCameraFunction
    throw UnimplementedError();
  }

  @override
  Future<ListInfoItem<StringValue>> actCapturePhoto() {
    // TODO: implement actCapturePhoto
    throw UnimplementedError();
  }

  @override
  Future<ListInfoItem<StringValue>> awaitCapturePhoto() {
    // TODO: implement awaitCapturePhoto
    throw UnimplementedError();
  }

  @override
  Future<bool> startRecMode() {
    // TODO: implement startRecMode
    throw UnimplementedError();
  }

  @override
  Future<bool> stopRecMode() {
    // TODO: implement stopRecMode
    throw UnimplementedError();
  }

  @override
  Future<bool> setZoomSetting(ZoomSettingValue value) {
    // TODO: implement setZoomSetting
    throw UnimplementedError();
  }

  @override
  Future<bool> actZoom(String direction, String movementparameter) {
    // TODO: implement actZoom
    throw UnimplementedError();
  }

  @override
  Future<bool> actHalfPressShutter() {
    // TODO: implement actHalfPressShutter
    throw UnimplementedError();
  }

  @override
  Future<bool> cancelHalfPressShutter() {
    // TODO: implement cancelHalfPressShutter
    throw UnimplementedError();
  }

  @override
  Future<bool> setSelfTimer(IntValue value) {
    // TODO: implement setSelfTimer
    throw UnimplementedError();
  }

  @override
  Future<bool> setPostViewImageSize(PostViewImageSizeValue value) {
    // TODO: implement setPostViewImageSize
    throw UnimplementedError();
  }

  @override
  Future<bool> startLiveViewWithSize(LiveViewSizeValue value) {
    // TODO: implement startLiveViewWithSize
    throw UnimplementedError();
  }

  @override
  Future<bool> setProgramShift(IntValue value) {
    // TODO: implement setProgramShift
    throw UnimplementedError();
  }

  @override
  Future<bool> setSilentShooting(OnOffValue value) {
    // TODO: implement setSilentShooting
    throw UnimplementedError();
  }

  //TODO return false for functions that are not supported by usb
  @override
  bool isAvailable(Function function) {
    // TODO: implement isAvailable
    throw UnimplementedError();
  }

  @override
  FunctionAvailability getAvailability(Function function) {
    // TODO: implement getAvailability
    throw UnimplementedError();
  }

  @override
  FunctionAvailability checkFunctionAvailability(ItemId itemId, ApiMethodId apiMethodId, {SonyWebApiServiceTypeId
  service = SonyWebApiServiceTypeId.CAMERA}) {
    // TODO: implement checkFunctionAvailability
    throw UnimplementedError();
  }

  @override
  Future<bool> setShootMode(ShootModeValue value) {
    // TODO: implement setShootMode
    throw UnimplementedError();
  }

}
