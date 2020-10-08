import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/test_ui/test_page.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterUsb.enableLogger(maxLogLengthNew: 42);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initPlatformState() async {

    await SonyApi.initialize(usb: false, wifi: true);

    setState(() {
      _initialized = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
            leading: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
          ),
          body: deviceList(),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0)),
                child: Text("reload"),
                color: Colors.blue,
                onPressed: () {
                  SonyApi.getDevices(new Duration(seconds: 10));
                },
              )
            ],
          )),
    );
  }

  Widget deviceList() {
    if (_initialized) {
      return StreamBuilder<List<SonyCameraDevice>>(
        stream: SonyApi.getDevices(new Duration(seconds: 10)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return getListTile(snapshot.data[index], context);
              },
            );
          } else {
            return Container();
          }
        },
      );
    }
    return Container();
  }

  Widget getListTile(SonyCameraDevice device, BuildContext context) {
    return ListTile(
      title: Text(device.name),
      subtitle: Text("huhu"),
      onTap: () async {
        await SonyApi.connectCamera(device);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TestsPage(device: device)),
        );
      },
    );
  }
}
