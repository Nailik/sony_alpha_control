import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterusb/Command.dart';
import 'package:flutterusb/Response.dart';
import 'package:flutterusb/UsbDevice.dart';
import 'package:flutterusb/flutter_usb.dart';
import 'package:sonyalphacontrol/pages/settings_page.dart';

import '../api/commands.dart';

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
    // TODO: implement initState
    super.initState();
    initPlatformState();
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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await FlutterUsb.initializeUsb;

    setState(() {
      _initialized = true;
    });
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
        await FlutterUsb.connectToUsbDevice(device);
        await FlutterUsb.sendCommand(Command(Commands.Connect));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
      },
    );
  }

  windowsTest() async {
    //connect
    //
    // await FlutterUsb.sendCommand(Command(Commands.requestimageinfo));
    // await FlutterUsb.sendCommand(Command(Commands.requestimage));
  }

  liveViewTest() async {
    if (Platform.isWindows) {
      //request image information (only once?)
      var arr = [
        //0x08 -> image info (eg size (for liveview))
        0x08, 16, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00,
        0x02, 192, 0xFF, 255, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00,
        0x01, 0x00, 0x00, 0x00, 0x03,
        0x00, 0x00, 0x00
      ];
      Response response = await FlutterUsb.sendCommand(Command(arr));
      //analyze image

      //position 32: ReadInt16 -> anzahl bilder
      //position : ReadInt32 -> imageInfoUnk
      //position : ReadInt32 -> imageSizeInBytes
      //position82 : ReadByte -> imageName

      //request image
      //0x09 -> image data (image itself)
      var arr2 = [
        0x09,
        16,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x02,
        192,
        255,
        255,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x01,
        0x00,
        0x00,
        0x00,
        0x03,
        0x00,
        0x00,
        0x00
      ];
      response = await FlutterUsb.sendCommand(Command(arr2));

      //position 30: ReadInt32 -> unkBufferSize
      //position : ReadInt32 -> liveViewBufferSize
      //position : unkBufferSize-8 -> unkBuff
      //position : (remaining) -> buff (image data)
    }

    sendGetLiveView() {}
  }
}
