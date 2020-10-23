import 'package:sonyalphacontrol/sonyalphacontrol.dart';

enum FunctionAvailability { Available, Supported, Unsupported }

extension FunctionExtension on Function {
  /*
  final ItemId itemId;
  final ApiMethodId apiMethodId;
  final SonyWebApiServiceTypeId serviceId;
 */
  //TODO Get or get and Get available -> min one?
  bool isAvailable({SonyCameraDevice device}) {
    if (device == null) {
      device = SonyApi.connectedCamera;
    }

    return this.availability(device: device) == FunctionAvailability.Available;
  }

  FunctionAvailability availability({SonyCameraDevice device}) {
    if (device == null) {
      device = SonyApi.connectedCamera;
    }

    if (this == device.api.getWebApiVersionsCamera)
      return device.api.checkFunctionAvailability(ItemId.Versions, ApiMethodId.GET);

    if (this == device.api.getWebApiVersionsAvContent)
      return device.api
          .checkFunctionAvailability(ItemId.Versions, ApiMethodId.GET, service: SonyWebApiServiceTypeId.AV_CONTENT);

    if (this == device.api.getWebApiVersionsSystem)
      return device.api
          .checkFunctionAvailability(ItemId.Versions, ApiMethodId.GET, service: SonyWebApiServiceTypeId.SYSTEM);

    if (this == device.api.getWebApiVersionsAccessControl)
      return device.api
          .checkFunctionAvailability(ItemId.Versions, ApiMethodId.GET, service: SonyWebApiServiceTypeId.ACCESS_CONTROL);

    if (this == device.api.getWebApiVersionsGuide)
      return device.api
          .checkFunctionAvailability(ItemId.Versions, ApiMethodId.GET, service: SonyWebApiServiceTypeId.GUIDE);

    if (this == device.api.getMethodTypesCamera)
      return device.api.checkFunctionAvailability(ItemId.MethodTypes, ApiMethodId.GET);

    if (this == device.api.getMethodTypesAvContent)
      return device.api
          .checkFunctionAvailability(ItemId.MethodTypes, ApiMethodId.GET, service: SonyWebApiServiceTypeId.AV_CONTENT);

    if (this == device.api.getMethodTypesSystem)
      return device.api
          .checkFunctionAvailability(ItemId.MethodTypes, ApiMethodId.GET, service: SonyWebApiServiceTypeId.SYSTEM);

    if (this == device.api.getMethodTypesAccessControl)
      return device.api.checkFunctionAvailability(ItemId.MethodTypes, ApiMethodId.GET,
          service: SonyWebApiServiceTypeId.ACCESS_CONTROL);

    if (this == device.api.getMethodTypesGuide)
      return device.api
          .checkFunctionAvailability(ItemId.MethodTypes, ApiMethodId.GET, service: SonyWebApiServiceTypeId.GUIDE);

    if (this == device.api.getStorageInformation)
      return device.api.checkFunctionAvailability(ItemId.StorageInformation, ApiMethodId.GET);

    if (this == device.api.getContShootingSpeed)
      return device.api.checkFunctionAvailability(ItemId.ContShootingSpeed, ApiMethodId.GET);

    if (this == device.api.setContShootingSpeed)
      return device.api.checkFunctionAvailability(ItemId.ContShootingSpeed, ApiMethodId.SET);

    if (this == device.api.getContShootingMode)
      return device.api.checkFunctionAvailability(ItemId.ContShootingMode, ApiMethodId.GET);

    if (this == device.api.setContShootingMode)
      return device.api.checkFunctionAvailability(ItemId.ContShootingMode, ApiMethodId.SET);

    if (this == device.api.startContShooting)
      return device.api.checkFunctionAvailability(ItemId.ContShooting, ApiMethodId.START);

    if (this == device.api.stopContShooting)
      return device.api.checkFunctionAvailability(ItemId.ContShooting, ApiMethodId.STOP);

    if (this == device.api.startMovieRecording)
      return device.api.checkFunctionAvailability(ItemId.MovieRecording, ApiMethodId.START);

    if (this == device.api.stopMovieRecording)
      return device.api.checkFunctionAvailability(ItemId.MovieRecording, ApiMethodId.STOP);

    if (this == device.api.startAudioRecording)
      return device.api.checkFunctionAvailability(ItemId.AudioRecording, ApiMethodId.START);

    if (this == device.api.stopAudioRecording)
      return device.api.checkFunctionAvailability(ItemId.AudioRecording, ApiMethodId.STOP);

    if (this == device.api.getShootMode) return device.api.checkFunctionAvailability(ItemId.ShootMode, ApiMethodId.GET);

    if (this == device.api.setShootMode) return device.api.checkFunctionAvailability(ItemId.ShootMode, ApiMethodId.SET);

    if (this == device.api.getImageFileFormat)
      return device.api.checkFunctionAvailability(ItemId.ImageFileFormat, ApiMethodId.GET);

    if (this == device.api.setImageFileFormat)
      return device.api.checkFunctionAvailability(ItemId.ImageFileFormat, ApiMethodId.SET);

    if (this == device.api.startLiveView)
      return device.api.checkFunctionAvailability(ItemId.LiveView, ApiMethodId.START);

    if (this == device.api.stopLiveView) return device.api.checkFunctionAvailability(ItemId.LiveView, ApiMethodId.STOP);

    if (this == device.api.getImageSize) return device.api.checkFunctionAvailability(ItemId.ImageSize, ApiMethodId.GET);

    if (this == device.api.setImageSize) return device.api.checkFunctionAvailability(ItemId.ImageSize, ApiMethodId.SET);

    if (this == device.api.getAspectRatio)
      return device.api.checkFunctionAvailability(ItemId.AspectRatio, ApiMethodId.GET);

    if (this == device.api.setAspectRatio)
      return device.api.checkFunctionAvailability(ItemId.AspectRatio, ApiMethodId.SET);

    if (this == device.api.getAvailableFunctions)
      return device.api.checkFunctionAvailability(ItemId.AvailableFunctions, ApiMethodId.GET_AVAILABLE);

    if (this == device.api.getApplicationInfo)
      return device.api.checkFunctionAvailability(ItemId.ApplicationInfo, ApiMethodId.GET);

    if (this == device.api.getAvailableSettings)
      return device.api.checkFunctionAvailability(ItemId.AvailableSettings, ApiMethodId.GET);

    if (this == device.api.getCameraFunction)
      return device.api.checkFunctionAvailability(ItemId.CameraFunction, ApiMethodId.GET);

    if (this == device.api.setCameraFunction)
      return device.api.checkFunctionAvailability(ItemId.CameraFunction, ApiMethodId.SET);

    if (this == device.api.actCapturePhoto)
      return device.api.checkFunctionAvailability(ItemId.CapturePhoto, ApiMethodId.ACT);

    if (this == device.api.awaitCapturePhoto)
      return device.api.checkFunctionAvailability(ItemId.CapturePhoto, ApiMethodId.AWAIT);

    if (this == device.api.startCameraSetup)
      return device.api.checkFunctionAvailability(ItemId.CameraSetup, ApiMethodId.START);

    if (this == device.api.stopCameraSetup)
      return device.api.checkFunctionAvailability(ItemId.CameraSetup, ApiMethodId.STOP);

    if (this == device.api.actZoom) return device.api.checkFunctionAvailability(ItemId.Zoom, ApiMethodId.ACT);

    if (this == device.api.actHalfPressShutter)
      return device.api.checkFunctionAvailability(ItemId.HalfPressShutter, ApiMethodId.ACT);

    if (this == device.api.cancelHalfPressShutter)
      return device.api.checkFunctionAvailability(ItemId.HalfPressShutter, ApiMethodId.CANCEL);

    if (this == device.api.getSelfTimer) return device.api.checkFunctionAvailability(ItemId.SelfTimer, ApiMethodId.GET);

    if (this == device.api.setSelfTimer) return device.api.checkFunctionAvailability(ItemId.SelfTimer, ApiMethodId.SET);

    if (this == device.api.setExposureCompensation)
      return device.api.checkFunctionAvailability(ItemId.ExposureCompensation, ApiMethodId.SET);

    if (this == device.api.getExposureCompensation)
      return device.api.checkFunctionAvailability(ItemId.ExposureCompensation, ApiMethodId.GET);

    if (this == device.api.setFNumber) return device.api.checkFunctionAvailability(ItemId.FNumber, ApiMethodId.SET);

    if (this == device.api.getFNumber) return device.api.checkFunctionAvailability(ItemId.FNumber, ApiMethodId.GET);

    if (this == device.api.modifyFNumber) return device.api.checkFunctionAvailability(ItemId.FNumber, ApiMethodId.SET);

    if (this == device.api.setIso) return device.api.checkFunctionAvailability(ItemId.IsoSpeedRate, ApiMethodId.SET);

    if (this == device.api.getIso) return device.api.checkFunctionAvailability(ItemId.IsoSpeedRate, ApiMethodId.GET);

    if (this == device.api.modifyIso) return device.api.checkFunctionAvailability(ItemId.IsoSpeedRate, ApiMethodId.SET);

    if (this == device.api.getLiveViewSize)
      return device.api.checkFunctionAvailability(ItemId.LiveViewWithSize, ApiMethodId.GET);

    if (this == device.api.startLiveViewWithSize)
      return device.api.checkFunctionAvailability(ItemId.LiveViewWithSize, ApiMethodId.START);

    if (this == device.api.setPostViewImageSize)
      return device.api.checkFunctionAvailability(ItemId.PostViewImageSize, ApiMethodId.SET);

    if (this == device.api.getPostViewImageSize)
      return device.api.checkFunctionAvailability(ItemId.PostViewImageSize, ApiMethodId.GET);

    if (this == device.api.setProgramShift)
      return device.api.checkFunctionAvailability(ItemId.ProgramShift, ApiMethodId.SET);

    if (this == device.api.getProgramShift)
      return device.api.checkFunctionAvailability(ItemId.ProgramShift, ApiMethodId.GET);

    if (this == device.api.getShutterSpeed)
      return device.api.checkFunctionAvailability(ItemId.ShutterSpeed, ApiMethodId.GET);

    if (this == device.api.modifyShutterSpeed)
      return device.api.checkFunctionAvailability(ItemId.ShutterSpeed, ApiMethodId.SET);

    if (this == device.api.setShutterSpeed)
      return device.api.checkFunctionAvailability(ItemId.ShutterSpeed, ApiMethodId.SET);

    if (this == device.api.setFocusAreaSpot)
      return device.api.checkFunctionAvailability(ItemId.FocusAreaSpot, ApiMethodId.SET);

    if (this == device.api.getFocusAreaSpot)
      return device.api.checkFunctionAvailability(ItemId.FocusAreaSpot, ApiMethodId.GET);

    if (this == device.api.setWhiteBalanceMode)
      return device.api.checkFunctionAvailability(ItemId.WhiteBalanceMode, ApiMethodId.SET);

    if (this == device.api.getWhiteBalanceMode)
      return device.api.checkFunctionAvailability(ItemId.WhiteBalanceMode, ApiMethodId.GET);

    if (this == device.api.getWhiteBalanceColorTemp)
      return device.api.checkFunctionAvailability(ItemId.FocusAreaSpot, ApiMethodId.GET);

    if (this == device.api.modifyWhiteBalanceColorTemp)
      return device.api.checkFunctionAvailability(ItemId.WhiteBalanceMode, ApiMethodId.SET);

    if (this == device.api.setWhiteBalanceColorTemp)
      return device.api.checkFunctionAvailability(ItemId.WhiteBalanceMode, ApiMethodId.SET);

    if (this == device.api.setFlashMode) return device.api.checkFunctionAvailability(ItemId.FlashMode, ApiMethodId.SET);

    if (this == device.api.getFlashMode) return device.api.checkFunctionAvailability(ItemId.FlashMode, ApiMethodId.GET);

    if (this == device.api.setFocusMode) return device.api.checkFunctionAvailability(ItemId.FocusMode, ApiMethodId.SET);

    if (this == device.api.getFocusMode) return device.api.checkFunctionAvailability(ItemId.FocusMode, ApiMethodId.GET);

    if (this == device.api.setZoomSetting) return device.api.checkFunctionAvailability(ItemId.ZoomSetting, ApiMethodId.SET);

    if (this == device.api.getZoomSetting) return device.api.checkFunctionAvailability(ItemId.ZoomSetting, ApiMethodId.GET);

    if (this == device.api.setSilentShooting) return device.api.checkFunctionAvailability(ItemId.SilentShooting, ApiMethodId.SET);

    if (this == device.api.getSilentShooting) return device.api.checkFunctionAvailability(ItemId.SilentShooting, ApiMethodId.GET);

    if (this == device.api.setLiveViewInfo) return device.api.checkFunctionAvailability(ItemId.LiveViewFrameInfo, ApiMethodId.SET);

    if (this == device.api.getLiveViewInfo) return device.api.checkFunctionAvailability(ItemId.LiveViewFrameInfo, ApiMethodId.GET);

    return FunctionAvailability.Unsupported;
  }
}
