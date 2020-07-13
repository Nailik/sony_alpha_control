import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

enum SettingsId {
  /// <summary>
  /// File format / image quality
  /// </summary>
  FileFormat,
  WhiteBalance,
  FNumber,
  FocusMode,
  MeteringMode,
  FlashMode,
  ShootingMode,
  EV,

  /// <summary>
  /// The camera drive mode (single shooting, continuous shooting, etc)
  /// </summary>
  DriveMode,
  FlashValue,

  /// <summary>
  /// DRO/Auto HDR (Dynamic-Range Optimizer / Auto High Dynamic Range)
  /// </summary>
  DroHdr,

  /// <summary>
  /// Image size (JPEG Image Size)
  /// </summary>
  ImageSize,
  ShutterSpeed,
  UnkD20E,
  WhiteBalanceColorTemp,
  WhiteBalanceGM,
  AspectRatio,
  UnkD212, //	/* poll camera until it is ready */

  /// <summary>
  /// Green focus state icon (circle / rings icon)
  /// </summary>
  AutoFocusState,
  Zoom,
// Taken from gphoto; untested ("might be focal length * 1.000.000")
  PhotoTransferQueue,

  /// <summary>
  /// This is the actual state (on/off) as opposed to the AEL button in the Remote UI
  /// </summary>
  AEL_State,
  BatteryInfo,

  /// <summary>
  /// APS-C/Super 35mm (sensor crop)
  /// </summary>
  SensorCrop,
  PictureEffect,
  WhiteBalanceAB,
  RecordVideoState,
  ISO,

  /// <summary>
  /// This is the actual state (on/off) as opposed to the FEL button in the Remote UI.
  /// (if "on" this will show the FEL lock icon in the Remote UI (in the top right))
  /// </summary>
  FEL_State,
  LiveViewState,
  UnkD222,
  FocusArea,
  FocusMagnifierPhase,

  /// <summary>
  /// APS-C/Super 35mm related?
  /// 04 00 00 02 00 00 26 00 02 00 00 - ON
  /// 04 00 00 02 00 00 3B 00 02 00 00 - OFF
  /// </summary>
  UnkD22E,
  FocusMagnifier,
  FocusMagnifierPosition,
  UseLiveViewDisplayEffect,
  FocusAreaSpot,

  /// <summary>
  /// Focus Magnifier button state in Remote UI (0=disabled, 1=enabled)
  /// </summary>
  FocusMagnifierState,

  /// <summary>
  /// Signifies that MF/AF changed
  /// 02 00 00 01 00 01 02 02 00 00 01 - MF mode
  /// 02 00 00 00 00 00 02 02 00 00 01 - AF mode
  /// (This is a response only. See FocusModeToggleRequest.)
  /// </summary>
  FocusModeToggleResponse,
  UnkD236,

  /// <summary>
  /// Half press the shutter buttton (AF button on the Remote UI)
  /// </summary>
  HalfPressShutter,

  /// <summary>
  /// Capture a still image
  /// </summary>
  CapturePhoto,

  /// <summary>
  /// The AEL button locks the exposure (AE lock). Use this button to shoot images in the following situations.
  /// - When you want to set the focus and the exposure separately.
  /// - When you want to shoot images continuously with a fixed exposure.
  /// </summary>
  AEL,
  UnkD2C5,
// gphoto calls this "StillImage"
  UnkD2C7,
  //value current: 1, valkues:
  // //1 starts a capture
  // 2 also starts captuer
  //one of those started hold half shutter

  /// <summary>
  /// Start / stop recording videos
  /// </summary>
  RecordVideo,

  /// <summary>
  /// The FEL button locks the flash level (FEL lock). Use this button to shoot different subjects with the same brightness.
  /// </summary>
  FEL,

  /// <summary>
  /// A request to increment the focus magnifier value
  /// </summary>
  FocusMagnifierRequest,

  /// <summary>
  /// A request to reset the focus magnifier value
  /// </summary>
  FocusMagnifierResetRequest,
  FocusMagnifierMoveUpRequest,
  FocusMagnifierMoveDownRequest,
  FocusMagnifierMoveLeftRequest,
  FocusMagnifierMoveRightRequest,
  FocusDistance,

  /// <summary>
  /// Used to toggle AF/MF (1=MF; 2=AF).
  /// Used to switch between MF/AF without modifying the current AF setting.
  /// (This is a request only. See FocusModeToggleResponse)
  /// </summary>
  FocusModeToggleRequest,
  UnkD2D3,
  UnkD2D4,
  LiveViewInfo,
  PhotoInfo,

  ///for the available camera settings
  AvailableSettings,

  ///for the current camera settings
  CameraInfo,
  Connect,
  Unknown
}

