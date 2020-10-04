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
                      //states
                      getFNumberRow(),
                      getIsoRow(),
                      getShutterSpeed(),
                      getEVRow(),
                      getFlashRow(),
                      getFocusModeRow(),
                      getWhiteBalanceModeRow(),
                      getWhiteBalanceColorTempRow(),
                      getImageFormatRow()
                      /*
                      getSettingsRow(SettingsId.MeteringMode), getStateRow(SettingsId.ShootingMode),
                      getStateRow(SettingsId.AutoFocusState),
                      getStateRow(SettingsId.BatteryInfo),
                      getStateRow(SettingsId.LiveViewState),
                      getStateRow(SettingsId.SensorCrop),
                      getStateRow(SettingsId.FocusMagnifierState),
                      getStateRow(SettingsId.UseLiveViewDisplayEffect),
                      getStateRow(SettingsId.PhotoTransferQueue),
                      getStateRow(SettingsId.Zoom),
                      //functions
                      getVideoRow(),
                      getImageRow(),
                      getLiveViewRow(),
                      //settings
                      getImageSizeRow(),,
                      getSettingsRow(SettingsId.DriveMode),
                      getSettingsRow(SettingsId.DroHdr),
                      getSettingsRow(SettingsId.AspectRatio),
                      getSettingsRow(SettingsId.PictureEffect),
                      getFelRow(),
                      getFocusAreaRow(),
                      getFocusModeRow(),
                      getSettingsRow(SettingsId.UnkD2C7),
                      getSettingsRow(SettingsId.UnkD2C5),*/
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
              onTap: () => device.api.getImageFileFormat(update: ForceUpdate.Both),
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
                        onChanged: (value) => device.api.setImageFileFormat(value),
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
                        onChanged: (value) => device.api.setImageFileFormat(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  //done

  Widget getMeteringModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) =>
          (device.cameraSettings.getItem(SettingsId.MeteringMode)),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(SettingsId.MeteringMode.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.MeteringMode)
                      .value
                      ?.name ??
                  "NotAvailable"),
              onTap: () => device.api.getMeteringMode(update: ForceUpdate.Both),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<MeteringModeValue>(
                        hint: Text("available"),
                        items: device.cameraSettings
                            .getItem(SettingsId.MeteringMode)
                            .available
                            .map<DropdownMenuItem<MeteringModeValue>>((e) =>
                                DropdownMenuItem<MeteringModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setMeteringMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<MeteringModeValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings
                            .getItem(SettingsId.MeteringMode)
                            .supported
                            .map<DropdownMenuItem<MeteringModeValue>>((e) =>
                                DropdownMenuItem<MeteringModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setMeteringMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  Widget getAelRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) =>
            (device.cameraSettings.getItem(SettingsId.AEL_State)),
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: IntrinsicHeight(
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                        Expanded(
                          child: ListTile(
                              title: Text(SettingsId.AEL_State.name),
                              subtitle: Text(device.cameraSettings
                                      .getItem(SettingsId.AEL_State)
                                      .value
                                      ?.name ??
                                  "NotAvailable"),
                              onTap: () =>
                                  device.api.getAel(update: ForceUpdate.Both)),
                        ),
                        Expanded(
                          child: SwitchListTile(
                              title: Text("Switch"),
                              value: device.cameraSettings
                                      .getItem(SettingsId.AEL_State)
                                      ?.value
                                      ?.id ??
                                  false,
                              onChanged: (value) => device.api.setAel(value)),
                        ),
                      ])),
                )));
  }

  Widget getImageSizeRow() {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.ImageFileFormat.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.ImageFileFormat)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.ImageFileFormat),
                  context)),
        ),
        Expanded(
          child: ListTile(
              title: Text(SettingsId.ImageSize.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.ImageSize)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.ImageSize),
                  context)),
        )
      ]),
    );
  }

  Widget getStateRow(SettingsId settingsId) {
    var name = settingsId.name;
    var value = device.cameraSettings.getItem(settingsId)?.value?.name ?? "";
    return Card(
      child: ListTile(title: Text(name), subtitle: Text(value.toString())),
    );
  }

  Widget getSettingsRow(SettingsId settingsId) {
    var name = settingsId.name;
    var settingsItem = device.cameraSettings.getItem(settingsId);
    return Card(
      child: ListTile(
          title: Text(name),
          subtitle: Text(settingsItem?.value?.name ?? ""),
          onTap: () async => dialog(settingsItem, context)),
    );
  }

  Widget getFunctionsRow(SettingsId settingsId) {
    var name = settingsId.name;
    var settingsItem = device.cameraSettings.getItem(settingsId);
    return Card(
      child: ListTile(
          title: Text(name),
          subtitle: Text(settingsItem?.value?.name ?? ""),
          onTap: () async => dialog(settingsItem, context)),
    );
  }

  dialog(SettingsItem settingsItem, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new SimpleDialog(
              title: Text('Select ${settingsItem.value} mode'),
              children: getOptions(settingsItem));
        });
  }

  List<Widget> getOptions(SettingsItem data) {
    List<Widget> list = new List();
    for (var value in data.available) {
      list.add(
        new SimpleDialogOption(
          onPressed: () {
            device.api.setSettingsRaw(data.settingsId, value.usbValue);
          },
          child: Text(value?.name ?? "t"),
        ),
      );
    }
    return list;
  }

  Widget getVideoRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.RecordVideoState.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.RecordVideoState)
                      ?.value
                      ?.name ??
                  "")),
        ),
        Expanded(
          child: ListTile(
              title: Text("Start Record"),
              onTap: () => device.api.startRecordingVideo()),
        ),
        Expanded(
          child: ListTile(
              title: Text("Stop Record"),
              onTap: () => device.api.stopRecordingVideo()),
        )
      ])),
    );
  }

  Widget getFocusAreaRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.FocusArea.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FocusArea)
                      ?.value
                      ?.name ??
                  "NotAvailable"),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.FocusArea),
                  context)),
        ),
        Expanded(
            child: ListTile(
          title: Text(SettingsId.FocusAreaSpot.name),
          subtitle: Text(device.cameraSettings
                  .getItem(SettingsId.FocusAreaSpot)
                  ?.value
                  ?.name ??
              "NotAvailable"),
        )),
      ])),
    );
  }

  Widget getFelRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.FEL_State.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FEL_State)
                      ?.value
                      ?.name ??
                  "NotAvailable")),
        ),
        Expanded(
          child:
              ListTile(title: Text("On"), onTap: () => device.api.setFel(true)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Off"), onTap: () => device.api.setFel(false)),
        )
      ])),
    );
  }

  Widget getImageRow() {
    return Card(
        child: Column(
      children: [
        IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: ListTile(
                title: Text("HalfPressShutter"),
                onTap: () => device.api.pressShutter(ShutterPressType.Half)),
          ),
          Expanded(
            child: ListTile(
                title: Text("release HalfPressShutter"),
                onTap: () => device.api.releaseShutter(ShutterPressType.Half)),
          )
        ])),
        IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: ListTile(
                title: Text("FullPressShutter"),
                onTap: () => device.api.pressShutter(ShutterPressType.Full)),
          ),
          Expanded(
            child: ListTile(
                title: Text("release FullPressShutter"),
                onTap: () => device.api.releaseShutter(ShutterPressType.Full)),
          )
        ])),
        IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: ListTile(
                title: Text("BothPressShutter"),
                onTap: () => device.api.pressShutter(ShutterPressType.Both)),
          ),
          Expanded(
            child: ListTile(
                title: Text("release BothPressShutter"),
                onTap: () => device.api.releaseShutter(ShutterPressType.Both)),
          )
        ])),
        IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: ListTile(
                title: Text("capture photo"),
                onTap: () => device.api.capturePhoto()),
          ),
          Expanded(
              child: ListTile(
                  title: Text("select folder"),
                  subtitle: ValueListenableBuilder(
                      //ListenableProvider.value is not working
                      valueListenable: path,
                      builder: (_, __, ___) => Text(path.value.toString())),
                  onTap: () =>
                      showOpenPanel(canSelectDirectories: true).then((value) {
                        path.value = value.paths[0].toString();
                      })))
        ])),
      ],
    ));
  }

  Widget getLiveViewRow() {
    return Card(
      child: ListTile(
        title: Text(SettingsId.LiveView.name),
        subtitle: Text(device.cameraSettings
                .getItem(SettingsId.LiveViewState)
                ?.value
                ?.name ??
            "NotAvailable"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LiveViewPage(device)),
          );
        },
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
