import 'package:sonyalphacontrol/top_level_api/api/logger.dart';

enum ItemId {
  /// <summary>
  /// File format / image quality
  /// </summary>
  ImageFileFormat, //StillQuality
  WhiteBalanceMode,
  FNumber,
  FocusMode,
  MeteringMode,
  FlashMode,
  ShootMode,
  ExposureCompensation,

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
  FocusState,
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
  IsoSpeedRate,

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
  FocusMagnifierDirection,
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
  LiveViewFrameInfo,
  PhotoInfo,

  ///for the available camera settings
  AvailableSettings,

  ///for the current camera settings
  CameraInfo,
  Connect,

  ///wifi only *****************************************************
  CameraStatus,
  ZoomInformation,
  StorageInformation,
  Versions,
  MethodTypes,
  AvailableFunctions,
  AvailableFunctions2,//for wifi
  EnableMethods,
  ApplicationInfo,
  BeepMode,
  CameraFunction,
  MovieQuality,
  MovieRecording,
  SteadyMode,
  ViewAngle,
  PostViewImageSize,
  SelfTimer,
  SilentShooting,
  ProgramShift,
  ContShooting,
  ContShootingMode,
  ContShootingSpeed,
  FlipSetting,
  IntervalTime,
  ColorSetting,
  MovieFileFormat,
  InfraredRemoteControl,
  TvColorSystem,
  TrackingFocus,
  AutoPowerOff,
  LoopRecordingTime,
  AudioRecording,
  WindNoiseReduction,
  BulbShooting,
  AudioRecordingSetting,
  CameraSetup,
  DateTimeSetting,
  DeleteContents,
  IntervalStillRecording,
  LiveView,
  LiveViewWithSize,
  LiveViewSize,
  LoopRecording,
  RemotePlayback,
  ZoomSetting,
  LiveViewOrientation,
  LiveViewStatus,
  PostViewUrlSet,
  ContShootingUrlSet,
  CameraFunctionResult,
  SceneSelection,
  IRRemoteControl,
  TrackingFocusState,
  RecordingTime,
  NumberOfShots,
  BulbCapturingTime,
  Content,
  RequestTo,
  ServiceProtocols,
  ApiInfo,
  Unknown,
}

extension ItemIdExtension on ItemId {
  String get name => toString().split('.')[1];

  int get usbValue {
    switch (this) {
      case ItemId.ImageFileFormat:
        return 0x5004;
      case ItemId.WhiteBalanceMode:
        return 0x5005;
      case ItemId.FNumber:
        return 0x5007;
      case ItemId.FocusMode:
        return 0x500A;
      case ItemId.MeteringMode:
        return 0x500B;
      case ItemId.FlashMode:
        return 0x500C;
      case ItemId.ShootMode:
        return 0x500E;
      case ItemId.ExposureCompensation:
        return 0x5010;
      case ItemId.DriveMode:
        return 0x5013;
      case ItemId.FlashValue:
        return 0xD200;
      case ItemId.DroHdr:
        return 0xD201;
      case ItemId.ImageSize:
        return 0xD203;
      case ItemId.ShutterSpeed:
        return 0xD20D;
      case ItemId.UnkD20E:
        return 0xD20E;
      case ItemId.WhiteBalanceColorTemp:
        return 0xD20F;
      case ItemId.WhiteBalanceGM:
        return 0xD210;
      case ItemId.AspectRatio:
        return 0xD211;
      case ItemId.UnkD212:
        return 0xD212;
      case ItemId.FocusState:
        return 0xD213;
      case ItemId.Zoom:
        return 0xD214;
      case ItemId.PhotoTransferQueue:
        return 0xD215;
      case ItemId.AEL_State:
        return 0xD217;
      case ItemId.BatteryInfo:
        return 0xD218;
      case ItemId.SensorCrop:
        return 0xD219;
      case ItemId.PictureEffect:
        return 0xD21B;
      case ItemId.WhiteBalanceAB:
        return 0xD21C;
      case ItemId.RecordVideoState:
        return 0xD21D;
      case ItemId.IsoSpeedRate:
        return 0xD21E;
      case ItemId.FEL_State:
        return 0xD21F;
      case ItemId.LiveViewState:
        return 0xD221;
      case ItemId.UnkD222:
        return 0xD222;
      case ItemId.FocusArea:
        return 0xD22C;
      case ItemId.FocusMagnifierPhase:
        return 0xD22D;
      case ItemId.UnkD22E:
        return 0xD22E;
      case ItemId.FocusMagnifier:
        return 0xD22F;
      case ItemId.FocusMagnifierPosition:
        return 0xD230;
      case ItemId.UseLiveViewDisplayEffect:
        return 0xD231;
      case ItemId.FocusAreaSpot:
        return 0xD232;
      case ItemId.FocusMagnifierState:
        return 0x5005;
      case ItemId.FocusModeToggleResponse:
        return 0xD235;
      case ItemId.UnkD236:
        return 0xD236;
      case ItemId.HalfPressShutter:
        return 0xD2C1;
      case ItemId.CapturePhoto:
        return 0xD2C2;
      case ItemId.AEL:
        return 0xD2C3;
      case ItemId.UnkD2C5:
        return 0xD2C5;
      case ItemId.UnkD2C7:
        return 0xD2C7;
      case ItemId.RecordVideo:
        return 0xD2C8;
      case ItemId.FEL:
        return 0xD2C9;
      case ItemId.FocusMagnifierRequest:
        return 0xD2CB;
      case ItemId.FocusMagnifierResetRequest:
        return 0xD2CC;
      case ItemId.FocusMagnifierMoveUpRequest:
        return 0xD2CD;
      case ItemId.FocusMagnifierMoveDownRequest:
        return 0xD2CE;
      case ItemId.FocusMagnifierMoveLeftRequest:
        return 0xD2CF;
      case ItemId.FocusMagnifierMoveRightRequest:
        return 0xD2D0;
      case ItemId.FocusDistance:
        return 0xD2D1;
      case ItemId.FocusModeToggleRequest:
        return 0xD2D2;
      case ItemId.UnkD2D3:
        return 0xD2D3; //manual focus?
      case ItemId.UnkD2D4:
        return 0xD2D4; //??
      case ItemId.LiveViewFrameInfo:
        return 0xC002;
      case ItemId.PhotoInfo: //0c00
        return 0xC001;
      case ItemId.AvailableSettings:
        return 0x00C8;
      case ItemId.CameraInfo:
        return 0x00;
      case ItemId.Connect:
        return 0x01;
      case ItemId.Unknown:
        return -1;
      default:
        return -2;
    }
  }

