import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api.dart';
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
          body: ListView(
            children: <Widget>[
              getTwoFunctionRow(
                  "func1", "func2", () => print("func1"), () => print("func2")),
              getStateRow(SettingsId.FileFormat),
              getWhiteBalanceRow(),
              getFunctionRow(SettingsId.FNumber),
              getFunctionRow(SettingsId.FocusMode),
              getFunctionRow(SettingsId.MeteringMode),
              getFunctionRow(SettingsId.FlashMode),
              getFunctionRow(SettingsId.ShootingMode),
              getFunctionRow(SettingsId.EV),
              getStateRow(SettingsId.BatteryInfo),
            ],
          )),
    );
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

  Widget getWhiteBalanceRow() {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Expanded(
          child: ListTile(
              title: Text(SettingsId.WhiteBalance.name),
              subtitle: Text(device.cameraSettings
                  .getItem(SettingsId.WhiteBalance)
                  ?.getValueName()),
              onTap: () {
                showSimpleDialog(device.cameraSettings
                    .getItem(SettingsId.WhiteBalance), context);
              }),
        ),
        Expanded(
          child: ListTile(
              title: Text(SettingsId.WhiteBalanceColorTemp.name),
              subtitle: Text(device.cameraSettings
                  .getItem(SettingsId.WhiteBalanceColorTemp)
                  ?.getValueName()),
              onTap: () {
                showSimpleDialog(device.cameraSettings
                    .getItem(SettingsId.WhiteBalanceColorTemp), context);}),
        ),
        Expanded(
          child: ListTile(
              title: Text(SettingsId.WhiteBalanceAB.name),
              subtitle: Text(device.cameraSettings
                  .getItem(SettingsId.WhiteBalanceAB)
                  ?.getValueName()),
              onTap: () {
                showSimpleDialog(device.cameraSettings
                    .getItem(SettingsId.WhiteBalanceAB), context);}),
        ),
        Expanded(
          child: ListTile(
              title: Text(SettingsId.WhiteBalanceGM.name),
              subtitle: Text(device.cameraSettings
                  .getItem(SettingsId.WhiteBalanceGM)
                  ?.getValueName()),
              onTap: () {
                showSimpleDialog(device.cameraSettings
                    .getItem(SettingsId.WhiteBalanceGM), context);}),
        )
      ]),
    );
  }

  Widget getStateRow(SettingsId settingsId) {
    var name = settingsId.name;
    var value = device.cameraSettings.getItem(settingsId)?.value ?? "null";
    return Card(
      child: ListTile(title: Text(name), subtitle: Text(value.toString())),
    );
  }

  Widget getFunctionRow(SettingsId settingsId) {
    var name = settingsId.name;
    var settingsItem = device.cameraSettings.getItem(settingsId);
    var value = settingsItem.getNameOf(settingsItem.value);
    return Card(
      child: ListTile(
          title: Text(name),
          subtitle: Text(value.toString()),
          onTap: () async {showSimpleDialog(settingsItem, context);}),
    );
  }

  showSimpleDialog(SettingsItem settingsItem, BuildContext context) {
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
            SonyApi.setSettingsRaw(data.settingsId, value);
          },
          child: Text(data.getNameOf(value)),
        ),
      );
    }
    return list;
  }
}
