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

    if (this == device.api.getWebApiVersions) {
      return device.api.checkFunctionAvailability(
              ItemId.Versions, ApiMethodId.GET,
              service: SonyWebApiServiceTypeId.ACCESS_CONTROL) ==
          FunctionAvailability.Available;
    }

    return false;
  }

  FunctionAvailability availability({SonyCameraDevice device}) {
    if (device == null) {
      device = SonyApi.connectedCamera;
    }

    if (this == device.api.getWebApiVersions) {
      return device.api.checkFunctionAvailability(
          ItemId.Versions, ApiMethodId.GET,
          service: SonyWebApiServiceTypeId.ACCESS_CONTROL);
    }

    return FunctionAvailability.Unsupported;
  }
}
