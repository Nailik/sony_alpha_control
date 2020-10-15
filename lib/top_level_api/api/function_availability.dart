import 'package:sonyalphacontrol/sonyalphacontrol.dart';

enum FunctionAvailability { Available, Supported, Unsupported }

extension FunctionExtension on Function {
  /*
  final ItemId itemId;
  final ApiMethodId apiMethodId;
  final SonyWebApiServiceTypeId serviceId;
 */
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

    return FunctionAvailability.Unsupported;
  }
}
