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

                      ///MethodTypes (get)

                      ///ApplicationInfo (get)

                      ///ApiList (getAvailable)

                      ///AvailableSettings (get)

                      ///CameraFunction (set, get, getSupported, getAvailable)

                      ///CapturePhoto (act)
                      //getCapturePhotoRow(),
                      ///CameraSetup (stop)

                      ///LiveView (start, stop)

                      ///LiveViewWithSize (start)

                      ///Zoom (act)

                      ///HalfPressShutter (act, cancel)

                      ///SelfTimer (set, get, getSupported, getAvailable)

                      ///ContShootingMode (set, get, getSupported, getAvailable)

                      ///ContShootingSpeed (set, get, getSupported, getAvailable)

                      ///MeteringMode (get, getSupported)

                      ///Ev (set, get, getSupported, getAvailable)
                      getEVRow(),

                      ///FNumber (set, get, getSupported, getAvailable)
                      getFNumberRow(),

                      ///Iso (set, get, getSupported, getAvailable)
                      getIsoRow(),

                      ///LiveViewSize (set, get, getSupported, getAvailable)

                      ///PostViewImageSize (set, get, getSupported, getAvailable)

                      ///ProgramShift (set, get, getSupported, getAvailable)

                      ///ShootingMode (set, get, getSupported, getAvailable)

                      ///ShutterSpeed (set, get, getSupported, getAvailable)
                      getShutterSpeed(),

                      ///FocusAreaSpot (set, get)

                      ///WhiteBalance (set, get, getSupported, getAvailable)
                      getWhiteBalanceModeRow(),
                      getWhiteBalanceColorTempRow(),

                      ///FlashMode (set, get, getSupported, getAvailable)
                      getFlashRow(),

                      ///FocusMode (set, get, getSupported, getAvailable)
                      getFocusModeRow(),

                      ///ZoomSetting (set, get, getSupported, getAvailable)

                      ///StorageInformation (get)

                      ///LiveViewInfo (set, get)

                      ///SilentShootingSettings (set, get, getSupported, getAvailable)

                      getImageFormatRow()
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

  Widget getShutterSpeed() {
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

  Widget getImageFormatRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.ImageFileFormat)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(SettingsId.ImageFileFormat.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.ImageFileFormat)
                      .value
                      ?.name ??
                  "NotAvailable"),
              onTap: () =>
                  device.api.getImageFileFormat(update: ForceUpdate.Both),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ImageFileFormatValue>(
                        hint: Text("available"),
                        items: device.cameraSettings
                            .getItem(SettingsId.ImageFileFormat)
                            .available
                            .map<DropdownMenuItem<ImageFileFormatValue>>((e) =>
                                DropdownMenuItem<ImageFileFormatValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setImageFileFormat(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ImageFileFormatValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings
                            .getItem(SettingsId.ImageFileFormat)
                            .supported
                            .map<DropdownMenuItem<ImageFileFormatValue>>((e) =>
                                DropdownMenuItem<ImageFileFormatValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setImageFileFormat(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }
}

class LiveViewPage extends StatelessWidget {
  final SonyCameraDevice device;

  LiveViewPage(this.device);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LiveView")),
      body: StreamBuilder<Image>(
        stream: device.api.streamLiveView(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
