
/*
class SettingsItemUsb extends SettingsItem<USBValue> {
  int subValue;

  SettingsItemUsb(SettingsId settingsId) : super(settingsId);

  bool hasSubValue() {
    return (settingsId == SettingsId.FocusAreaSpot ||
        settingsId == SettingsId.FocusMagnifierPosition ||
        settingsId == SettingsId.ShutterSpeed);
  }

  List<USBValue> getAcceptedValues() {
    List<USBValue> values = new List();
    switch (settingsId) {
      case SettingsId.FocusMode:
        available.forEach((element) {
          var mode = getFocusModeId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.FileFormat:
        available.forEach((element) {
          var mode = getImageFileFormatId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.WhiteBalance:
        // TODO: Handle this case.
        break;
      case SettingsId.FNumber:
        // TODO: Handle this case.
        break;
      case SettingsId.MeteringMode:
        available.forEach((element) {
          var mode = getMeteringModeId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.FlashMode:
        available.forEach((element) {
          var mode = getFlashModeId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.ShootingMode:
        available.forEach((element) {
          var mode = getShootingModeId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.EV:
        // TODO: Handle this case.
        break;
      case SettingsId.DriveMode:
        available.forEach((element) {
          var mode = getDriveModeId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.Flash:
        available.forEach((element) {
          var mode = getFlashModeId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.DroHdr:
        available.forEach((element) {
          var mode = getDroHdrId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.ImageSize:
        available.forEach((element) {
          var mode = getImageSizeId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
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
        available.forEach((element) {
          var mode = getAspectRatioId(element.value);
          values.add(USBValue(mode.usbValue));//, mode.name));
        });
        break;
      case SettingsId.UnkD212:
        // TODO: Handle this case.
        break;
      case SettingsId.AutoFocusState:
        available.forEach((element) {
          var mode = getAutoFocusStateId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
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
        available.forEach((element) {
          var mode = getPictureEffectId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
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
        available.forEach((element) {
          var mode = getFocusAreaId(element.value);
          values.add(USBValue(mode.value));//, mode.name));
        });
        break;
      case SettingsId.FocusMagnifierPhase:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD22E:
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2C7:
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2D4:
        // TODO: Handle this case.
        break;
      case SettingsId.Unknown:
        // TODO: Handle this case.
        break;
      case SettingsId.LiveViewInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.PhotoInfo:
        // TODO: Handle this case.
        break;
    }
    return values;
  }

  String getValue() {
    switch (settingsId) {
      case SettingsId.FocusMode:
        return getFocusModeId(value.value).name;
      case SettingsId.FileFormat:
        return getImageFileFormatId(value.value).name;
      case SettingsId.WhiteBalance:
        // TODO: Handle this case.
        break;
      case SettingsId.FNumber:
        return (value.value / 100.0).toString();
        break;
      case SettingsId.MeteringMode:
        return getMeteringModeId(value.value).name;
      case SettingsId.FlashMode:
        return getFlashModeId(value.value).name;
      case SettingsId.ShootingMode:
        return getShootingModeId(value.value).name;
      case SettingsId.EV:
        // TODO: Handle this case.
        break;
      case SettingsId.DriveMode:
        return getDriveModeId(value.value).name;
      case SettingsId.Flash:
        //TODO 0 = no flash, 1= flash? x = x flashes?
        break;
      case SettingsId.DroHdr:
        return getDroHdrId(value.value).name;
      case SettingsId.ImageSize:
        return getImageSizeId(value.value).name;
      case SettingsId.ShutterSpeed:
        // TODO: Handle this case.
        //3 = 1/3
        //10 = 1/10
        //wrong above?!
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
        return getAspectRatioId(value.value).name;
      case SettingsId.UnkD212:
        // TODO: Handle this case.
        break;
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
        return getPictureEffectId(value.value).name;
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
        return getFocusAreaId(value.value).name;
      case SettingsId.FocusMagnifierPhase:
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD22E:
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
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
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2C7:
        // TODO: Handle this case.
        break;
      case SettingsId.RecordVideo:
        return getRecordVideoStateId(value.value).name;
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
        // TODO: Handle this case.
        break;
      case SettingsId.UnkD2D4:
        // TODO: Handle this case.
        break;
      case SettingsId.Unknown:
        // TODO: Handle this case.
        break;
      case SettingsId.LiveViewInfo:
        // TODO: Handle this case.
        break;
      case SettingsId.PhotoInfo:
        // TODO: Handle this case.
        break;
    }
    return value.toString();
  }
}

class USBValue extends Value {
  USBValue(value) : super(value);
}
*/