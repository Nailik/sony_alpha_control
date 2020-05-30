import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterusb/Command.dart';
import 'package:flutterusb/flutter_usb.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/api/camera_settings.dart';
import 'package:sonyalphacontrol/api/commands.dart';
import 'package:sonyalphacontrol/api/settings_item.dart';
import 'package:sonyalphacontrol/api/sony_api.dart';
import 'package:sonyalphacontrol/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/ids/setting_ids.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    SonyApi.connectedCamera.startAutoUpdate();
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: ChangeNotifierProvider<CameraSettings>(
              create: (context) => SonyApi.connectedCamera.cameraSettings,
              child: Consumer<CameraSettings>(
                builder: (context, model, _) => getList(),
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
                  SonyApi.connectedCamera.updateSettings();
                },
              )
            ],
          )),
    );
  }

  Widget getList() {
    return ListView.builder(
        itemCount: SonyApi.connectedCamera.cameraSettings.settings.length,
        itemBuilder: (context, index) {
          return _buildRow(
              SonyApi.connectedCamera.cameraSettings.settings[index]);
        });
  }

  Widget _buildRow(SettingsItem data) {
    var id = getSettingsId(data.id);
    if (id == SettingsId.FocusMode) {
      //get all possible values
      var subtitle = "";
      subtitle = getFocusModeId(data.value).name;
      return ListTile(
        title: Text(id.name),
        subtitle: Text(subtitle),
        onTap: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showSimpleDialog(data, context: context);
              });

          ///await FlutterUsb.sendCommand(Command(Commands.getFocusModeCommand(
          //    OpCode.SubSetting, SettingsId.FocusMode, FocusMode.DMF)));
          // initSettings();
        },
      );
    } else {
      return ListTile(
          title: Text(getSettingsId(data.id).name),
          subtitle: Text(data.getValue()));
    }
    return ListTile(title: Text(id.name), subtitle: Text(""));
  }

  Future<File> _downloadFile(String url, String filename) async {
    _downloadFile(
        'https://kilian-eller.de/wp-content/uploads/2020/05/DSC1723-1-scaled.jpg',
        "DSC171.jpg");
    http.Client client = new http.Client();
    var req = await client.get(Uri.parse(url));
    var bytes = req.bodyBytes;
    String dir = "Y:/Bilder/DSLR/HotFolder";
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  Widget showSimpleDialog(SettingsItem data, {BuildContext context}) {
    final SimpleDialog dialog = new SimpleDialog(
        title: const Text('Select focus mode'), children: getOptions(data));
    return dialog;
  }

  List<Widget> getOptions(SettingsItem data) {
    List<Widget> list = new List();
    for (AcceptedValue value in data.getAcceptedValues()) {
      list.add(
        new SimpleDialogOption(
          onPressed: () {
            FlutterUsb.sendCommand(Command(Commands.getFocusModeCommand(
                OpCodeId.SubSetting,
                SettingsId.FocusMode,
                getFocusModeId(value.value))));
          },
          child: Text(value.name),
        ),
      );
    }
    return list;
  }
}
