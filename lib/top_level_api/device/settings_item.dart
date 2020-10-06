//a set function is like "fmode" you have available settings and choose one

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';

//TODO settingsItem and info item

class SettingsItem<T extends Value> extends ChangeNotifier {
  final ItemId itemId;

  T get value => _value;
  T _value;

  List<T> get available => _available;
  List<T> _available = new List.unmodifiable({});

  List<T> get supported => _supported;
  List<T> _supported = new List.unmodifiable({});

  List<SonyWebApiMethodId> get supportedMethods =>
      new List.unmodifiable({}); //TODO setup this

  //not different setter to not notify layout changes too often when multiple values are updated at the same time one after another
  updateItem(T newValue, List<T> newAvailable, List<T> newSupported) {
    if (_value != newValue ||
        _available != newAvailable ||
        _supported != newSupported) {
      //TODO list check all items?
      _value = newValue;
      _available = new List.unmodifiable(newAvailable);
      _supported = new List.unmodifiable(newSupported);

      notifyListeners();
    }
  }

  SettingsItem(this.itemId);

  bool hasSubValue() {
    return (itemId == ItemId.FocusAreaSpot ||
        itemId == ItemId.FocusMagnifierPosition ||
        itemId == ItemId.ShutterSpeed);
  }

  //TODO speichern welche methoden möglich sind für dieses "settingsid" item
  //TODO für wifi available apilist nutzen, für usb nur ob diese funktion implementiert ist
  //TODO methoden beim erstellen hinzufügen?

  //TODO stillsize(usb) - size and aspect ratio (wifi)
  //TODO drivemode cont and timer (usb) - single on wifi (different methods) TODO test
  //TODO cont shooting on wifi - on off via "start cont shooting" (bracket not wupporte?)
  //TODO cont shooting speed and state together in usb, different in wifi

