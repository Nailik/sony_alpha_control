import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutterusb/Command.dart';
import 'package:flutterusb/Response.dart';
import 'package:flutterusb/flutter_usb.dart';
import 'package:sonyalphacontrol/usb/api/commands.dart';
import 'package:sonyalphacontrol/usb/api/settings_item.dart';

class CameraSettings extends ChangeNotifier {
  List<int> mainSettings = new List();
  List<int> subSettings = new List();
  List<SettingsItem> settings = new List();

  update() async {
    var response =
        await FlutterUsb.sendCommand(Command(Commands.settingswhatavailable));
    analyzeSettingsAvailable(response);
    response = await FlutterUsb.sendCommand(
        Command(Commands.readcurrentsettings, outDataLength: 4000));
    analyzeSettings(response);

    notifyListeners();
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
        setting = new SettingsItem();
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
}
