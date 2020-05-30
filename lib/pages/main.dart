import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterusb/UsbDevice.dart';
import 'package:flutterusb/flutter_usb.dart';
import 'package:sonyalphacontrol/api/sony_api.dart';
import 'package:sonyalphacontrol/pages/settings_page.dart';

void main() async {
  FlutterUsb.enableLogger();
  WidgetsFlutterBinding.ensureInitialized();

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

  Future<void> initPlatformState() async {
    await FlutterUsb.initializeUsb;

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
      return FutureBuilder<List<UsbDevice>>(
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
        future: FlutterUsb.getUsbDevices,
      );
    }
    return Container();
  }

  Widget getListTile(UsbDevice device, BuildContext context) {
    return ListTile(
      title: Text(device.name),
      subtitle: Text(device.description),
      onTap: () async {
        await SonyApi.connectToCamera(device);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      },
    );
  }
}
