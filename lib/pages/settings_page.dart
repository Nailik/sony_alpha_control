import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterusb/Command.dart';
import 'package:flutterusb/Response.dart';
import 'package:flutterusb/flutter_usb.dart';
import 'package:http/http.dart' as http;
import 'package:sonyalphacontrol/api/commands.dart';
import 'package:sonyalphacontrol/api/settings.dart';
import 'package:sonyalphacontrol/ids/setting_ids.dart';
import 'package:sonyalphacontrol/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/ids/opcodes_ids.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    initSettings();
  }

  List<int> mainSettings = new List();
  List<int> subSettings = new List();
  List<Settings> settings = new List();

  Future<void> initSettings() async {
    var response =
        await FlutterUsb.sendCommand(Command(Commands.settingswhatavailable));
    analyzeSettingsAvailable(response);
    response = await FlutterUsb.sendCommand(
        Command(Commands.readcurrentsettings, outDataLength: 4000));
    analyzeSettings(response);

    setState(() {
      _initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: getList(),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0)),
                child: Text("reload"),
                color: Colors.blue,
                onPressed: () {
                  initSettings();
                },
              )
            ],
          )),
    );
  }

  Widget getList() {
    if (_initialized) {
      return ListView.builder(
          itemCount: settings.length,
          itemBuilder: (context, index) {
            return _buildRow(settings[index]);
          });
    } else {
      return Container();
    }
  }

  Widget _buildRow(Settings data) {
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
    }else{
      return ListTile(
        title: Text(getSettingsId(data.id).name),
        subtitle: Text(data.getValue())
      );
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

  analyzeSettingsAvailable(Response response) {
    if (!isValidResponse(response)) return;
    var bytes = response.getData().buffer.asByteData();

    int offset = 30;
    //30
    var unk = bytes.getInt16(offset, Endian.little); //200
    offset += 2; //bc we read uint16 (über response.index ...)
    //32
    var mainSettingsCount = bytes.getInt32(offset, Endian.little); //31
    offset += 4;
    for (int i = 0; i < mainSettingsCount; i++) {
      mainSettings.add(bytes.getUint16(offset, Endian.little)); //offset: 35/4
      offset += 2;
    }
    //last: 1024-8402 (31) || 20484-53792 (31)
    //offset 102
    var subSettingsCount = bytes.getUint32(offset, Endian.little);
    offset += 4;
    for (int i = 0; i < subSettingsCount; i++) {
      subSettings.add(bytes.getUint16(offset, Endian.little));
      offset += 2;
    }
  }

  analyzeSettings(Response response) {
    if (!isValidResponse(response)) return;
    var bytes = response.getData().buffer.asByteData();

    int offset = 30;
    var numSettings = bytes.getUint32(offset, Endian.little); //37
    offset += 4;
    var unk = bytes.getUint32(offset, Endian.little); //always 0?
    offset += 4;

    for (int i = 0; i < numSettings; i++) {
      var settingsId = bytes.getUint16(offset, Endian.little);
      offset += 2;

      var setting =
          settings.singleWhere((it) => it.id == settingsId, orElse: () => null);
      if (setting == null) {
        setting = new Settings();
        setting.id = settingsId;
        settings.add(setting);
      }

      //TODO check if i know this settings id
      var dataType = bytes.getUint16(offset, Endian.little);
      offset += 2;

      switch (dataType) {
        case 1:
          offset += 3;
          setting.value = bytes.getUint8(offset);
          offset++;
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            case 1:
              offset += 3;
              break;
            default:
              //unkown
              break;
          }

          break;
        case 2:
          offset += 3;
          setting.value = bytes.getUint8(offset);
          offset++;
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            case 1:
              offset += 3;
              break;
            case 2:
              var num = bytes.getUint16(offset, Endian.little);
              offset += 2;
              setting.acceptedValues.clear();
              for (int i = 0; i < num; i++) {
                setting.acceptedValues.add(bytes.getUint8(offset));
                offset++;
              }
              break;
            default:
              //unkown
              break;
          }

          break;
        case 3:
          offset += 4;
          setting.value = bytes.getUint16(offset, Endian.little);
          offset += 2;
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            case 1:
              offset += 6;
              break;
            case 2:
              var num = bytes.getUint16(offset, Endian.little);
              offset += 2;
              setting.acceptedValues.clear();
              for (int i = 0; i < num; i++) {
                setting.acceptedValues
                    .add(bytes.getUint16(offset, Endian.little));
                offset += 2;
              }
              break;
            default:
              //unkown
              break;
          }

          break;
        case 4:
          offset += 4;
          setting.value = bytes.getUint16(offset, Endian.little);
          offset += 2;
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            case 1:
              offset += 2;
              //response.ReadInt16();// Decrement value?
              offset += 2;
              //response.ReadInt16();// Iecrement value?
              offset += 2;
              break;
            case 2:
              var num = bytes.getUint16(offset, Endian.little);
              offset += 2;
              setting.acceptedValues.clear();
              for (int i = 0; i < num; i++) {
                setting.acceptedValues
                    .add(bytes.getUint16(offset, Endian.little));
                offset += 2;
              }
              break;
            default:
              //unkown
              break;
          }

          break;
        case 6:
          offset += 6;
          if (setting.hasSubValue()) {
            setting.value = bytes.getUint16(offset, Endian.little);
            offset += 2;
            setting.subValue = bytes.getUint16(offset, Endian.little);
            offset += 2;
          } else {
            setting.value = bytes.getUint32(offset, Endian.little);
            offset += 4;
          }
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            case 1:
              offset += 12;
              break;
            case 2:
              var num = bytes.getUint16(offset, Endian.little);
              offset += 2;
              setting.acceptedValues.clear();
              for (int i = 0; i < num; i++) {
                setting.acceptedValues
                    .add(bytes.getUint32(offset, Endian.little));
                offset += 4;
              }
              break;
            default:
              //unkown
              break;
          }

          break;
        default:
          //TODO log unkown
          break;
      }
    }
  }

  bool isValidResponse(Response response) {
    return response.inData != null &&
        response.inData.length > 2 &&
        response.inData[0] == 0x01 &&
        response.inData[1] == 0x20;
  }

  Widget showSimpleDialog(Settings data, {BuildContext context}) {
    final SimpleDialog dialog = new SimpleDialog(
      title: const Text('Select focus mode'),
      children: getOptions(data)
    );
    return dialog;
  }

  List<Widget> getOptions(Settings data) {
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