  //TODO zusammengefasstes "teilen" auch in usb -> man wählt das eine aus,

//SettingsIdExtension.getSettingsIdWifi(value["type"].toString(
  Value fromWifi(dynamic wifiValue) {
    switch (itemId) {
      case ItemId.Versions:
        return WebApiVersionsValue.fromWifiValue(wifiValue);
      case ItemId.MethodTypes:
        return WebApiMethodValue.fromWifiValue(wifiValue);
      case ItemId.ImageFileFormat: //StillQuality
        return ImageFileFormatValue.fromWifiValue(wifiValue);
      case ItemId.ApiList:
        return StringValue(wifiValue);
      case ItemId.CameraStatus:
        return CameraStatusValue.fromWifiValue(wifiValue);
      case ItemId.ZoomInformation:
      //TODO return StringValue(wifiValue);
      case ItemId.LiveViewState:
        return BoolValue(wifiValue);
      case ItemId.LiveViewOrientation:
        return StringValue(wifiValue); //TODO enum 0,90,180,270
      case ItemId.PostViewUrlSet:
      //TODO
      case ItemId.LiveViewSize:
        return LiveViewSizeValue.fromWifiValue(wifiValue);
      case ItemId.ContShootingUrlSet:
      //TODO
      case ItemId.StorageInformation:
      //TODO return StringValue(wifiValue);
      case ItemId.BeepMode:
        return StringValue(wifiValue); //TODO enum
      case ItemId.CameraFunction:
        return CameraFunctionValue.fromWifiValue(wifiValue);
      case ItemId.EV: //exposureCompensation
        throw UnsupportedError; //this should never be called //EvValue(double.parse(wifiValue));
      case ItemId.MovieQuality:
        return MovieQualityValue.fromWifiValue(wifiValue);
      case ItemId.CameraFunctionResult:
      //TODO
      case ItemId.SteadyMode:
        return OnOffValue(wifiValue);
      case ItemId.ViewAngle:
        return IntValue(int.parse(wifiValue));
      case ItemId.FlipSetting:
        return OnOffValue(wifiValue);
      case ItemId.SceneSelection:
      //TODO
      case ItemId.IntervalTime:
      //TODO
      case ItemId.ColorSetting:
      //TODO
      case ItemId.MovieFileFormat:
        return MovieFileFormatValue.fromWifiValue(wifiValue);
      case ItemId.IRRemoteControl:
        return OnOffValue(wifiValue);
      case ItemId.TvColorSystem:
      //TODO
      case ItemId.PostViewImageSize:
        return StringValue(wifiValue);
      case ItemId.SelfTimer:
        return IntValue(wifiValue);
      case ItemId.ShootingMode:
      //TODO  return ShootingModeValue.fromWifiValue(wifiValue);
      case ItemId.MeteringMode: //exposureMode
      //TODO  return MeteringModeValue.fromWifiValue(wifiValue);
      case ItemId.FlashMode:
        return FlashModeValue.fromWifiValue(wifiValue);
      case ItemId.FNumber:
        return DoubleValue(
            double.parse(wifiValue.replaceAll(",", "."))); //durch 100
      case ItemId.FocusMode:
        return FocusModeValue.fromWifiValue(wifiValue);
      case ItemId.ISO:
        return IsoValue.fromWifiValue(
            wifiValue); //TODO test noise reduction, auto ...
      case ItemId.ProgramShift:
      //TODO  return StringValue(wifiValue);
      case ItemId.ShutterSpeed:
        return ShutterSpeedValue.fromWifiValue(wifiValue);
      case ItemId.WhiteBalanceMode:
        throw UnsupportedError; //should never be called return WhiteBalanceModeValue.fromWifiValue(wifiValue);
      case ItemId.FocusAreaSpot: //touchAFPosition
      //TODO  return IntValue(wifiValue);
      case ItemId.AutoFocusState:
      //TODO  return AutoFocusStateValue.fromWifiValue(wifiValue);
      case ItemId.TrackingFocusStatus:
      //TODO
      case ItemId.TrackingFocus:
        return OnOffValue(wifiValue);
      case ItemId.ZoomSetting: //FocusStatus
      //TODO   return StringValue(wifiValue);
      case ItemId.ZoomSetting: //FocusStatus
        return ZoomSettingValue.fromWifiValue(wifiValue);
      case ItemId.ContShootingMode:
      //TODO return ContShootingModeValue.fromWifiValue(wifiValue);
      case ItemId.ContShootingSpeed:
      //TODO  return ContShootingSpeedValue.fromWifiValue(wifiValue);
      case ItemId.BatteryInfo: //BatteryInformation
      //TODO   return IntValue(wifiValue);
      case ItemId.SilentShooting:
      //TODO  return StringValue(wifiValue); //bool value?
      case ItemId.RecordingTime:
      //TODO
      case ItemId.NumberOfShots:
      //TODO
      case ItemId.AutoPowerOff:
      //TODO
      case ItemId.LoopRecordingTime:
      //TODO
      case ItemId.AudioRecordingSetting:
      //TODO
      case ItemId.WindNoiseReduction:
      //TODO
      case ItemId.SilentShootingSetting:
      //TODO
      case ItemId.BulbCapturingTime:
      //TODO
      default:
        return null;
        break;
    }
  }

