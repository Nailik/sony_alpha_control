

/*
enum SonyWebApiMethod_Old {
  GET_SUPPORTED,
  GET_AVAILABLE,
  SET_SHOOT_MODE,
  GET_SHOOT_MODE,
  GET_SUPPORTED_SHOOT_MODE,
  GET_AVAILABLE_SHOOT_MODE,
  ACT_TAKE_PICTURE,
  AWAIT_TAKE_PICTURE,
  START_CONT_SHOOTING,
  STOP_CONT_SHOOTING,
  START_MOVIE_REC,
  STOP_MOVIE_REC,
  START_AUDIO_REC,
  STOP_AUDIO_REC,
  START_INTERVAL_STILL_REC,
  STOP_INTERVAL_STILL_REC,
  START_LOOP_REC,
  STOP_LOOP_REC,
  START_LIVE_VIEW,
  STOP_LIVE_VIEW,
  START_LIVE_VIEW_WITH_SIZE,
  GET_LIVE_VIEW_SIZE,
  GET_SUPPORTED_LIVE_VIEW_SIZE,
  GET_AVAILABLE_LIVE_VIEW_SIZE,
  SET_LIVE_VIEW_FRAME_INFO,
  GET_LIVE_VIEW_FRAME_INFO,
  ACT_ZOOM,
  SET_ZOOM_SETTING,
  GET_ZOOM_SETTING,
  GET_SUPPORTED_ZOOM_SETTING,
  GET_AVAILABLE_ZOOM_SETTING,
  ACT_HALF_PRESS_SHUTTER,
  CANCEL_HALF_PRESS_SHUTTER,
  SET_TOUCH_AF_POSITION,
  GET_TOUCH_AF_POSITION,
  CANCEL_TOUCH_AF_POSITION,
  ACT_TRACKING_FOCUS,
  CANCEL_TRACKING_FOCUS,
  SET_TRACKING_FOCUS,
  GET_TRACKING_FOCUS,
  GET_SUPPORTED_TRACKING_FOCUS,
  GET_AVAILABLE_TRACKING_FOCUS,
  SET_CONT_SHOOTING_MODE,
  GET_CONT_SHOOTING_MODE,
  GET_SUPPORTED_CONT_SHOOTING_MODE,
  GET_AVAILABLE_CONT_SHOOTING_MODE,
  SET_CONT_SHOOTING_SPEED,
  GET_CONT_SHOOTING_SPEED,
  GET_SUPPORTED_CONT_SHOOTING_SPEED,
  GET_AVAILABLE_CONT_SHOOTING_SPEED,
  SET_SELF_TIMER,
  GET_SELF_TIMER,
  GET_SUPPORTED_SELF_TIMER,
  GET_AVAILABLE_SELF_TIMER,
  SET_EXPOSURE_MODE,
  GET_EXPOSURE_MODE,
  GET_SUPPORTED_EXPOSURE_MODE,
  GET_AVAILABLE_EXPOSURE_MODE,
  SET_FOCUS_MODE,
  GET_FOCUS_MODE,
  GET_SUPPORTED_FOCUS_MODE,
  GET_AVAILABLE_FOCUS_MODE,
  SET_EXPOSURE_COMPENSATION,
  GET_EXPOSURE_COMPENSATION,
  GET_SUPPORTED_EXPOSURE_COMPENSATION,
  GET_AVAILABLE_EXPOSURE_COMPENSATION,
  SET_F_NUMBER,
  GET_F_NUMBER,
  GET_SUPPORTED_F_NUMBER,
  GET_AVAILABLE_F_NUMBER,
  SET_SHUTTER_SPEED,
  GET_SHUTTER_SPEED,
  GET_SUPPORTED_SHUTTER_SPEED,
  GET_AVAILABLE_SHUTTER_SPEED,
  SET_ISO_SPEED_RATE,
  GET_ISO_SPEED_RATE,
  GET_SUPPORTED_ISO_SPEED_RATE,
  GET_AVAILABLE_ISO_SPEED_RATE,
  SET_WHITE_BALANCE,
  GET_WHITE_BALANCE,
  GET_SUPPORTED_WHITE_BALANCE,
  GET_AVAILABLE_WHITE_BALANCE,
  ACT_WHITE_BALANCE_ONE_PUSH_CUSTOM,
  SET_PROGRAM_SHIFT,
  GET_SUPPORTED_PROGRAM_SHIFT,
  SET_FLASH_MODE,
  GET_FLASH_MODE,
  GET_SUPPORTED_FLASH_MODE,
  GET_AVAILABLE_FLASH_MODE,
  SET_STILL_SIZE,
  GET_STILL_SIZE,
  GET_SUPPORTED_STILL_SIZE,
  GET_AVAILABLE_STILL_SIZE,
  SET_STILL_QUALITY,
  GET_STILL_QUALITY,
  GET_SUPPORTED_STILL_QUALITY,
  GET_AVAILABLE_STILL_QUALITY,
  SET_POST_VIEW_IMAGE_SIZE,
  GET_POST_VIEW_IMAGE_SIZE,
  GET_SUPPORTED_POST_VIEW_IMAGE_SIZE,
  GET_AVAILABLE_POST_VIEW_IMAGE_SIZE,
  SET_MOVIE_FILE_FORMAT,
  GET_MOVIE_FILE_FORMAT,
  GET_SUPPORTED_MOVIE_FILE_FORMAT,
  GET_AVAILABLE_MOVIE_FILE_FORMAT,
  SET_MOVIE_QUALITY,
  GET_MOVIE_QUALITY,
  GET_SUPPORTED_MOVIE_QUALITY,
  GET_AVAILABLE_MOVIE_QUALITY,
  SET_STEADY_MODE,
  GET_STEADY_MODE,
  GET_SUPPORTED_STEADY_MODE,
  GET_AVAILABLE_STEADY_MODE,
  SET_VIEW_ANGLE,
  GET_VIEW_ANGLE,
  GET_SUPPORTED_VIEW_ANGLE,
  GET_AVAILABLE_VIEW_ANGLE,
  SET_SCENE_SELECTION,
  GET_SCENE_SELECTION,
  GET_SUPPORTED_SCENE_SELECTION,
  GET_AVAILABLE_SCENE_SELECTION,
  SET_COLOR_SETTING,
  GET_COLOR_SETTING,
  GET_SUPPORTED_COLOR_SETTING,
  GET_AVAILABLE_COLOR_SETTING,
  SET_INTERVAL_TIME,
  GET_INTERVAL_TIME,
  GET_SUPPORTED_INTERVAL_TIME,
  GET_AVAILABLE_INTERVAL_TIME,
  SET_LOOP_REC_TIME,
  GET_LOOP_REC_TIME,
  GET_SUPPORTED_LOOP_REC_TIME,
  GET_AVAILABLE_LOOP_REC_TIME,
  SET_WIND_NOISE_REDUCTION,
  GET_WIND_NOISE_REDUCTION,
  GET_SUPPORTED_WIND_NOISE_REDUCTION,
  GET_AVAILABLE_WIND_NOISE_REDUCTION,
  SET_AUDIO_RECORDING,
  GET_AUDIO_RECORDING,
  GET_SUPPORTED_AUDIO_RECORDING,
  GET_AVAILABLE_AUDIO_RECORDING,
  SET_FLIP_SETTING,
  GET_FLIP_SETTING,
  GET_SUPPORTED_FLIP_SETTING,
  GET_AVAILABLE_FLIP_SETTING,
  SET_TV_COLOR_SYSTEM,
  GET_TV_COLOR_SYSTEM,
  GET_SUPPORTED_TV_COLOR_SYSTEM,
  GET_AVAILABLE_TV_COLOR_SYSTEM,
  START_REC_MODE,
  STOP_REC_MODE,
  SET_CAMERA_FUNCTION,
  GET_CAMERA_FUNCTION,
  GET_SUPPORTED_CAMERA_FUNCTION,
  GET_AVAILABLE_CAMERA_FUNCTION,
  GET_SCHEME_LIST,
  GET_SOURCE_LIST,
  GET_CONTENT_COUNT,
  GET_CONTENT_LIST,
  SET_STREAMING_CONTENT,
  START_STREAMING,
  PAUSE_STREAMING,
  SEEK_STREAMING_POSITION,
  STOP_STREAMING,
  REQUEST_TO_NOTIFY_STREAMING_STATUS,
  DELETE_CONTENT,
  SET_INFRARED_REMOTE_CONTROL,
  GET_INFRARED_REMOTE_CONTROL,
  GET_SUPPORTED_INFRARED_REMOTE_CONTROL,
  GET_AVAILABLE_INFRARED_REMOTE_CONTROL,
  SET_AUTO_POWER_OFF,
  GET_AUTO_POWER_OFF,
  GET_SUPPORTED_AUTO_POWER_OFF,
  GET_AVAILABLE_AUTO_POWER_OFF,
  SET_BEEP_MODE,
  GET_BEEP_MODE,
  GET_SUPPORTED_BEEP_MODE,
  GET_AVAILABLE_BEEP_MODE,
  SET_CURRENT_TIME,
  GET_STORAGE_INFORMATION,
  GET_EVENT,
  GET_AVAILABLE_API_LIST,
  GET_APPLICATION_INFO,
  GET_VERSIONS,
  GET_METHOD_TYPES,
  START_BULB_SHOOTING,
  STOP_BULB_SHOOTING,
  SET_SILENT_SHOOTING_SETTING,
  GET_SILENT_SHOOTING_SETTING,
  GET_SUPPORTED_SILENT_SHOOTING_SETTING,
  GET_AVAILABLE_SILENT_SHOOTING_SETTING,
  UNKOWN
}

extension SonyWebApiMethodExtension on SonyWebApiMethod {
  String get wifiValue {
    switch (this) {
      case SonyWebApiMethod.GET_SUPPORTED:
        return "getSupported";
      case SonyWebApiMethod.GET_AVAILABLE:
        return "getAvailable";
      case SonyWebApiMethod.SET_SHOOT_MODE:
        return "setShootMode";
      case SonyWebApiMethod.GET_SHOOT_MODE:
        return "getShootMode";
      case SonyWebApiMethod.GET_SUPPORTED_SHOOT_MODE:
        return "getSupportedShootMode";
      case SonyWebApiMethod.GET_AVAILABLE_SHOOT_MODE:
        return "getAvailableShootMode";
      case SonyWebApiMethod.ACT_TAKE_PICTURE:
        return "actTakePicture";
      case SonyWebApiMethod.AWAIT_TAKE_PICTURE:
        return "awaitTakePicture";
      case SonyWebApiMethod.START_CONT_SHOOTING:
        return "startContShooting";
      case SonyWebApiMethod.STOP_CONT_SHOOTING:
        return "stopContShooting";
      case SonyWebApiMethod.START_MOVIE_REC:
        return "startMovieRec";
      case SonyWebApiMethod.STOP_MOVIE_REC:
        return "stopMovieRec";
      case SonyWebApiMethod.START_AUDIO_REC:
        return "startAudioRec";
      case SonyWebApiMethod.STOP_AUDIO_REC:
        return "stopAudioRec";
      case SonyWebApiMethod.START_INTERVAL_STILL_REC:
        return "startIntervalStillRec";
      case SonyWebApiMethod.STOP_INTERVAL_STILL_REC:
        return "stopIntervalStillRec";
      case SonyWebApiMethod.START_LOOP_REC:
        return "startLoopRec";
      case SonyWebApiMethod.STOP_LOOP_REC:
        return "stopLoopRec";
      case SonyWebApiMethod.START_LIVE_VIEW:
        return "startLiveview";
      case SonyWebApiMethod.STOP_LIVE_VIEW:
        return "stopLiveview";
      case SonyWebApiMethod.START_LIVE_VIEW_WITH_SIZE:
        return "startLiveviewWithSize";
      case SonyWebApiMethod.GET_LIVE_VIEW_SIZE:
        return "getLiveviewSize";
      case SonyWebApiMethod.GET_SUPPORTED_LIVE_VIEW_SIZE:
        return "getSupportedLiveviewSize";
      case SonyWebApiMethod.GET_AVAILABLE_LIVE_VIEW_SIZE:
        return "getAvailableLiveviewSize";
      case SonyWebApiMethod.SET_LIVE_VIEW_FRAME_INFO:
        return "setLiveviewFrameInfo";
      case SonyWebApiMethod.GET_LIVE_VIEW_FRAME_INFO:
        return "getLiveviewFrameInfo";
      case SonyWebApiMethod.ACT_ZOOM:
        return "actZoom";
      case SonyWebApiMethod.SET_ZOOM_SETTING:
        return "setZoomSetting";
      case SonyWebApiMethod.GET_ZOOM_SETTING:
        return "getZoomSetting";
      case SonyWebApiMethod.GET_SUPPORTED_ZOOM_SETTING:
        return "getSupportedZoomSetting";
      case SonyWebApiMethod.GET_AVAILABLE_ZOOM_SETTING:
        return "getAvailableZoomSetting";
      case SonyWebApiMethod.ACT_HALF_PRESS_SHUTTER:
        return "actHalfPressShutter";
      case SonyWebApiMethod.CANCEL_HALF_PRESS_SHUTTER:
        return "cancelHalfPressShutter";
      case SonyWebApiMethod.SET_TOUCH_AF_POSITION:
        return "setTouchAFPosition";
      case SonyWebApiMethod.GET_TOUCH_AF_POSITION:
        return "getTouchAFPosition";
      case SonyWebApiMethod.CANCEL_TOUCH_AF_POSITION:
        return "cancelTouchAFPosition";
      case SonyWebApiMethod.ACT_TRACKING_FOCUS:
        return "actTrackingFocus";
      case SonyWebApiMethod.CANCEL_TRACKING_FOCUS:
        return "cancelTrackingFocus";
      case SonyWebApiMethod.SET_TRACKING_FOCUS:
        return "setTrackingFocus";
      case SonyWebApiMethod.GET_TRACKING_FOCUS:
        return "getTrackingFocus";
      case SonyWebApiMethod.GET_SUPPORTED_TRACKING_FOCUS:
        return "getSupportedTrackingFocus";
      case SonyWebApiMethod.GET_AVAILABLE_TRACKING_FOCUS:
        return "getAvailableTrackingFocus";
      case SonyWebApiMethod.SET_CONT_SHOOTING_MODE:
        return "setContShootingMode";
      case SonyWebApiMethod.GET_CONT_SHOOTING_MODE:
        return "getContShootingMode";
      case SonyWebApiMethod.GET_SUPPORTED_CONT_SHOOTING_MODE:
        return "getSupportedContShootingMode";
      case SonyWebApiMethod.GET_AVAILABLE_CONT_SHOOTING_MODE:
        return "getAvailableContShootingMode";
      case SonyWebApiMethod.SET_CONT_SHOOTING_SPEED:
        return "setContShootingSpeed";
      case SonyWebApiMethod.GET_CONT_SHOOTING_SPEED:
        return "getContShootingSpeed";
      case SonyWebApiMethod.GET_SUPPORTED_CONT_SHOOTING_SPEED:
        return "getSupportedContShootingSpeed";
      case SonyWebApiMethod.GET_AVAILABLE_CONT_SHOOTING_SPEED:
        return "getAvailableContShootingSpeed";
      case SonyWebApiMethod.SET_SELF_TIMER:
        return "setSelfTimer";
      case SonyWebApiMethod.GET_SELF_TIMER:
        return "getSelfTimer";
      case SonyWebApiMethod.GET_SUPPORTED_SELF_TIMER:
        return "getSupportedSelfTimer";
      case SonyWebApiMethod.GET_AVAILABLE_SELF_TIMER:
        return "getAvailableSelfTimer";
      case SonyWebApiMethod.SET_EXPOSURE_MODE:
        return "setExposureMode";
      case SonyWebApiMethod.GET_EXPOSURE_MODE:
        return "getExposureMode";
      case SonyWebApiMethod.GET_SUPPORTED_EXPOSURE_MODE:
        return "getSupportedExposureMode";
      case SonyWebApiMethod.GET_AVAILABLE_EXPOSURE_MODE:
        return "getAvailableExposureMode";
      case SonyWebApiMethod.SET_FOCUS_MODE:
        return "setFocusMode";
      case SonyWebApiMethod.GET_FOCUS_MODE:
        return "getFocusMode";
      case SonyWebApiMethod.GET_SUPPORTED_FOCUS_MODE:
        return "getSupportedFocusMode";
      case SonyWebApiMethod.GET_AVAILABLE_FOCUS_MODE:
        return "getAvailableFocusMode";
      case SonyWebApiMethod.SET_EXPOSURE_COMPENSATION:
        return "setExposureCompensation";
      case SonyWebApiMethod.GET_EXPOSURE_COMPENSATION:
        return "getExposureCompensation";
      case SonyWebApiMethod.GET_SUPPORTED_EXPOSURE_COMPENSATION:
        return "getSupportedExposureCompensation";
      case SonyWebApiMethod.GET_AVAILABLE_EXPOSURE_COMPENSATION:
        return "getAvailableExposureCompensation";
      case SonyWebApiMethod.SET_F_NUMBER:
        return "setFNumber";
      case SonyWebApiMethod.GET_F_NUMBER:
        return "getFNumber";
      case SonyWebApiMethod.GET_SUPPORTED_F_NUMBER:
        return "getSupportedFNumber";
      case SonyWebApiMethod.GET_AVAILABLE_F_NUMBER:
        return "getAvailableFNumber";
      case SonyWebApiMethod.SET_SHUTTER_SPEED:
        return "setShutterSpeed";
      case SonyWebApiMethod.GET_SHUTTER_SPEED:
        return "getShutterSpeed";
      case SonyWebApiMethod.GET_SUPPORTED_SHUTTER_SPEED:
        return "getSupportedShutterSpeed";
      case SonyWebApiMethod.GET_AVAILABLE_SHUTTER_SPEED:
        return "getAvailableShutterSpeed";
      case SonyWebApiMethod.SET_ISO_SPEED_RATE:
        return "setIsoSpeedRate";
      case SonyWebApiMethod.GET_ISO_SPEED_RATE:
        return "getIsoSpeedRate";
      case SonyWebApiMethod.GET_SUPPORTED_ISO_SPEED_RATE:
        return "getSupportedIsoSpeedRate";
      case SonyWebApiMethod.GET_AVAILABLE_ISO_SPEED_RATE:
        return "getAvailableIsoSpeedRate";
      case SonyWebApiMethod.SET_WHITE_BALANCE:
        return "setWhiteBalance";
      case SonyWebApiMethod.GET_WHITE_BALANCE:
        return "getWhiteBalance";
      case SonyWebApiMethod.GET_SUPPORTED_WHITE_BALANCE:
        return "getSupportedWhiteBalance";
      case SonyWebApiMethod.GET_AVAILABLE_WHITE_BALANCE:
        return "getAvailableWhiteBalance";
      case SonyWebApiMethod.ACT_WHITE_BALANCE_ONE_PUSH_CUSTOM:
        return "actWhiteBalanceOnePushCustom";
      case SonyWebApiMethod.SET_PROGRAM_SHIFT:
        return "setProgramShift";
      case SonyWebApiMethod.GET_SUPPORTED_PROGRAM_SHIFT:
        return "getSupportedProgramShift";
      case SonyWebApiMethod.SET_FLASH_MODE:
        return "setFlashMode";
      case SonyWebApiMethod.GET_FLASH_MODE:
        return "getFlashMode";
      case SonyWebApiMethod.GET_SUPPORTED_FLASH_MODE:
        return "getSupportedFlashMode";
      case SonyWebApiMethod.GET_AVAILABLE_FLASH_MODE:
        return "getAvailableFlashMode";
      case SonyWebApiMethod.SET_STILL_SIZE:
        return "setStillSize";
      case SonyWebApiMethod.GET_STILL_SIZE:
        return "getStillSize";
      case SonyWebApiMethod.GET_SUPPORTED_STILL_SIZE:
        return "getSupportedStillSize";
      case SonyWebApiMethod.GET_AVAILABLE_STILL_SIZE:
        return "getAvailableStillSize";
      case SonyWebApiMethod.SET_STILL_QUALITY:
        return "setStillQuality";
      case SonyWebApiMethod.GET_STILL_QUALITY:
        return "getStillQuality";
      case SonyWebApiMethod.GET_SUPPORTED_STILL_QUALITY:
        return "getSupportedStillQuality";
      case SonyWebApiMethod.GET_AVAILABLE_STILL_QUALITY:
        return "getAvailableStillQuality";
      case SonyWebApiMethod.SET_POST_VIEW_IMAGE_SIZE:
        return "setPostviewImageSize";
      case SonyWebApiMethod.GET_POST_VIEW_IMAGE_SIZE:
        return "getPostviewImageSize";
      case SonyWebApiMethod.GET_SUPPORTED_POST_VIEW_IMAGE_SIZE:
        return "getSupportedPostviewImageSize";
      case SonyWebApiMethod.GET_AVAILABLE_POST_VIEW_IMAGE_SIZE:
        return "getAvailablePostviewImageSize";
      case SonyWebApiMethod.SET_MOVIE_FILE_FORMAT:
        return "setMovieFileFormat";
      case SonyWebApiMethod.GET_MOVIE_FILE_FORMAT:
        return "getMovieFileFormat";
      case SonyWebApiMethod.GET_SUPPORTED_MOVIE_FILE_FORMAT:
        return "getSupportedMovieFileFormat";
      case SonyWebApiMethod.GET_AVAILABLE_MOVIE_FILE_FORMAT:
        return "getAvailableMovieFileFormat";
      case SonyWebApiMethod.SET_MOVIE_QUALITY:
        return "setMovieQuality";
      case SonyWebApiMethod.GET_MOVIE_QUALITY:
        return "getMovieQuality";
      case SonyWebApiMethod.GET_SUPPORTED_MOVIE_QUALITY:
        return "getSupportedMovieQuality";
      case SonyWebApiMethod.GET_AVAILABLE_MOVIE_QUALITY:
        return "getAvailableMovieQuality";
      case SonyWebApiMethod.SET_STEADY_MODE:
        return "setSteadyMode";
      case SonyWebApiMethod.GET_STEADY_MODE:
        return "getSteadyMode";
      case SonyWebApiMethod.GET_SUPPORTED_STEADY_MODE:
        return "getSupportedSteadyMode";
      case SonyWebApiMethod.GET_AVAILABLE_STEADY_MODE:
        return "getAvailableSteadyMode";
      case SonyWebApiMethod.SET_VIEW_ANGLE:
        return "setViewAngle";
      case SonyWebApiMethod.GET_VIEW_ANGLE:
        return "getViewAngle";
      case SonyWebApiMethod.GET_SUPPORTED_VIEW_ANGLE:
        return "getSupportedViewAngle";
      case SonyWebApiMethod.GET_AVAILABLE_VIEW_ANGLE:
        return "getAvailableViewAngle";
      case SonyWebApiMethod.SET_SCENE_SELECTION:
        return "setSceneSelection";
      case SonyWebApiMethod.GET_SCENE_SELECTION:
        return "getSceneSelection";
      case SonyWebApiMethod.GET_SUPPORTED_SCENE_SELECTION:
        return "getSupportedSceneSelection";
      case SonyWebApiMethod.GET_AVAILABLE_SCENE_SELECTION:
        return "getAvailableSceneSelection";
      case SonyWebApiMethod.SET_COLOR_SETTING:
        return "setColorSetting";
      case SonyWebApiMethod.GET_COLOR_SETTING:
        return "getColorSetting";
      case SonyWebApiMethod.GET_SUPPORTED_COLOR_SETTING:
        return "getSupportedColorSetting";
      case SonyWebApiMethod.GET_AVAILABLE_COLOR_SETTING:
        return "getAvailableColorSetting";
      case SonyWebApiMethod.SET_INTERVAL_TIME:
        return "setIntervalTime";
      case SonyWebApiMethod.GET_INTERVAL_TIME:
        return "getIntervalTime";
      case SonyWebApiMethod.GET_SUPPORTED_INTERVAL_TIME:
        return "getSupportedIntervalTime";
      case SonyWebApiMethod.GET_AVAILABLE_INTERVAL_TIME:
        return "getAvailableIntervalTime";
      case SonyWebApiMethod.SET_LOOP_REC_TIME:
        return "setLoopRecTime";
      case SonyWebApiMethod.GET_LOOP_REC_TIME:
        return "getLoopRecTime";
      case SonyWebApiMethod.GET_SUPPORTED_LOOP_REC_TIME:
        return "getSupportedLoopRecTime";
      case SonyWebApiMethod.GET_AVAILABLE_LOOP_REC_TIME:
        return "getAvailableLoopRecTime";
      case SonyWebApiMethod.SET_WIND_NOISE_REDUCTION:
        return "setWindNoiseReduction";
      case SonyWebApiMethod.GET_WIND_NOISE_REDUCTION:
        return "getWindNoiseReduction";
      case SonyWebApiMethod.GET_SUPPORTED_WIND_NOISE_REDUCTION:
        return "getSupportedWindNoiseReduction";
      case SonyWebApiMethod.GET_AVAILABLE_WIND_NOISE_REDUCTION:
        return "getAvailableWindNoiseReduction";
      case SonyWebApiMethod.SET_AUDIO_RECORDING:
        return "setAudioRecording";
      case SonyWebApiMethod.GET_AUDIO_RECORDING:
        return "getAudioRecording";
      case SonyWebApiMethod.GET_SUPPORTED_AUDIO_RECORDING:
        return "getSupportedAudioRecording";
      case SonyWebApiMethod.GET_AVAILABLE_AUDIO_RECORDING:
        return "getAvailableAudioRecording";
      case SonyWebApiMethod.SET_FLIP_SETTING:
        return "setFlipSetting";
      case SonyWebApiMethod.GET_FLIP_SETTING:
        return "getFlipSetting";
      case SonyWebApiMethod.GET_SUPPORTED_FLIP_SETTING:
        return "getSupportedFlipSetting";
      case SonyWebApiMethod.GET_AVAILABLE_FLIP_SETTING:
        return "getAvailableFlipSetting";
      case SonyWebApiMethod.SET_TV_COLOR_SYSTEM:
        return "setTvColorSystem";
      case SonyWebApiMethod.GET_TV_COLOR_SYSTEM:
        return "getTvColorSystem";
      case SonyWebApiMethod.GET_SUPPORTED_TV_COLOR_SYSTEM:
        return "getSupportedTvColorSystem";
      case SonyWebApiMethod.GET_AVAILABLE_TV_COLOR_SYSTEM:
        return "getAvailableTvColorSystem";
      case SonyWebApiMethod.START_REC_MODE:
        return "startRecMode";
      case SonyWebApiMethod.STOP_REC_MODE:
        return "stopRecMode";
      case SonyWebApiMethod.SET_CAMERA_FUNCTION:
        return "setCameraFunction";
      case SonyWebApiMethod.GET_CAMERA_FUNCTION:
        return "getCameraFunction";
      case SonyWebApiMethod.GET_SUPPORTED_CAMERA_FUNCTION:
        return "getSupportedCameraFunction";
      case SonyWebApiMethod.GET_AVAILABLE_CAMERA_FUNCTION:
        return "getAvailableCameraFunction";
      case SonyWebApiMethod.GET_SCHEME_LIST:
        return "getSchemeList";
      case SonyWebApiMethod.GET_SOURCE_LIST:
        return "getSourceList";
      case SonyWebApiMethod.GET_CONTENT_COUNT:
        return "getContentCount";
      case SonyWebApiMethod.GET_CONTENT_LIST:
        return "getContentList";
      case SonyWebApiMethod.SET_STREAMING_CONTENT:
        return "setStreamingContent";
      case SonyWebApiMethod.START_STREAMING:
        return "startStreaming";
      case SonyWebApiMethod.PAUSE_STREAMING:
        return "pauseStreaming";
      case SonyWebApiMethod.SEEK_STREAMING_POSITION:
        return "seekStreamingPosition";
      case SonyWebApiMethod.STOP_STREAMING:
        return "stopStreaming";
      case SonyWebApiMethod.REQUEST_TO_NOTIFY_STREAMING_STATUS:
        return "requestToNotifyStreamingStatus";
      case SonyWebApiMethod.DELETE_CONTENT:
        return "deleteContent";
      case SonyWebApiMethod.SET_INFRARED_REMOTE_CONTROL:
        return "setInfraredRemoteControl";
      case SonyWebApiMethod.GET_INFRARED_REMOTE_CONTROL:
        return "getInfraredRemoteControl";
      case SonyWebApiMethod.GET_SUPPORTED_INFRARED_REMOTE_CONTROL:
        return "getSupportedInfraredRemoteControl";
      case SonyWebApiMethod.GET_AVAILABLE_INFRARED_REMOTE_CONTROL:
        return "getAvailableInfraredRemoteControl";
      case SonyWebApiMethod.SET_AUTO_POWER_OFF:
        return "setAutoPowerOff";
      case SonyWebApiMethod.GET_AUTO_POWER_OFF:
        return "getAutoPowerOff";
      case SonyWebApiMethod.GET_SUPPORTED_AUTO_POWER_OFF:
        return "getSupportedAutoPowerOff";
      case SonyWebApiMethod.GET_AVAILABLE_AUTO_POWER_OFF:
        return "getAvailableAutoPowerOff";
      case SonyWebApiMethod.SET_BEEP_MODE:
        return "setBeepMode";
      case SonyWebApiMethod.GET_BEEP_MODE:
        return "getBeepMode";
      case SonyWebApiMethod.GET_SUPPORTED_BEEP_MODE:
        return "getSupportedBeepMode";
      case SonyWebApiMethod.GET_AVAILABLE_BEEP_MODE:
        return "getAvailableBeepMode";
      case SonyWebApiMethod.SET_CURRENT_TIME:
        return "setCurrentTime";
      case SonyWebApiMethod.GET_STORAGE_INFORMATION:
        return "getStorageInformation";
      case SonyWebApiMethod.GET_EVENT:
        return "getEvent";
      case SonyWebApiMethod.GET_AVAILABLE_API_LIST:
        return "getAvailableApiList";
      case SonyWebApiMethod.GET_APPLICATION_INFO:
        return "getApplicationInfo";
      case SonyWebApiMethod.GET_VERSIONS:
        return "getVersions";
      case SonyWebApiMethod.GET_METHOD_TYPES:
        return "getMethodTypes";
      case SonyWebApiMethod.START_BULB_SHOOTING:
        return "startBulbShooting";
      case SonyWebApiMethod.STOP_BULB_SHOOTING:
        return "stopBulbShooting";
      case SonyWebApiMethod.SET_SILENT_SHOOTING_SETTING:
        return "setSilentShootingSetting";
      case SonyWebApiMethod.GET_SILENT_SHOOTING_SETTING:
        return "getSilentShootingSetting";
      case SonyWebApiMethod.GET_SUPPORTED_SILENT_SHOOTING_SETTING:
        return "getSupportedSilentShootingSetting";
      case SonyWebApiMethod.GET_AVAILABLE_SILENT_SHOOTING_SETTING:
        return "getAvailableSilentShootingSetting";
      case SonyWebApiMethod.UNKOWN:
      default:
        return "";
    }
  }

  static SonyWebApiMethod fromWifiValue() {
    switch (value) {
      case "getSupported":
        return SonyWebApiMethod.GET_SUPPORTED;
      case "getAvailable":
        return SonyWebApiMethod.GET_AVAILABLE;
      case "setShootMode":
        return SonyWebApiMethod.SET_SHOOT_MODE;
      case "getShootMode":
        return SonyWebApiMethod.GET_SHOOT_MODE;
      case "getSupportedShootMode":
        return SonyWebApiMethod.GET_SUPPORTED_SHOOT_MODE;
      case "getAvailableShootMode":
        return SonyWebApiMethod.GET_AVAILABLE_SHOOT_MODE;
      case "actTakePicture":
        return SonyWebApiMethod.ACT_TAKE_PICTURE;
      case "awaitTakePicture":
        return SonyWebApiMethod.AWAIT_TAKE_PICTURE;
      case "startContShooting":
        return SonyWebApiMethod.START_CONT_SHOOTING;
      case "stopContShooting":
        return SonyWebApiMethod.STOP_CONT_SHOOTING;
      case "startMovieRec":
        return SonyWebApiMethod.START_MOVIE_REC;
      case "stopMovieRec":
        return SonyWebApiMethod.STOP_MOVIE_REC;
      case "startAudioRec":
        return SonyWebApiMethod.START_AUDIO_REC;
      case "stopAudioRec":
        return SonyWebApiMethod.STOP_AUDIO_REC;
      case "startIntervalStillRec":
        return SonyWebApiMethod.START_INTERVAL_STILL_REC;
      case "stopIntervalStillRec":
        return SonyWebApiMethod.STOP_INTERVAL_STILL_REC;
      case "startLoopRec":
        return SonyWebApiMethod.START_LOOP_REC;
      case "stopLoopRec":
        return SonyWebApiMethod.STOP_LOOP_REC;
      case "startLiveview":
        return SonyWebApiMethod.START_LIVE_VIEW;
      case "stopLiveview":
        return SonyWebApiMethod.STOP_LIVE_VIEW;
      case "startLiveviewWithSize":
        return SonyWebApiMethod.START_LIVE_VIEW_WITH_SIZE;
      case "getLiveviewSize":
        return SonyWebApiMethod.GET_LIVE_VIEW_SIZE;
      case "getSupportedLiveviewSize":
        return SonyWebApiMethod.GET_SUPPORTED_LIVE_VIEW_SIZE;
      case "getAvailableLiveviewSize":
        return SonyWebApiMethod.GET_AVAILABLE_LIVE_VIEW_SIZE;
      case "setLiveviewFrameInfo":
        return SonyWebApiMethod.SET_LIVE_VIEW_FRAME_INFO;
      case "getLiveviewFrameInfo":
        return SonyWebApiMethod.GET_LIVE_VIEW_FRAME_INFO;
      case "actZoom":
        return SonyWebApiMethod.ACT_ZOOM;
      case "setZoomSetting":
        return SonyWebApiMethod.SET_ZOOM_SETTING;
      case "getZoomSetting":
        return SonyWebApiMethod.GET_ZOOM_SETTING;
      case "getSupportedZoomSetting":
        return SonyWebApiMethod.GET_SUPPORTED_ZOOM_SETTING;
      case "getAvailableZoomSetting":
        return SonyWebApiMethod.GET_AVAILABLE_ZOOM_SETTING;
      case "actHalfPressShutter":
        return SonyWebApiMethod.ACT_HALF_PRESS_SHUTTER;
      case "cancelHalfPressShutter":
        return SonyWebApiMethod.CANCEL_HALF_PRESS_SHUTTER;
      case "setTouchAFPosition":
        return SonyWebApiMethod.SET_TOUCH_AF_POSITION;
      case "getTouchAFPosition":
        return SonyWebApiMethod.GET_TOUCH_AF_POSITION;
      case "cancelTouchAFPosition":
        return SonyWebApiMethod.CANCEL_TOUCH_AF_POSITION;
      case "actTrackingFocus":
        return SonyWebApiMethod.ACT_TRACKING_FOCUS;
      case "cancelTrackingFocus":
        return SonyWebApiMethod.CANCEL_TRACKING_FOCUS;
      case "setTrackingFocus":
        return SonyWebApiMethod.SET_TRACKING_FOCUS;
      case "getTrackingFocus":
        return SonyWebApiMethod.GET_TRACKING_FOCUS;
      case "getSupportedTrackingFocus":
        return SonyWebApiMethod.GET_SUPPORTED_TRACKING_FOCUS;
      case "getAvailableTrackingFocus":
        return SonyWebApiMethod.GET_AVAILABLE_TRACKING_FOCUS;
      case "setContShootingMode":
        return SonyWebApiMethod.SET_CONT_SHOOTING_MODE;
      case "getContShootingMode":
        return SonyWebApiMethod.GET_CONT_SHOOTING_MODE;
      case "getSupportedContShootingMode":
        return SonyWebApiMethod.GET_SUPPORTED_CONT_SHOOTING_MODE;
      case "getAvailableContShootingMode":
        return SonyWebApiMethod.GET_AVAILABLE_CONT_SHOOTING_MODE;
      case "setContShootingSpeed":
        return SonyWebApiMethod.SET_CONT_SHOOTING_SPEED;
      case "getContShootingSpeed":
        return SonyWebApiMethod.GET_CONT_SHOOTING_SPEED;
      case "getSupportedContShootingSpeed":
        return SonyWebApiMethod.GET_SUPPORTED_CONT_SHOOTING_SPEED;
      case "getAvailableContShootingSpeed":
        return SonyWebApiMethod.GET_AVAILABLE_CONT_SHOOTING_SPEED;
      case "setSelfTimer":
        return SonyWebApiMethod.SET_SELF_TIMER;
      case "getSelfTimer":
        return SonyWebApiMethod.GET_SELF_TIMER;
      case "getSupportedSelfTimer":
        return SonyWebApiMethod.GET_SUPPORTED_SELF_TIMER;
      case "getAvailableSelfTimer":
        return SonyWebApiMethod.GET_AVAILABLE_SELF_TIMER;
      case "setExposureMode":
        return SonyWebApiMethod.SET_EXPOSURE_MODE;
      case "getExposureMode":
        return SonyWebApiMethod.GET_EXPOSURE_MODE;
      case "getSupportedExposureMode":
        return SonyWebApiMethod.GET_SUPPORTED_EXPOSURE_MODE;
      case "getAvailableExposureMode":
        return SonyWebApiMethod.GET_AVAILABLE_EXPOSURE_MODE;
      case "setFocusMode":
        return SonyWebApiMethod.SET_FOCUS_MODE;
      case "getFocusMode":
        return SonyWebApiMethod.GET_FOCUS_MODE;
      case "getSupportedFocusMode":
        return SonyWebApiMethod.GET_SUPPORTED_FOCUS_MODE;
      case "getAvailableFocusMode":
        return SonyWebApiMethod.GET_AVAILABLE_FOCUS_MODE;
      case "setExposureCompensation":
        return SonyWebApiMethod.SET_EXPOSURE_COMPENSATION;
      case "getExposureCompensation":
        return SonyWebApiMethod.GET_EXPOSURE_COMPENSATION;
      case "getSupportedExposureCompensation":
        return SonyWebApiMethod.GET_SUPPORTED_EXPOSURE_COMPENSATION;
      case "getAvailableExposureCompensation":
        return SonyWebApiMethod.GET_AVAILABLE_EXPOSURE_COMPENSATION;
      case "setFNumber":
        return SonyWebApiMethod.SET_F_NUMBER;
      case "getFNumber":
        return SonyWebApiMethod.GET_F_NUMBER;
      case "getSupportedFNumber":
        return SonyWebApiMethod.GET_SUPPORTED_F_NUMBER;
      case "getAvailableFNumber":
        return SonyWebApiMethod.GET_AVAILABLE_F_NUMBER;
      case "setShutterSpeed":
        return SonyWebApiMethod.SET_SHUTTER_SPEED;
      case "getShutterSpeed":
        return SonyWebApiMethod.GET_SHUTTER_SPEED;
      case "getSupportedShutterSpeed":
        return SonyWebApiMethod.GET_SUPPORTED_SHUTTER_SPEED;
      case "getAvailableShutterSpeed":
        return SonyWebApiMethod.GET_AVAILABLE_SHUTTER_SPEED;
      case "setIsoSpeedRate":
        return SonyWebApiMethod.SET_ISO_SPEED_RATE;
      case "getIsoSpeedRate":
        return SonyWebApiMethod.GET_ISO_SPEED_RATE;
      case "getSupportedIsoSpeedRate":
        return SonyWebApiMethod.GET_SUPPORTED_ISO_SPEED_RATE;
      case "getAvailableIsoSpeedRate":
        return SonyWebApiMethod.GET_AVAILABLE_ISO_SPEED_RATE;
      case "setWhiteBalance":
        return SonyWebApiMethod.SET_WHITE_BALANCE;
      case "getWhiteBalance":
        return SonyWebApiMethod.GET_WHITE_BALANCE;
      case "getSupportedWhiteBalance":
        return SonyWebApiMethod.GET_SUPPORTED_WHITE_BALANCE;
      case "getAvailableWhiteBalance":
        return SonyWebApiMethod.GET_AVAILABLE_WHITE_BALANCE;
      case "actWhiteBalanceOnePushCustom":
        return SonyWebApiMethod.ACT_WHITE_BALANCE_ONE_PUSH_CUSTOM;
      case "setProgramShift":
        return SonyWebApiMethod.SET_PROGRAM_SHIFT;
      case "getSupportedProgramShift":
        return SonyWebApiMethod.GET_SUPPORTED_PROGRAM_SHIFT;
      case "setFlashMode":
        return SonyWebApiMethod.SET_FLASH_MODE;
      case "getFlashMode":
        return SonyWebApiMethod.GET_FLASH_MODE;
      case "getSupportedFlashMode":
        return SonyWebApiMethod.GET_SUPPORTED_FLASH_MODE;
      case "getAvailableFlashMode":
        return SonyWebApiMethod.GET_AVAILABLE_FLASH_MODE;
      case "setStillSize":
        return SonyWebApiMethod.SET_STILL_SIZE;
      case "getStillSize":
        return SonyWebApiMethod.GET_STILL_SIZE;
      case "getSupportedStillSize":
        return SonyWebApiMethod.GET_SUPPORTED_STILL_SIZE;
      case "getAvailableStillSize":
        return SonyWebApiMethod.GET_AVAILABLE_STILL_SIZE;
      case "setStillQuality":
        return SonyWebApiMethod.SET_STILL_QUALITY;
      case "getStillQuality":
        return SonyWebApiMethod.GET_STILL_QUALITY;
      case "getSupportedStillQuality":
        return SonyWebApiMethod.GET_SUPPORTED_STILL_QUALITY;
      case "getAvailableStillQuality":
        return SonyWebApiMethod.GET_AVAILABLE_STILL_QUALITY;
      case "setPostviewImageSize":
        return SonyWebApiMethod.SET_POST_VIEW_IMAGE_SIZE;
      case "getPostviewImageSize":
        return SonyWebApiMethod.GET_POST_VIEW_IMAGE_SIZE;
      case "getSupportedPostviewImageSize":
        return SonyWebApiMethod.GET_SUPPORTED_POST_VIEW_IMAGE_SIZE;
      case "getAvailablePostviewImageSize":
        return SonyWebApiMethod.GET_AVAILABLE_POST_VIEW_IMAGE_SIZE;
      case "setMovieFileFormat":
        return SonyWebApiMethod.SET_MOVIE_FILE_FORMAT;
      case "getMovieFileFormat":
        return SonyWebApiMethod.GET_MOVIE_FILE_FORMAT;
      case "getSupportedMovieFileFormat":
        return SonyWebApiMethod.GET_SUPPORTED_MOVIE_FILE_FORMAT;
      case "getAvailableMovieFileFormat":
        return SonyWebApiMethod.GET_AVAILABLE_MOVIE_FILE_FORMAT;
      case "setMovieQuality":
        return SonyWebApiMethod.SET_MOVIE_QUALITY;
      case "getMovieQuality":
        return SonyWebApiMethod.GET_MOVIE_QUALITY;
      case "getSupportedMovieQuality":
        return SonyWebApiMethod.GET_SUPPORTED_MOVIE_QUALITY;
      case "getAvailableMovieQuality":
        return SonyWebApiMethod.GET_AVAILABLE_MOVIE_QUALITY;
      case "setSteadyMode":
        return SonyWebApiMethod.SET_STEADY_MODE;
      case "getSteadyMode":
        return SonyWebApiMethod.GET_STEADY_MODE;
      case "getSupportedSteadyMode":
        return SonyWebApiMethod.GET_SUPPORTED_STEADY_MODE;
      case "getAvailableSteadyMode":
        return SonyWebApiMethod.GET_AVAILABLE_STEADY_MODE;
      case "setViewAngle":
        return SonyWebApiMethod.SET_VIEW_ANGLE;
      case "getViewAngle":
        return SonyWebApiMethod.GET_VIEW_ANGLE;
      case "getSupportedViewAngle":
        return SonyWebApiMethod.GET_SUPPORTED_VIEW_ANGLE;
      case "getAvailableViewAngle":
        return SonyWebApiMethod.GET_AVAILABLE_VIEW_ANGLE;
      case "setSceneSelection":
        return SonyWebApiMethod.SET_SCENE_SELECTION;
      case "getSceneSelection":
        return SonyWebApiMethod.GET_SCENE_SELECTION;
      case "getSupportedSceneSelection":
        return SonyWebApiMethod.GET_SUPPORTED_SCENE_SELECTION;
      case "getAvailableSceneSelection":
        return SonyWebApiMethod.GET_AVAILABLE_SCENE_SELECTION;
      case "setColorSetting":
        return SonyWebApiMethod.SET_COLOR_SETTING;
      case "getColorSetting":
        return SonyWebApiMethod.GET_COLOR_SETTING;
      case "getSupportedColorSetting":
        return SonyWebApiMethod.GET_SUPPORTED_COLOR_SETTING;
      case "getAvailableColorSetting":
        return SonyWebApiMethod.GET_AVAILABLE_COLOR_SETTING;
      case "setIntervalTime":
        return SonyWebApiMethod.SET_INTERVAL_TIME;
      case "getIntervalTime":
        return SonyWebApiMethod.GET_INTERVAL_TIME;
      case "getSupportedIntervalTime":
        return SonyWebApiMethod.GET_SUPPORTED_INTERVAL_TIME;
      case "getAvailableIntervalTime":
        return SonyWebApiMethod.GET_AVAILABLE_INTERVAL_TIME;
      case "setLoopRecTime":
        return SonyWebApiMethod.SET_LOOP_REC_TIME;
      case "getLoopRecTime":
        return SonyWebApiMethod.GET_LOOP_REC_TIME;
      case "getSupportedLoopRecTime":
        return SonyWebApiMethod.GET_SUPPORTED_LOOP_REC_TIME;
      case "getAvailableLoopRecTime":
        return SonyWebApiMethod.GET_AVAILABLE_LOOP_REC_TIME;
      case "setWindNoiseReduction":
        return SonyWebApiMethod.SET_WIND_NOISE_REDUCTION;
      case "getWindNoiseReduction":
        return SonyWebApiMethod.GET_WIND_NOISE_REDUCTION;
      case "getSupportedWindNoiseReduction":
        return SonyWebApiMethod.GET_SUPPORTED_WIND_NOISE_REDUCTION;
      case "getAvailableWindNoiseReduction":
        return SonyWebApiMethod.GET_AVAILABLE_WIND_NOISE_REDUCTION;
      case "setAudioRecording":
        return SonyWebApiMethod.SET_AUDIO_RECORDING;
      case "getAudioRecording":
        return SonyWebApiMethod.GET_AUDIO_RECORDING;
      case "getSupportedAudioRecording":
        return SonyWebApiMethod.GET_SUPPORTED_AUDIO_RECORDING;
      case "getAvailableAudioRecording":
        return SonyWebApiMethod.GET_AVAILABLE_AUDIO_RECORDING;
      case "setFlipSetting":
        return SonyWebApiMethod.SET_FLIP_SETTING;
      case "getFlipSetting":
        return SonyWebApiMethod.GET_FLIP_SETTING;
      case "getSupportedFlipSetting":
        return SonyWebApiMethod.GET_SUPPORTED_FLIP_SETTING;
      case "getAvailableFlipSetting":
        return SonyWebApiMethod.GET_AVAILABLE_FLIP_SETTING;
      case "setTvColorSystem":
        return SonyWebApiMethod.SET_TV_COLOR_SYSTEM;
      case "getTvColorSystem":
        return SonyWebApiMethod.GET_TV_COLOR_SYSTEM;
      case "getSupportedTvColorSystem":
        return SonyWebApiMethod.GET_SUPPORTED_TV_COLOR_SYSTEM;
      case "getAvailableTvColorSystem":
        return SonyWebApiMethod.GET_AVAILABLE_TV_COLOR_SYSTEM;
      case "startRecMode":
        return SonyWebApiMethod.START_REC_MODE;
      case "stopRecMode":
        return SonyWebApiMethod.STOP_REC_MODE;
      case "setCameraFunction":
        return SonyWebApiMethod.SET_CAMERA_FUNCTION;
      case "getCameraFunction":
        return SonyWebApiMethod.GET_CAMERA_FUNCTION;
      case "getSupportedCameraFunction":
        return SonyWebApiMethod.GET_SUPPORTED_CAMERA_FUNCTION;
      case "getAvailableCameraFunction":
        return SonyWebApiMethod.GET_AVAILABLE_CAMERA_FUNCTION;
      case "getSchemeList":
        return SonyWebApiMethod.GET_SCHEME_LIST;
      case "getSourceList":
        return SonyWebApiMethod.GET_SOURCE_LIST;
      case "getContentCount":
        return SonyWebApiMethod.GET_CONTENT_COUNT;
      case "getContentList":
        return SonyWebApiMethod.GET_CONTENT_LIST;
      case "setStreamingContent":
        return SonyWebApiMethod.SET_STREAMING_CONTENT;
      case "startStreaming":
        return SonyWebApiMethod.START_STREAMING;
      case "pauseStreaming":
        return SonyWebApiMethod.PAUSE_STREAMING;
      case "seekStreamingPosition":
        return SonyWebApiMethod.SEEK_STREAMING_POSITION;
      case "stopStreaming":
        return SonyWebApiMethod.STOP_STREAMING;
      case "requestToNotifyStreamingStatus":
        return SonyWebApiMethod.REQUEST_TO_NOTIFY_STREAMING_STATUS;
      case "deleteContent":
        return SonyWebApiMethod.DELETE_CONTENT;
      case "setInfraredRemoteControl":
        return SonyWebApiMethod.SET_INFRARED_REMOTE_CONTROL;
      case "getInfraredRemoteControl":
        return SonyWebApiMethod.GET_INFRARED_REMOTE_CONTROL;
      case "getSupportedInfraredRemoteControl":
        return SonyWebApiMethod.GET_SUPPORTED_INFRARED_REMOTE_CONTROL;
      case "getAvailableInfraredRemoteControl":
        return SonyWebApiMethod.GET_AVAILABLE_INFRARED_REMOTE_CONTROL;
      case "setAutoPowerOff":
        return SonyWebApiMethod.SET_AUTO_POWER_OFF;
      case "getAutoPowerOff":
        return SonyWebApiMethod.GET_AUTO_POWER_OFF;
      case "getSupportedAutoPowerOff":
        return SonyWebApiMethod.GET_SUPPORTED_AUTO_POWER_OFF;
      case "getAvailableAutoPowerOff":
        return SonyWebApiMethod.GET_AVAILABLE_AUTO_POWER_OFF;
      case "setBeepMode":
        return SonyWebApiMethod.SET_BEEP_MODE;
      case "getBeepMode":
        return SonyWebApiMethod.GET_BEEP_MODE;
      case "getSupportedBeepMode":
        return SonyWebApiMethod.GET_SUPPORTED_BEEP_MODE;
      case "getAvailableBeepMode":
        return SonyWebApiMethod.GET_AVAILABLE_BEEP_MODE;
      case "setCurrentTime":
        return SonyWebApiMethod.SET_CURRENT_TIME;
      case "getStorageInformation":
        return SonyWebApiMethod.GET_STORAGE_INFORMATION;
      case "getEvent":
        return SonyWebApiMethod.GET_EVENT;
      case "getAvailableApiList":
        return SonyWebApiMethod.GET_AVAILABLE_API_LIST;
      case "getApplicationInfo":
        return SonyWebApiMethod.GET_APPLICATION_INFO;
      case "getVersions":
        return SonyWebApiMethod.GET_VERSIONS;
      case "getMethodTypes":
        return SonyWebApiMethod.GET_METHOD_TYPES;
      case "startBulbShooting":
        return SonyWebApiMethod.START_BULB_SHOOTING;
      case "stopBulbShooting":
        return SonyWebApiMethod.STOP_BULB_SHOOTING;
      case "setSilentShootingSetting":
        return SonyWebApiMethod.SET_SILENT_SHOOTING_SETTING;
      case "getSilentShootingSetting":
        return SonyWebApiMethod.GET_SILENT_SHOOTING_SETTING;
      case "getSupportedSilentShootingSetting":
        return SonyWebApiMethod.GET_SUPPORTED_SILENT_SHOOTING_SETTING;
      case "getAvailableSilentShootingSetting":
        return SonyWebApiMethod.GET_AVAILABLE_SILENT_SHOOTING_SETTING;
      default:
        return SonyWebApiMethod.UNKOWN;
    }
  }
}

class SonyWebApiMethodConverter_old
    implements JsonConverter<SonyWebApiMethod, String> {
  const SonyWebApiMethodConverter_old();

  @override
  SonyWebApiMethod fromJson(String json) =>
      SonyWebApiMethodExtension.fromWifiValue(json);

  @override
  String toJson(SonyWebApiMethod value) => value.wifiValue;
}
*/
