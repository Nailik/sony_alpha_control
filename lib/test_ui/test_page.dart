import 'package:file_chooser/file_chooser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/ids/flash_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/image_file_format_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/metering_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ids.dart';
import 'package:sonyalphacontrol/wifi/enums/force_update.dart';

class TestsPage extends StatefulWidget {
  final SonyCameraDevice device;

  const TestsPage({Key key, this.device}) : super(key: key);

  @override
  TestsPageState createState() => TestsPageState(device);
}

class TestsPageState extends State<TestsPage> {
  static ValueNotifier<String> path = ValueNotifier("Empty");

  final SonyCameraDevice device;

  TestsPageState(this.device);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                //    leading: CircularProgressIndicator(
                //      valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                ),
            backgroundColor: Colors.blueGrey,
            body: ListenableProvider<CameraSettings>(
                create: (context) => SonyApi.connectedCamera.cameraSettings,
                child: Consumer<CameraSettings>(
                  builder: (context, model, _) => ListView(
                    children: <Widget>[
                      ///Versions (get)
                      getVersionsRow(),

                      ///MethodTypes (get)
                      getMethodTypesRow(),

                      ///ApplicationInfo (get)
                      getApplicationInfoRow(),

                      ///ApiList (getAvailable)
                      getApiListRow(),

                      ///AvailableSettings (get)
                      getAvailableSettingsRow(),

                      ///CameraFunction (set, get, getSupported, getAvailable)
                      getCameraFunctionsRow(),

                      ///CapturePhoto (act)
                      getCapturePhotoRow(),

                      ///CameraSetup (stop)
                      getCameraSetupRow(),

                      ///LiveView (start, stop)
                      getLiveViewRow(),

                      ///LiveViewWithSize (start)
                      getLiveViewWithSizeRow(),

                      ///Zoom (act)
                      getZoomRow(),

                      ///HalfPressShutter (act, cancel)
                      getHalfPressShutterRow(),

                      ///SelfTimer (set, get, getSupported, getAvailable)
                      getSelfTimerRow(),

                      ///ContShootingMode (set, get, getSupported, getAvailable)
                      getContShootingModeRow(),

                      ///ContShootingSpeed (set, get, getSupported, getAvailable)
                      getContShootingSpeedRow(),

                      ///MeteringMode (get, getSupported)
                      getMeteringModeRow(),

                      ///Ev (set, get, getSupported, getAvailable)
                      getEVRow(),

                      ///FNumber (set, get, getSupported, getAvailable)
                      getFNumberRow(),

                      ///Iso (set, get, getSupported, getAvailable)
                      getIsoRow(),

                      ///LiveViewSize (set, get, getSupported, getAvailable)
                      getLiveViewSizeRow(),

                      ///PostViewImageSize (set, get, getSupported, getAvailable)
                      getPostViewImageSizeRow(),

                      ///ProgramShift (set, get, getSupported, getAvailable)
                      getProgramShiftRow(),

                      ///ShootingMode (set, get, getSupported, getAvailable)
                      getShootingModeRow(),

                      ///ShutterSpeed (set, get, getSupported, getAvailable)
                      getShutterSpeedRow(),

                      ///FocusAreaSpot (set, get)
                      getFocusAreaSpotRow(),

                      ///WhiteBalance (set, get, getSupported, getAvailable)
                      getWhiteBalanceModeRow(),
                      getWhiteBalanceColorTempRow(),

                      ///FlashMode (set, get, getSupported, getAvailable)
                      getFlashRow(),

                      ///FocusMode (set, get, getSupported, getAvailable)
                      getFocusModeRow(),

                      ///ZoomSetting (set, get, getSupported, getAvailable)
                      getZoomSettingRow(),

                      ///StorageInformation (get)
                      getStorageInformationRow(),

                      ///LiveViewInfo (set, get)
                      getLiveViewInfoRow(),

                      ///SilentShootingSettings (set, get, getSupported, getAvailable)
                      getSilentShootingSettings()
                    ],
                  ),
                )),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0)),
                  child: Text("reload"),
                  color: Colors.blue,
                  onPressed: () {
                    device.updateSettings();
                  },
                )
              ],
            )));
  }

  ///Versions (get)
  Widget getVersionsRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => (device.cameraSettings.getItem(SettingsId.Versions)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///MethodTypes (get)
  Widget getMethodTypesRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.MethodTypes)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///ApplicationInfo (get)
  Widget getApplicationInfoRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.ApplicationInfo)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///ApiList (getAvailable)
  Widget getApiListRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => (device.cameraSettings.getItem(SettingsId.ApiList)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///AvailableSettings (get)
  Widget getAvailableSettingsRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.AvailableSettings)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///CameraFunction (set, get, getSupported, getAvailable)
  Widget getCameraFunctionsRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.CameraFunction)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///CapturePhoto (act)
  Widget getCapturePhotoRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.CapturePhoto)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///CameraSetup (stop)
  Widget getCameraSetupRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.CameraSetup)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///LiveView (start, stop)
  Widget getLiveViewRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => (device.cameraSettings.getItem(SettingsId.LiveView)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///LiveViewWithSize (start)
  Widget getLiveViewWithSizeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.LiveViewWithSize)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///Zoom (act)
  Widget getZoomRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => (device.cameraSettings.getItem(SettingsId.Zoom)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///HalfPressShutter (act, cancel)
  Widget getHalfPressShutterRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.HalfPressShutter)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///SelfTimer (set, get, getSupported, getAvailable)
  Widget getSelfTimerRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.SelfTimer)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///ContShootingMode (set, get, getSupported, getAvailable)
  Widget getContShootingModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.ContShootingMode)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///ContShootingSpeed (set, get, getSupported, getAvailable)
  Widget getContShootingSpeedRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.ContShootingSpeed)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///MeteringMode (get, getSupported)
  Widget getMeteringModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.MeteringMode)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///Ev (set, get, getSupported, getAvailable)
  Widget getEVRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => (device.cameraSettings.getItem(SettingsId.EV)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(SettingsId.EV.name),
              subtitle: Text(
                  device.cameraSettings.getItem(SettingsId.EV).value?.name ??
                      "NotAvailable"),
              onTap: () => device.api.getEV(update: ForceUpdate.Both),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text("Up"), onTap: () => device.api.modifyEV(1)),
              ),
              Expanded(
                child: ListTile(
                    title: Text("Down"), onTap: () => device.api.modifyEV(-1)),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<EvValue>(
                        hint: Text("available"),
                        items: device.cameraSettings
                            .getItem(SettingsId.EV)
                            .available
                            .map<DropdownMenuItem<EvValue>>((e) =>
                                DropdownMenuItem<EvValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setEV(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<EvValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings
                            .getItem(SettingsId.EV)
                            .supported
                            .map<DropdownMenuItem<EvValue>>((e) =>
                                DropdownMenuItem<EvValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setEV(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///FNumber (set, get, getSupported, getAvailable)
  Widget getFNumberRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) =>
            (device.cameraSettings.getItem(SettingsId.FNumber)),
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(SettingsId.FNumber.name),
                      subtitle: Text(device.cameraSettings
                              .getItem(SettingsId.FNumber)
                              .value
                              ?.name ??
                          "NotAvailable"),
                      onTap: () =>
                          device.api.getFNumber(update: ForceUpdate.Both),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ListTile(
                                title: Text("Up"),
                                onTap: () => device.api.modifyFNumber(1)),
                          ),
                          Expanded(
                            child: ListTile(
                                title: Text("Down"),
                                onTap: () => device.api.modifyFNumber(-1)),
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<DoubleValue>(
                                    hint: Text("available"),
                                    items: device.cameraSettings
                                        .getItem(SettingsId.FNumber)
                                        .available
                                        .map<DropdownMenuItem<DoubleValue>>(
                                            (e) =>
                                                DropdownMenuItem<DoubleValue>(
                                                    child: Text(e.name),
                                                    value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setFNumber(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<DoubleValue>(
                                    hint: Text("supported"),
                                    items: device.cameraSettings
                                        .getItem(SettingsId.FNumber)
                                        .supported
                                        .map<DropdownMenuItem<DoubleValue>>(
                                            (e) =>
                                                DropdownMenuItem<DoubleValue>(
                                                    child: Text(e.name),
                                                    value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setFNumber(value),
                                  ))),
                        ]),
                  ]),
                )));
  }

  ///Iso (set, get, getSupported, getAvailable)
  Widget getIsoRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => (device.cameraSettings.getItem(SettingsId.ISO)),
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(SettingsId.ISO.name),
                      subtitle: Text(device.cameraSettings
                              .getItem(SettingsId.ISO)
                              .value
                              ?.name ??
                          "NotAvailable"),
                      onTap: () => device.api.getIso(update: ForceUpdate.Both),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ListTile(
                                title: Text("Up"),
                                onTap: () => device.api.modifyIso(1)),
                          ),
                          Expanded(
                            child: ListTile(
                                title: Text("Down"),
                                onTap: () => device.api.modifyIso(-1)),
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<IsoValue>(
                                    hint: Text("available"),
                                    items: device.cameraSettings
                                        .getItem(SettingsId.ISO)
                                        .available
                                        .map<DropdownMenuItem<IsoValue>>((e) =>
                                            DropdownMenuItem<IsoValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setIso(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<IsoValue>(
                                    hint: Text("supported"),
                                    items: device.cameraSettings
                                        .getItem(SettingsId.ISO)
                                        .supported
                                        .map<DropdownMenuItem<IsoValue>>((e) =>
                                            DropdownMenuItem<IsoValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setIso(value),
                                  ))),
                        ]),
                  ]),
                )));
  }

  ///LiveViewSize (set, get, getSupported, getAvailable)
  Widget getLiveViewSizeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.LiveViewSize)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///PostViewImageSize (set, get, getSupported, getAvailable)
  Widget getPostViewImageSizeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.PostViewImageSize)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///ProgramShift (set, get, getSupported, getAvailable)
  Widget getProgramShiftRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.ProgramShift)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///ShootingMode (set, get, getSupported, getAvailable)
  Widget getShootingModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.ShootingMode)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///ShutterSpeed (set, get, getSupported, getAvailable)
  Widget getShutterSpeedRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.ShutterSpeed)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(SettingsId.ShutterSpeed.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.ShutterSpeed)
                      .value
                      ?.name ??
                  "NotAvailable"),
              onTap: () => device.api.getShutterSpeed(update: ForceUpdate.Both),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text("Up"),
                    onTap: () => device.api.modifyShutterSpeed(1)),
              ),
              Expanded(
                child: ListTile(
                    title: Text("Down"),
                    onTap: () => device.api.modifyShutterSpeed(-1)),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ShutterSpeedValue>(
                        hint: Text("available"),
                        items: device.cameraSettings
                            .getItem(SettingsId.ShutterSpeed)
                            .available
                            .map<DropdownMenuItem<ShutterSpeedValue>>((e) =>
                                DropdownMenuItem<ShutterSpeedValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setShutterSpeed(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ShutterSpeedValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings
                            .getItem(SettingsId.ShutterSpeed)
                            .supported
                            .map<DropdownMenuItem<ShutterSpeedValue>>((e) =>
                                DropdownMenuItem<ShutterSpeedValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setShutterSpeed(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///FocusAreaSpot (set, get, getSupported, getAvailable)
  Widget getFocusAreaSpotRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.FocusAreaSpot)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///WhiteBalance (set, get, getSupported, getAvailable)
  Widget getWhiteBalanceModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.WhiteBalance)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(SettingsId.WhiteBalance.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.WhiteBalance)
                      .value
                      ?.name ??
                  "NotAvailable"),
              onTap: () =>
                  device.api.getWhiteBalanceMode(update: ForceUpdate.Both),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WhiteBalanceModeValue>(
                        hint: Text("available"),
                        items: device.cameraSettings
                            .getItem(SettingsId.WhiteBalance)
                            .available
                            .map<DropdownMenuItem<WhiteBalanceModeValue>>((e) =>
                                DropdownMenuItem<WhiteBalanceModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setWhiteBalanceMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WhiteBalanceModeValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings
                            .getItem(SettingsId.WhiteBalance)
                            .supported
                            .map<DropdownMenuItem<WhiteBalanceModeValue>>((e) =>
                                DropdownMenuItem<WhiteBalanceModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setWhiteBalanceMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget getWhiteBalanceColorTempRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.WhiteBalanceColorTemp)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(SettingsId.WhiteBalanceColorTemp.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.WhiteBalanceColorTemp)
                      .value
                      ?.name ??
                  "NotAvailable"),
              onTap: () =>
                  device.api.getWhiteBalanceColorTemp(update: ForceUpdate.Both),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text("Up"),
                    onTap: () => device.api.modifyWhiteBalanceColorTemp(1)),
              ),
              Expanded(
                child: ListTile(
                    title: Text("Down"),
                    onTap: () => device.api.modifyWhiteBalanceColorTemp(-1)),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WhiteBalanceColorTempValue>(
                        hint: Text("available"),
                        items: device.cameraSettings
                            .getItem(SettingsId.WhiteBalanceColorTemp)
                            .available
                            .map<DropdownMenuItem<WhiteBalanceColorTempValue>>(
                                (e) => DropdownMenuItem<
                                        WhiteBalanceColorTempValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setWhiteBalanceColorTemp(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WhiteBalanceColorTempValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings
                            .getItem(SettingsId.WhiteBalanceColorTemp)
                            .supported
                            .map<DropdownMenuItem<WhiteBalanceColorTempValue>>(
                                (e) => DropdownMenuItem<
                                        WhiteBalanceColorTempValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setWhiteBalanceColorTemp(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///FlashMode (set, get, getSupported, getAvailable)
  Widget getFlashRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.FlashMode)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(SettingsId.FlashMode.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FlashMode)
                      .value
                      ?.name ??
                  "NotAvailable"),
              onTap: () => device.api.getFlashMode(update: ForceUpdate.Both),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<FlashModeValue>(
                        hint: Text("available"),
                        items: device.cameraSettings
                            .getItem(SettingsId.FlashMode)
                            .available
                            .map<DropdownMenuItem<FlashModeValue>>((e) =>
                                DropdownMenuItem<FlashModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setFlashMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<FlashModeValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings
                            .getItem(SettingsId.FlashMode)
                            .supported
                            .map<DropdownMenuItem<FlashModeValue>>((e) =>
                                DropdownMenuItem<FlashModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setFlashMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///FocusMode (set, get, getSupported, getAvailable)
  Widget getFocusModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.FocusMode)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(SettingsId.FocusMode.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FocusMode)
                      .value
                      ?.name ??
                  "NotAvailable"),
              onTap: () => device.api.getFocusMode(update: ForceUpdate.Both),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<FocusModeValue>(
                        hint: Text("available"),
                        items: device.cameraSettings
                            .getItem(SettingsId.FocusMode)
                            .available
                            .map<DropdownMenuItem<FocusModeValue>>((e) =>
                                DropdownMenuItem<FocusModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setFocusMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<FocusModeValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings
                            .getItem(SettingsId.FocusMode)
                            .supported
                            .map<DropdownMenuItem<FocusModeValue>>((e) =>
                                DropdownMenuItem<FocusModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setFocusMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///ZoomSetting (set, get, getSupported, getAvailable)
  Widget getZoomSettingRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.ZoomSetting)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///StorageInformation (get)
  Widget getStorageInformationRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.StorageInformation)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///LiveViewInfo (set, get)
  Widget getLiveViewInfoRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.LiveViewInfo)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }

  ///SilentShootingSettings (set, get, getSupported, getAvailable)
  Widget getSilentShootingSettings() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.SilentShootingSettings)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(),
      ),
    );
  }
}
