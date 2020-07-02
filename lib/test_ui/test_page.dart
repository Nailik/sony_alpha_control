import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/top_level_api/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';

class TestsPage extends StatefulWidget {
  final SonyCameraDevice device;

  const TestsPage({Key key, this.device}) : super(key: key);

  @override
  _TestsPageState createState() => _TestsPageState(device);
}

class _TestsPageState extends State<TestsPage> {
  final SonyCameraDevice device;

  _TestsPageState(this.device);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.blueGrey,
            body: ChangeNotifierProvider<CameraSettings>(
                create: (context) => SonyApi.connectedCamera.cameraSettings,
                child: Consumer<CameraSettings>(
                  builder: (context, model, _) => ListView(
                    children: <Widget>[
                      getTwoFunctionRow("func1", "func2", () => print("func1"),
                          () => print("func2")),
                      //states
                      getStateRow(SettingsId.ShootingMode),
                      getStateRow(SettingsId.AutoFocusState),
                      getStateRow(SettingsId.BatteryInfo),
                      //functions
                      getVideoRow(),
                      getImageRow(),
                      //settings
                      getImageSizeRow(),
                      getWhiteBalanceRow(),
                      getSettingsRow(SettingsId.FNumber),
                      getSettingsRow(SettingsId.FocusMode),
                      getSettingsRow(SettingsId.MeteringMode),
                      getFlashRow(),
                      getSettingsRow(SettingsId.EV),
                      getSettingsRow(SettingsId.DriveMode),
                      getSettingsRow(SettingsId.DroHdr),
                      getSettingsRow(SettingsId.ShutterSpeed),
                      getSettingsRow(SettingsId.AspectRatio),
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
                    SonyApi.updateSettings();
                  },
                )
              ],
            )));
  }

  Widget getTwoFunctionRow(
      String f1, String f2, Function func1, Function func2) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: ListTile(title: Text(f1), onTap: func1),
        ),
        Expanded(
          child: ListTile(title: Text(f2), onTap: func2),
        )
      ]),
    );
  }

  //getSettingsRow(SettingsId.FileFormat),

  Widget getImageSizeRow() {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.FileFormat.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FileFormat)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.FileFormat),
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

  Widget getWhiteBalanceRow() {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.WhiteBalance.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.WhiteBalance)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.WhiteBalance),
                  context)),
        ),
        Expanded(
          child: ListTile(
              title: Text(SettingsId.WhiteBalanceColorTemp.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.WhiteBalanceColorTemp)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings
                      .getItem(SettingsId.WhiteBalanceColorTemp),
                  context)),
        ),
        Expanded(
          child: ListTile(
              title: Text(SettingsId.WhiteBalanceAB.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.WhiteBalanceAB)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.WhiteBalanceAB),
                  context)),
        ),
        Expanded(
          child: ListTile(
              title: Text(SettingsId.WhiteBalanceGM.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.WhiteBalanceGM)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.WhiteBalanceGM),
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
            SonyApi.setSettingsRaw(data.settingsId, value.usbValue);
          },
          child: Text(value.name ?? ""),
        ),
      );
    }
    return list;
  }

  Widget getFlashRow() {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.FlashMode.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FlashMode)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.FlashMode),
                  context)),
        ),
        Expanded(
          child: ListTile(
              title: Text(SettingsId.Flash.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.Flash)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.Flash), context)),
        )
      ]),
    );
  }

  Widget getVideoRow() {
    return Card(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ListTile(
                  title: Text("Start Record"),
                  onTap: () => SonyApi.api.startRecordingVideo(device)),
            ),
            Expanded(
              child: ListTile(
                  title: Text("Stop Record"),
                  onTap: () => SonyApi.api.stopRecordingVideo(device)),
            ),
            Expanded(
              child: ListTile(
                  title: Text(SettingsId.RecordVideoState.name),
                  subtitle: Text(device.cameraSettings
                          .getItem(SettingsId.RecordVideoState)
                          ?.value
                          ?.name ??
                      "")),
            )
          ]),
    );
  }

  Widget getImageRow() {
    return Card(
        child: Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: ListTile(
                title: Text("HalfPressShutter"),
                onTap: () =>
                    SonyApi.api.pressShutter(ShutterPressType.Half, device)),
          ),
          Expanded(
            child: ListTile(
                title: Text("release HalfPressShutter"),
                onTap: () =>
                    SonyApi.api.releaseShutter(ShutterPressType.Half, device)),
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: ListTile(
                title: Text("FullPressShutter"),
                onTap: () =>
                    SonyApi.api.pressShutter(ShutterPressType.Full, device)),
          ),
          Expanded(
            child: ListTile(
                title: Text("release FullPressShutter"),
                onTap: () =>
                    SonyApi.api.releaseShutter(ShutterPressType.Full, device)),
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
            child: ListTile(
                title: Text("BothPressShutter"),
                onTap: () =>
                    SonyApi.api.pressShutter(ShutterPressType.Both, device)),
          ),
          Expanded(
            child: ListTile(
                title: Text("release BothPressShutter"),
                onTap: () =>
                    SonyApi.api.releaseShutter(ShutterPressType.Both, device)),
          )
        ]),
      ],
    ));
  }
}
