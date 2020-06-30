import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/test_ui/test_page.dart';
import 'package:sonyalphacontrol/top_level_api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/sony_camera_device.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterUsb.enableLogger();
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
    await SonyApi.initialize();

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
                  setState(() {
                    /*reload*/
                  });
                },
              )
            ],
          )),
    );
  }

  Widget deviceList() {
    if (_initialized) {
      return StreamBuilder<List<SonyCameraDevice>>(
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
        stream: SonyApi.getDevices(new Duration(seconds: 5)),
      );
    }
    return Container();
  }

  Widget getListTile(SonyCameraDevice device, BuildContext context) {
    return ListTile(
      title: Text(device.name),
      subtitle: Text("huhu"),
      onTap: () async {
       // await SonyApi.connectToCamera(device);
       // await SonyApi.api.updateSettings(device);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TestsPage(device: device)),
        );
      },
    );
  }
}
