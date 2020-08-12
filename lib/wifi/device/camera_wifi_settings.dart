import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';

class CameraWifiSettings extends CameraSettings {
  @override
  Future<bool> update() {
    //camera settings?
    Future<String> getSettings(WebApiVersion version, bool longPolling) async {
      await WifiCommand.createCommand(
          SonyWebApiMethod.GET, SettingsId.AvailableSettings,
          version:
          device.getWebApiService(SonyWebApiServiceType.CAMERA).maxVersion,
          params: [longPolling]).send(device);
    }
  }
}
