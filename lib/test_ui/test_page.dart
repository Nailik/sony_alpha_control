import 'package:file_chooser/file_chooser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_camera_api_interface.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_toggle_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';

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
              leading: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
            ),
            backgroundColor: Colors.blueGrey,
            body: ChangeNotifierProvider<CameraSettings>(
                create: (context) => SonyApi.connectedCamera.cameraSettings,
                child: Consumer<CameraSettings>(
                  builder: (context, model, _) => ListView(
                    children: <Widget>[
                      //states
                      getFNumberRow(),
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
                      getLiveViewRow(),
                      //settings
                      getImageSizeRow(),
                      getWhiteBalanceRow(),
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
                      getIsoRow(),
                      getFelRow(),
                      getFocusAreaRow(),
                      getFocusModeRow(),
                      getSettingsRow(SettingsId.UnkD2C7),
                      getSettingsRow(SettingsId.UnkD2C5),
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
                  title: Text("Up"), onTap: () => device.api.setFNumber(1)),
            ),
            Expanded(
              child: ListTile(
                  title: Text("Down"), onTap: () => device.api.setFNumber(-1)),
            )
          ])),
    );
  }


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
            device.api.setSettingsRaw(data.settingsId, value.usbValue);
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
              title: Text(SettingsId.FlashValue.name),
              subtitle: Text(device.cameraSettings
                      .getItem(SettingsId.FlashValue)
                      ?.value
                      ?.name ??
                  ""),
              onTap: () => dialog(
                  device.cameraSettings.getItem(SettingsId.FlashValue),
                  context)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Up"), onTap: () => device.api.setFlashValue(1)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Down"), onTap: () => device.api.setFlashValue(-1)),
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
          child: ListTile(title: Text("Up"), onTap: () => device.api.setEV(1)),
        ),
        Expanded(
          child:
              ListTile(title: Text("Down"), onTap: () => device.api.setEV(-1)),
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
              title: Text("Up"), onTap: () => device.api.setShutterSpeed(1)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Down"), onTap: () => device.api.setShutterSpeed(-1)),
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
          child:
              ListTile(title: Text("On"), onTap: () => device.api.setAel(true)),
        ),
        Expanded(
          child: ListTile(
              title: Text("Off"), onTap: () => device.api.setAel(false)),
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
              onTap: () =>
                  device.api.setFocusModeToggle(FocusModeToggleId.Auto)),
        ),
        Expanded(
          child: ListTile(
              title: Text("MF"),
              onTap: () =>
                  device.api.setFocusModeToggle(FocusModeToggleId.Manual)),
        )
      ])),
    );
  }

  Widget getIsoRow() {
    return Card(
      child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.ISO.name),
              subtitle: Text(
                  device.cameraSettings.getItem(SettingsId.ISO)?.value?.name ??
                      "NotAvailable"),
              onTap: () async => dialog(
                  device.cameraSettings.getItem(SettingsId.ISO), context)),
        ),
        Expanded(
          child: ListTile(title: Text("Up"), onTap: () => device.api.setIso(1)),
        ),
        Expanded(
          child:
              ListTile(title: Text("Down"), onTap: () => device.api.setIso(-1)),
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
                      //ChangeNotifierProvider.value is not working
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
