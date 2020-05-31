import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/usb/api/camera_settings.dart';
import 'package:sonyalphacontrol/usb/api/settings_item.dart';
import 'package:sonyalphacontrol/usb/api/sony_api.dart';
import 'package:sonyalphacontrol/usb/ids/setting_ids.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    //SonyApi.connectedCamera.startAutoUpdate();
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
    return ListTile(
      title: Text(getSettingsId(data.id).name),
      subtitle: Text(data.getValue()),
      onTap: () async {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return showSimpleDialog(data, context: context);
            });
      },
    );
  }

  Widget showSimpleDialog(SettingsItem data, {BuildContext context}) {
    final SimpleDialog dialog = new SimpleDialog(
        title: Text('Select ${data.getValue()} mode'),
        children: getOptions(data));
    return dialog;
  }

  List<Widget> getOptions(SettingsItem data) {
    List<Widget> list = new List();
    for (AcceptedValue value in data.getAcceptedValues()) {
      list.add(
        new SimpleDialogOption(
          onPressed: () {
            SonyApi.connectedCamera.setSettingsRaw(data.id, value.value);
          },
          child: Text(value.name),
        ),
      );
    }
    return list;
  }
}

/*
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
 */