extension SettingsIdExtension on SettingsId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case SettingsId.FileFormat:
        return 0x5004;
      case SettingsId.WhiteBalance:
        return 0x5005;
      case SettingsId.FNumber:
        return 0x5007;
      case SettingsId.FocusMode:
        return 0x500A;
      case SettingsId.MeteringMode:
        return 0x500B;
      case SettingsId.FlashMode:
        return 0x500C;
      case SettingsId.ShootingMode:
        return 0x500E;
      case SettingsId.EV:
        return 0x5010;
      case SettingsId.DriveMode:
        return 0x5013;
      case SettingsId.FlashValue:
        return 0xD200;
      case SettingsId.DroHdr:
        return 0xD201;
      case SettingsId.ImageSize:
        return 0xD203;
      case SettingsId.ShutterSpeed:
        return 0xD20D;
      case SettingsId.UnkD20E:
        return 0xD20E;
      case SettingsId.WhiteBalanceColorTemp:
        return 0xD20F;
      case SettingsId.WhiteBalanceGM:
        return 0xD210;
      case SettingsId.AspectRatio:
        return 0xD211;
      case SettingsId.UnkD212:
        return 0xD212;
      case SettingsId.AutoFocusState:
        return 0xD213;
      case SettingsId.Zoom:
        return 0xD214;
      case SettingsId.PhotoTransferQueue:
        return 0xD215;
      case SettingsId.AEL_State:
        return 0xD217;
      case SettingsId.BatteryInfo:
        return 0xD218;
      case SettingsId.SensorCrop:
        return 0xD219;
      case SettingsId.PictureEffect:
        return 0xD21B;
      case SettingsId.WhiteBalanceAB:
        return 0xD21C;
      case SettingsId.RecordVideoState:
        return 0xD21D;
      case SettingsId.ISO:
        return 0xD21E;
      case SettingsId.FEL_State:
        return 0xD21F;
      case SettingsId.LiveViewState:
        return 0xD221;
      case SettingsId.UnkD222:
        return 0xD222;
      case SettingsId.FocusArea:
        return 0xD22C;
      case SettingsId.FocusMagnifierPhase:
        return 0xD22D;
      case SettingsId.UnkD22E:
        return 0xD22E;
      case SettingsId.FocusMagnifier:
        return 0xD22F;
      case SettingsId.FocusMagnifierPosition:
        return 0xD230;
      case SettingsId.UseLiveViewDisplayEffect:
        return 0xD231;
      case SettingsId.FocusAreaSpot:
        return 0xD232;
      case SettingsId.FocusMagnifierState:
        return 0x5005;
      case SettingsId.FocusModeToggleResponse:
        return 0xD235;
      case SettingsId.UnkD236:
        return 0xD236;
      case SettingsId.HalfPressShutter:
        return 0xD2C1;
      case SettingsId.CapturePhoto:
        return 0xD2C2;
      case SettingsId.AEL:
        return 0xD2C3;
      case SettingsId.UnkD2C5:
        return 0xD2C5;
      case SettingsId.UnkD2C7:
        return 0xD2C7;
      case SettingsId.RecordVideo:
        return 0xD2C8;
      case SettingsId.FEL:
        return 0xD2C9;
      case SettingsId.FocusMagnifierRequest:
        return 0xD2CB;
      case SettingsId.FocusMagnifierResetRequest:
        return 0xD2CC;
      case SettingsId.FocusMagnifierMoveUpRequest:
        return 0xD2CD;
      case SettingsId.FocusMagnifierMoveDownRequest:
        return 0xD2CE;
      case SettingsId.FocusMagnifierMoveLeftRequest:
        return 0xD2CF;
      case SettingsId.FocusMagnifierMoveRightRequest:
        return 0xD2D0;
      case SettingsId.FocusDistance:
        return 0xD2D1;
      case SettingsId.FocusModeToggleRequest:
        return 0xD2D2;
      case SettingsId.UnkD2D3:
        return 0xD2D3; //manual focus?
      case SettingsId.UnkD2D4:
        return 0xD2D4; //??
      case SettingsId.LiveViewInfo:
        return 0xC002;
      case SettingsId.PhotoInfo: //0c00
        return 0xC001;
      case SettingsId.AvailableSettings:
        return 0x00C8;
      case SettingsId.CameraInfo:
        return 0x00;
      case SettingsId.Connect:
        return 0x01;
      case SettingsId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue {
    switch (this) {
      case SettingsId.FileFormat:
        // TODO: Handle this case.
        break;
      case SettingsId.WhiteBalance:
        return "WhiteBalance";
      case SettingsId.FNumber:
        // TODO: Handle this case.
        break;
      case SettingsId.FocusMode:
        // TODO: Handle this case.
        break;
      case SettingsId.MeteringMode:
        // TODO: Handle this case.
        break;
      case SettingsId.FlashMode:
        return "FocusMode"; //set.. get...
      case SettingsId.ShootingMode:
        // TODO: Handle this case.
        break;
      case SettingsId.EV:
        // TODO: Handle this case.
        break;
      case SettingsId.DriveMode:
        // TODO: Handle this case.
        break;
      case SettingsId.FlashValue:
        // TODO: Handle this case.
        break;
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
      case SettingsId.Connect:
        // TODO: Handle this case.
        break;
      case SettingsId.Unknown:
        // TODO: Handle this case.
        break;
      default:
        return "";
    }
    return "";
  }
}

SettingsId getSettingsId(int usbValue) {
  return SettingsId.values.firstWhere((element) => element.usbValue == usbValue,
      orElse: () => SettingsId.Unknown);
}

class SettingsIdValue extends SettingsValue<SettingsId> {
  SettingsIdValue(SettingsId id) : super(id);

  @override
  factory SettingsIdValue.fromUSBValue(int usbValue) {
    return SettingsIdValue(getSettingsId(usbValue));
  }

  @override
  int get usbValue => id.usbValue;

  @override
  String get wifiValue => id.wifiValue;

  @override
  String get name => id.name;
}
