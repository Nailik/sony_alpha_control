import 'dart:convert';

import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/wifi/commands/wifi_command.dart';
import 'package:sonyalphacontrol/wifi/device/sony_camera_wifi_device.dart';
import 'package:sonyalphacontrol/wifi/enums/sony_web_api_method.dart';
import 'package:sonyalphacontrol/wifi/enums/web_api_version.dart';

class CameraWifiSettings extends CameraSettings {
  final SonyCameraWifiDevice sonyCameraWifiDevice;

  CameraWifiSettings(this.sonyCameraWifiDevice);

  @override
  Future<bool> update() {
    getSettings(
        WebApiVersion.V_1_4, true, sonyCameraWifiDevice); //current settings
    //camera settings?
  }

  Future<String> getSettings(WebApiVersion version, bool longPolling,
      SonyCameraWifiDevice device) async {
    var webResponse = await WifiCommand.createCommand(
        SonyWebApiMethod.GET, SettingsId.AvailableSettings,
        params: [longPolling]).send(device, timeout: 80000);
    //a list
    var jsonD = jsonDecode(webResponse.response);

    (jsonD["result"] as List<dynamic>)?.forEach((element) {
      if (element != null) {
        var settingsId = element["type"];

        SettingsItem setting = settings.singleWhere(
            (it) => it.settingsId.wifiValue == settingsId,
            orElse: () => null);
        if (setting == null) {
          setting = new SettingsItem(getSettingsId(settingsId));
          settings.add(setting);
        }

        switch (setting.settingsId) {
          case SettingsId.AvailableApiList:
            //TODO
            break;
          case SettingsId.CameraStatus:
            //TODO
            break;
          case SettingsId.LiveViewState:
            setting.value = setting.fromWifi(element["liveviewStatus"]);
            break;
          default:
            //list with candidates (available) and the current
            setting.value =
                setting.fromWifi(element["current${settingsId.startCap}"]);
            var availableList = element["${settingsId.startCap}Candidates"];

            if (availableList != null) {
              setting.available.clear();
              availableList.forEach((item) {
                setting.available.add(setting.fromWifi(item));
              });
            }
            break;
        }
      }
    });
  }
}

/*
{"result":[{"type":"availableApiList",
"names":["getVersions","getMethodTypes",
"getApplicationInfo","getAvailableApiList","getEvent","getSupportedCameraFunction",
"startLiveview","stopLiveview","startLiveviewWithSize","stopRecMode",
"getSupportedSelfTimer","getSupportedContShootingMode","getSupportedContShootingSpeed",
"getExposureMode","getSupportedExposureMode","getLiveviewSize","getAvailableLiveviewSize",
"getSupportedLiveviewSize","getPostviewImageSize","getAvailablePostviewImageSize",
"getSupportedPostviewImageSize","getShootMode","getAvailableShootMode",
"getSupportedShootMode","getSupportedFocusMode","getSupportedZoomSetting",
"setLiveviewFrameInfo","getLiveviewFrameInfo"]},

{"cameraStatus":"IDLE","type":"cameraStatus"}
,null,
{"type":"liveviewStatus","liveviewStatus":false}

,null,[],[],null,null,null,[],null,

{"cameraFunctionCandidates":["Contents Transfer","Remote Shooting"],
"type":"cameraFunction","currentCameraFunction":"Remote Shooting"}

,null,null,null,null,null,null,{
"postviewImageSizeCandidates":["2M"],"type":"postviewImageSize","currentPostviewImageSize":"2M"}
,null,{"shootModeCandidates":["still"],"type":"shootMode","currentShootMode":"still"}
,null,null,null,null,null,null,null,null,null,
{"type":"programShift","isShifted":false},null,null,null],"id":7}
 */

/*
{"result":[{"type":"availableApiList","names":["getVersions","getMethodTypes","getApplicationInfo","getAvailableApiList","getEvent","getSupportedCameraFunction",
"stopRecMode","startLiveview","stopLiveview","startLiveviewWithSize","setCameraFunction","getCameraFunction","getAvailableCameraFunction","actHalfPressShutter",
"cancelHalfPressShutter","getSupportedSelfTimer","getSupportedContShootingMode","getSupportedContShootingSpeed","getExposureMode","getSupportedExposureMode",
"getLiveviewSize","getAvailableLiveviewSize","getSupportedLiveviewSize","setPostviewImageSize","getPostviewImageSize","getAvailablePostviewImageSize",
"getSupportedPostviewImageSize","setShootMode","getShootMode","getAvailableShootMode","getSupportedShootMode","getSupportedFocusMode","getSupportedZoomSetting",
"setLiveviewFrameInfo","getLiveviewFrameInfo"]},
null,null,null,null,[],[],null,null,null,[],null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null],"id":8}
 */
