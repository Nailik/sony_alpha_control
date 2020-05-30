import 'package:sonyalphacontrol/ids/aspect_ratio_ids.dart';
import 'package:sonyalphacontrol/ids/drive_mode_ids.dart';
import 'package:sonyalphacontrol/ids/dro_hdr_ids.dart';
import 'package:sonyalphacontrol/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/ids/focus_area_ids.dart';
import 'package:sonyalphacontrol/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/ids/image_file_format_ids.dart';
import 'package:sonyalphacontrol/ids/image_size_ids.dart';
import 'package:sonyalphacontrol/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/ids/picture_effect_ids.dart';
import 'package:sonyalphacontrol/ids/record_video_state_ids.dart';
import 'package:sonyalphacontrol/ids/setting_ids.dart';
import 'package:sonyalphacontrol/ids/shooting_mode_ids.dart';

class SettingsItem {
  int value;
  int id;
  List<int> acceptedValues = new List();

  int subValue;

  bool hasSubValue() {
    return (id == SettingsId.FocusAreaSpot.value ||
        id == SettingsId.FocusMagnifierPosition.value ||
        id == SettingsId.ShutterSpeed.value);
  }

  List<AcceptedValue> getAcceptedValues() {
    List<AcceptedValue> values = new List();
    switch (getSettingsId(id)) {
      case SettingsId.FocusMode:
        acceptedValues.forEach((element) {
          var mode = getFocusModeId(element);
          values.add(AcceptedValue(mode.value, mode.name));
        });
        break;
      default:
        break;
    }
    return values;
  }

  String getValue() {
    switch (getSettingsId(id)) {
      case SettingsId.FocusMode:
        return getFocusModeId(value).name;
      case SettingsId.FileFormat:
        return getImageFileFormatId(value).name;
      case SettingsId.WhiteBalance:
        // TODO: Handle this case.
        break;
      case SettingsId.FNumber:
        return (value / 100.0).toString();
        break;
      case SettingsId.MeteringMode:
        return getMeteringModeId(value).name;
      case SettingsId.FlashMode:
        return getFlashModeId(value).name;
      case SettingsId.ShootingMode:
        return getShootingModeId(value).name;
      case SettingsId.EV:
        // TODO: Handle this case.
        break;
      case SettingsId.DriveMode:
        return getDriveModeId(value).name;
      case SettingsId.Flash:
        //TODO 0 = no flash, 1= flash? x = x flashes?
        break;
      case SettingsId.DroHdr:
        return getDroHdrId(value).name;
      case SettingsId.ImageSize:
        return getImageSizeId(value).name;
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
        return getAspectRatioId(value).name;
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
        return getPictureEffectId(value).name;
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
        return getFocusAreaId(value).name;
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
        return getRecordVideoStateId(value).name;
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
    }
    return value.toString();
  }
}

class AcceptedValue {
  int value;
  String name;

  AcceptedValue(this.value, this.name);
}
