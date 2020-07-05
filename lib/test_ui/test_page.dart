import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/top_level_api/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
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
                      getSettingsRow(SettingsId.UnkD2C7),
                      getSettingsRow(SettingsId.UnkD2C5),
                      //states
                      getStateRow(SettingsId.ShootingMode),
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
                      //settings
                      getImageSizeRow(),
                      getWhiteBalanceRow(),
                      getFNumberRow(),
                      getSettingsRow(SettingsId.FocusMode),
                      getSettingsRow(SettingsId.MeteringMode),
                      getFlashRow(),
                      getEVRow(),
                      getSettingsRow(SettingsId.DriveMode),
                      getSettingsRow(SettingsId.DroHdr),
                      getShutterSpeedRow(),
                      getSettingsRow(SettingsId.AspectRatio),
                      getAelRow(),
                      getSettingsRow(SettingsId.PictureEffect),
                      getSettingsRow(SettingsId.ISO),
                      getFelRow(),
                      getFocusAreaRow(),
                      getFocusModeRow()
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
          child: Text(value?.name ?? "t"),
        ),
      );
    }
    return list;
  }

  Widget getFlashRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
        ),
        Expanded(
          child: ListTile(
              title: Text("Up"),
              onTap: () => SonyApi.api.setFlashValue(1, device)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Down"),
              onTap: () => SonyApi.api.setFlashValue(-1, device)),
        )
      ])),
    );
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
              onTap: () => SonyApi.api.startRecordingVideo(device)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Stop Record"),
              onTap: () => SonyApi.api.stopRecordingVideo(device)),
        )
      ])),
    );
  }

  Widget getEVRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.EV.name),
              subtitle: Text(
                  device.cameraSettings.getItem(SettingsId.EV)?.value?.name ??
                      "")),
        ),
        Expanded(
          child: ListTile(
              title: Text("Up"), onTap: () => SonyApi.api.setEV(1, device)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Down"), onTap: () => SonyApi.api.setEV(-1, device)),
        )
      ])),
    );
  }

  Widget getShutterSpeedRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.ShutterSpeed.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.ShutterSpeed)
                      ?.value
                      ?.name ??
                  "")),
        ),
        Expanded(
          child: ListTile(
              title: Text("Up"),
              onTap: () => SonyApi.api.setShutterSpeed(1, device)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Down"),
              onTap: () => SonyApi.api.setShutterSpeed(-1, device)),
        )
      ])),
    );
  }

  Widget getAelRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.AEL_State.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.AEL_State)
                      ?.value
                      ?.name ??
                  "")),
        ),
        Expanded(
          child: ListTile(
              title: Text("On"), onTap: () => SonyApi.api.setAel(true, device)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Off"),
              onTap: () => SonyApi.api.setAel(false, device)),
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

  Widget getFocusModeRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.FocusMode.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FocusMode)
                      ?.value
                      ?.name ??
                  "NotAvailable"),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.FocusMode),
                  context)),
        ),
        Expanded(
          child: ListTile(
              title: Text("AF"),
              onTap: () => SonyApi.api
                  .setFocusModeToggle(FocusModeToggleId.Auto, device)),
        ),
        Expanded(
          child: ListTile(
              title: Text("MF"),
              onTap: () => SonyApi.api
                  .setFocusModeToggle(FocusModeToggleId.Manual, device)),
        )
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
          child: ListTile(
              title: Text("On"), onTap: () => SonyApi.api.setFel(true, device)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Off"),
              onTap: () => SonyApi.api.setFel(false, device)),
        )
      ])),
    );
  }

  Widget getFNumberRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.FNumber.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FNumber)
                      ?.value
                      ?.name ??
                  "NotAvailable")),
        ),
        Expanded(
          child: ListTile(
              title: Text("Up"),
              onTap: () => SonyApi.api.setFNumber(1, device)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Down"),
              onTap: () => SonyApi.api.setFNumber(-1, device)),
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
                onTap: () =>
                    SonyApi.api.pressShutter(ShutterPressType.Half, device)),
          ),
          Expanded(
            child: ListTile(
                title: Text("release HalfPressShutter"),
                onTap: () =>
                    SonyApi.api.releaseShutter(ShutterPressType.Half, device)),
          )
        ])),
        IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
        ])),
        IntrinsicHeight(
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
        ])),
        ListTile(
            title: Text("capture photo"),
            onTap: () => SonyApi.api.capturePhoto(device)),
      ],
    ));
  }
}