  Value fromUsb(int usbValue, {int subValue = 1}) {
    switch (itemId) {
      case ItemId.ImageFileFormat:
        return ImageFileFormatValue.fromUSBValue(usbValue);
      case ItemId.WhiteBalanceMode:
        return WhiteBalanceModeValue.fromUSBValue(usbValue);
      case ItemId.FNumber:
        return DoubleValue(usbValue as double); //TODO test
      case ItemId.FocusMode:
        return FocusModeValue.fromUSBValue(usbValue);
      case ItemId.MeteringMode:
        return MeteringModeValue.fromUSBValue(usbValue);
      case ItemId.FlashMode:
        return FlashModeValue.fromUSBValue(usbValue);
      case ItemId.ShootingMode:
        return ShootingModeValue.fromUSBValue(usbValue);
      case ItemId.EV:
        return IntValue(usbValue);
      case ItemId.DriveMode:
        return DriveModeValue.fromUSBValue(usbValue);
      case ItemId.FlashValue:
        return IntValue(usbValue);
      case ItemId.DroHdr:
        return DroHdrValue.fromUSBValue(usbValue);
      case ItemId.ImageSize:
        return ImageSizeValue.fromUSBValue(usbValue);
      case ItemId.ShutterSpeed:
        return ShutterSpeedValue(usbValue.toDouble(), subValue);
      case ItemId.UnkD20E:
        print("UnkD20E $usbValue");
        return IntValue(usbValue);
      case ItemId.WhiteBalanceColorTemp:
        return IntValue(usbValue);
      case ItemId.WhiteBalanceGM:
        return WhiteBalanceGmValue.fromUSBValue(usbValue);
      case ItemId.AspectRatio:
        return AspectRatioValue.fromUSBValue(usbValue);
      case ItemId.UnkD212:
        print("UnkD212 $usbValue");
        return IntValue(usbValue);
      case ItemId.AutoFocusState:
        return AutoFocusStateValue.fromUSBValue(usbValue);
      case ItemId.Zoom:
        return IntValue(usbValue);
      case ItemId.PhotoTransferQueue:
        return IntValue(usbValue); //32769  & 0xFF
      case ItemId.AEL_State:
        return BoolValue(usbValue == 2);
      case ItemId.BatteryInfo:
        return IntValue(usbValue);
      case ItemId.SensorCrop:
        return BoolValue(usbValue == 2);
      case ItemId.PictureEffect:
        return PictureEffectValue.fromUSBValue(usbValue);
      case ItemId.WhiteBalanceAB:
        return WhiteBalanceAbValue.fromUSBValue(usbValue);
      case ItemId.RecordVideoState:
        return RecordVideoStateValue.fromUSBValue(usbValue);
      case ItemId.ISO:
        return IsoValue(usbValue);
      case ItemId.FEL_State:
        return BoolValue(usbValue == 2);
      case ItemId.LiveViewState:
        return BoolValue(usbValue == 2);
      case ItemId.UnkD222:
        print("UnkD222 $usbValue");
        return IntValue(usbValue);
      case ItemId.FocusArea:
        return FocusAreaValue.fromUSBValue(usbValue);
      case ItemId.FocusMagnifierPhase:
        return FocusMagnifierPhaseValue.fromUSBValue(usbValue);
      case ItemId.UnkD22E:
        print("UnkD22E $usbValue");
        return IntValue(usbValue);
      case ItemId.FocusMagnifier:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierPosition:
        return IntValue(usbValue);
      case ItemId.UseLiveViewDisplayEffect:
        return BoolValue(usbValue == 2);
      case ItemId.FocusAreaSpot:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierState:
        return BoolValue(usbValue == 2);
      case ItemId.FocusModeToggleResponse:
        return IntValue(usbValue);
      case ItemId.UnkD236:
        print("UnkD236 $usbValue");
        return IntValue(usbValue);
      case ItemId.HalfPressShutter:
        return BoolValue(usbValue == 2);
      case ItemId.CapturePhoto:
        return BoolValue(usbValue == 2);
      case ItemId.AEL:
        return IntValue(usbValue);
      case ItemId.UnkD2C5:
        print("UnkD2C5 $usbValue");
        return IntValue(usbValue);
      case ItemId.UnkD2C7:
        print("UnkD2C7 $usbValue");
        return IntValue(usbValue);
      case ItemId.RecordVideo:
        return BoolValue(usbValue == 2);
      case ItemId.FEL:
        return BoolValue(usbValue == 2);
      case ItemId.FocusMagnifierRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierResetRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierMoveUpRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierMoveDownRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierMoveLeftRequest:
        return IntValue(usbValue);
      case ItemId.FocusMagnifierMoveRightRequest:
        return IntValue(usbValue);
      case ItemId.FocusDistance:
        return IntValue(usbValue);
      case ItemId.FocusModeToggleRequest:
        return IntValue(usbValue);
      case ItemId.UnkD2D3:
        print("UnkD2D3 $usbValue");
        return IntValue(usbValue);
      case ItemId.UnkD2D4:
        print("UnkD2D4 $usbValue");
        return IntValue(usbValue);
      case ItemId.LiveViewInfo:
        return IntValue(usbValue);
      case ItemId.PhotoInfo:
        return IntValue(usbValue);
      case ItemId.Unknown:
        print("Unknown $usbValue");
        return IntValue(usbValue);
      case ItemId.AvailableSettings:
        return IntValue(usbValue);
      case ItemId.CameraInfo:
        return IntValue(usbValue);
      case ItemId.Connect:
        return IntValue(usbValue);
      case ItemId.Versions:
        throw UnsupportedError;
      default:
        throw UnsupportedError;
    }
  }

  createListFromWifiJson(List<dynamic> list) =>
      list.map<T>((e) => fromWifi(e)).toList();
}
