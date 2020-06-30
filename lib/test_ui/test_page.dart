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
              getFunctionRow(SettingsId.FileFormat),
              getFunctionRow(SettingsId.WhiteBalance),
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
          onTap: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return showSimpleDialog(settingsItem, context: context);
                });
          }),
    );
  }

  Widget showSimpleDialog(SettingsItem settingsItem, {BuildContext context}) {
    final SimpleDialog dialog = new SimpleDialog(
        title: Text('Select ${settingsItem.value} mode'),
        children: getOptions(settingsItem));
    return dialog;
  }

  List<Widget> getOptions(SettingsItem data) {
    List<Widget> list = new List();
    for (var value in data.available) {
      list.add(
        new SimpleDialogOption(
          onPressed: () {
            SonyApi.setSettingsRaw(data.settingsId, value.value);
          },
          child: Text(data.getNameOf(value)),
        ),
      );
    }
    return list;
  }
}