  String get wifiValue {
    switch (this) {
      case ItemId.CameraStatus:
        return "cameraStatus";
      case ItemId.Versions:
        return "versions";
      case ItemId.MethodTypes:
        return "methodTypes";
      case ItemId.ApplicationInfo:
        return "applicationInfo";
      case ItemId.AvailableFunctions: //TODO supported api list?
        return "apiList";
      case ItemId.AvailableFunctions2: //TODO supported api list?
        return "availableApiList";
      case ItemId.EnableMethods: //TODO supported api list?
        return "enableMethods";
      case ItemId.AvailableSettings:
        return "event";
      case ItemId.CapturePhoto:
        return "takePicture";
      case ItemId.CameraSetup:
        return "recMode";
      case ItemId.LiveViewState:
        return "liveviewStatus";
      case ItemId.LiveViewOrientation:
        return "liveviewOrientation";
      case ItemId.LiveViewStatus:
        return "liveviewStatus";
      case ItemId.LiveView:
        return "liveview";
      case ItemId.LiveViewWithSize:
        return "liveviewWithSize";
      case ItemId.LiveViewSize:
        return "liveviewSize";
      case ItemId.CameraFunction:
        return "cameraFunction";
      case ItemId.Zoom:
        return "zoom";
      case ItemId.ZoomInformation:
        return "zoomInformation";
      case ItemId.HalfPressShutter:
        return "halfPressShutter";
      case ItemId.SelfTimer:
        return "selfTimer";
      case ItemId.ContShooting:
        return "contShooting";
      case ItemId.ContShootingMode:
        return "contShootingMode";
      case ItemId.ContShootingSpeed:
        return "contShootingSpeed";
      case ItemId.ExposureCompensation:
        return "exposureCompensation";
      case ItemId.FNumber:
        return "fNumber";
      case ItemId.IsoSpeedRate:
        return "isoSpeedRate";
      case ItemId.PostViewImageSize:
        return "postviewImageSize";
      case ItemId.ProgramShift:
        return "programShift";
      case ItemId.MeteringMode:
        return "exposureMode"; //TODO exposure mode somehow together with shootmode
      case ItemId.ShootMode:
        return "shootMode";
      case ItemId.ShutterSpeed:
        return "shutterSpeed";
      case ItemId.FocusAreaSpot:
        return "touchAFPosition";
      case ItemId.WhiteBalanceMode:
        return "whiteBalance";
      case ItemId.WhiteBalanceColorTemp:
        return "WhiteBalanceColorTemp";
      case ItemId.WhiteBalanceGM:
        return "";
      case ItemId.FlashMode:
        return "flashMode";
      case ItemId.FocusMode:
        return "focusMode";
      case ItemId.ZoomSetting:
        return "zoomSetting";
      case ItemId.StorageInformation:
        return "storageInformation";
      case ItemId.LiveViewFrameInfo:
        return "liveviewFrameInfo";
      case ItemId.SilentShooting: //"silentShootingSetting"; //TODO??
        return "silentShootingSetting";
      case ItemId.SteadyMode:
        return "steadyMode";
      case ItemId.BeepMode:
        return "beepMode";
      case ItemId.MovieQuality:
        return "movieQuality";
      case ItemId.MovieRecording:
        return "movieRec";
      case ItemId.ViewAngle:
        return "viewAngle";
      case ItemId.FlipSetting:
        return "flipSetting";
      case ItemId.IntervalTime:
        return "intervalTime";
      case ItemId.ColorSetting:
        return "colorSetting";
      case ItemId.MovieFileFormat:
        return "movieFileFormat";
      case ItemId.InfraredRemoteControl:
        return "infraredRemoteControl";
      case ItemId.TvColorSystem:
        return "tvColorSystem";
      case ItemId.TrackingFocus:
        return "trackingFocus";
      case ItemId.AutoPowerOff:
        return "autoPowerOff";
      case ItemId.LoopRecordingTime:
        return "loopRecTime";
      case ItemId.AudioRecording:
        return "audioRecording";
      case ItemId.WindNoiseReduction:
        return "windNoiseReduction";
      case ItemId.BulbShooting:
        return "bulbShooting";
      case ItemId.AudioRecordingSetting:
        return "audioRecordingSetting";
      case ItemId.DateTimeSetting:
        return "dateTimeSetting";
      case ItemId.DeleteContents:
        return "deleteContent";
      case ItemId.IntervalStillRecording:
        return "intervalStillRecording";
      case ItemId.LoopRecording:
        return "loopRecording";
      case ItemId.RemotePlayback:
        return "remotePlayback";
      case ItemId.ImageFileFormat:
        return "stillQuality";
      case ItemId.RecordVideo:
        return "movieRecording";
      case ItemId.ImageSize:
        return "stillSize";
      case ItemId.AspectRatio:
        return "";//TODO?
      case ItemId.PhotoTransferQueue:
        return "transferringImages";
      case ItemId.PictureEffect:
        return "sceneSelection";
      case ItemId.BatteryInfo:
        return "batteryInfo";
      case ItemId.RecordVideoState:
        return "movieRecording";
      case ItemId.CameraInfo:
        return "serverInformation";
      case ItemId.Content:
        return "content";
      case ItemId.RequestTo:
        return "requestTo";
      case ItemId.ServiceProtocols:
        return "serviceProtocols";
      case ItemId.ApiInfo:
        return "apiInfo";
      case ItemId.DriveMode:
        return "";
      case ItemId.FlashValue:
        return "";
      case ItemId.DroHdr:
        return "";
      case ItemId.UnkD20E:
        return "";
      case ItemId.UnkD212:
        return "";
      case ItemId.FocusState:
        return "focusStatus";
      case ItemId.AEL_State:
        return "";
      case ItemId.SensorCrop:
        return "";
      case ItemId.WhiteBalanceAB:
        return "";
      case ItemId.FEL_State:
        return "";
      case ItemId.UnkD222:
        return "";
      case ItemId.FocusArea:
        return "";
      case ItemId.FocusMagnifierPhase:
        return "";
      case ItemId.UnkD22E:
        return "";
      case ItemId.FocusMagnifier:
        return "";
      case ItemId.FocusMagnifierPosition:
        return "";
      case ItemId.UseLiveViewDisplayEffect:
        return "";
      case ItemId.FocusMagnifierState:
        return "";
      case ItemId.FocusModeToggleResponse:
        return "";
      case ItemId.UnkD236:
        return "";
      case ItemId.AEL:
        return "";
      case ItemId.UnkD2C5:
        return "";
      case ItemId.UnkD2C7:
        return "";
      case ItemId.FEL:
        return "";
      case ItemId.FocusMagnifierRequest:
        return "";
      case ItemId.FocusMagnifierResetRequest:
        return "";
      case ItemId.FocusMagnifierMoveUpRequest:
        return "";
      case ItemId.FocusMagnifierMoveDownRequest:
        return "";
      case ItemId.FocusMagnifierMoveLeftRequest:
        return "";
      case ItemId.FocusMagnifierMoveRightRequest:
        return "";
      case ItemId.FocusDistance:
        return "";
      case ItemId.FocusModeToggleRequest:
        return "";
      case ItemId.UnkD2D3:
        return "";
      case ItemId.UnkD2D4:
        return "";
      case ItemId.PhotoInfo:
        return "";
      case ItemId.Connect:
        return "";
      case ItemId.Unknown:
        return "";
      default:
        return "";
    }
  }

  static ItemId getIdFromUsb(int? usbValue) => ItemId.values
          .firstWhere((element) => element.usbValue == usbValue, orElse: () {
        Logger.n(ItemId, usbValue);
        return ItemId.Unknown;
      });

  static ItemId getIdFromWifi(String? wifiValue) => ItemId.values
          .firstWhere((element) => element.wifiValue == wifiValue, orElse: () {
        Logger.n(ItemId, wifiValue);
        return ItemId.Unknown;
      });
}
