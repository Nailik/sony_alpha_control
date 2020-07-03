import 'dart:typed_data';

import 'package:flutter_usb/Command.dart';
import 'package:flutter_usb/Response.dart';
import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/top_level_api/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';
import 'package:sonyalphacontrol/top_level_api/settings_item.dart';

import 'commands.dart';

class CameraUsbSettings extends CameraSettings {
  List<int> mainSettings = new List();
  List<int> subSettings = new List();

  @override
  Future<bool> update() async {
    var response =
        await FlutterUsb.sendCommand(Command(Commands.settingswhatavailable));
    analyzeSettingsAvailable(response);
    response = await FlutterUsb.sendCommand(
        Command(Commands.readcurrentsettings, outDataLength: 4000));
    analyzeSettings(response);

    notifyListeners();

    return true;
  }

  analyzeSettingsAvailable(Response response) {
    if (!isValidResponse(response)) return;
    var bytes = response.inData.toByteList().asByteData();

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
    var byteList = response.inData.toByteList();
    var bytes = byteList.buffer.asByteData();

    int offset = 30;
    var numSettings = bytes.getUint32(offset, Endian.little); //37
    offset += 4;
    var unk = bytes.getUint32(offset, Endian.little); //always 0?
    offset += 4;

    for (int i = 0; i < numSettings; i++) {
      var settingsId = bytes.getUint16(offset, Endian.little);
      offset += 2;

      SettingsItem setting = settings.singleWhere(
          (it) => it.settingsId.usbValue == settingsId,
          orElse: () => null);
      if (setting == null) {
        setting = new SettingsItem(getSettingsId(settingsId));
        settings.add(setting);
      }

      if (setting.settingsId.name == "ISO") {
        print(setting.settingsId.name);
      } else {
        print("other");
      }
      //TODO check if i know this settings id
      var dataType = bytes.getUint16(offset, Endian.little);
      offset += 2;

      switch (dataType) {
        case 1:
          offset += 3;
          setting.value = setting.fromUsb(bytes.getUint8(offset));
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
          setting.value = setting.fromUsb(bytes.getUint8(offset));
          offset++;
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            //white balance ab //-7 + 7 (0,5)
            case 1:
              //TODO white balance ab
              //min = 180
              //max = 1600
              var min = bytes.getUint8(offset);
              offset += 1;
              var max = bytes.getUint8(offset);
              offset += 1;
              var steps = bytes.getUint8(offset); //??
              offset += 1;

              if (setting.settingsId == SettingsId.WhiteBalanceAB ||
                  setting.settingsId == SettingsId.WhiteBalanceGM) {
                bool include = false;
                WhiteBalanceAbId.values.forEach((element) {
                  //start
                  if (!include) {
                    if (element.usbValue == min) {
                      include = true;
                    }
                  }
                  //end
                  if (include) {
                    //add
                    setting.available
                        .insert(0, setting.fromUsb(element.usbValue));
                    if (element.usbValue == max) {
                      include = false;
                    }
                  }
                });
              }

              break;
            case 2:
              var num = bytes.getUint16(offset, Endian.little);
              offset += 2;
              setting.available.clear();
              for (int i = 0; i < num; i++) {
                setting.available.add(setting.fromUsb(bytes.getUint8(offset)));
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
          setting.value =
              setting.fromUsb(bytes.getInt16(offset, Endian.little));
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
              setting.available.clear();
              for (int i = 0; i < num; i++) {
                setting.available.add(
                    setting.fromUsb(bytes.getInt16(offset, Endian.little)));
                offset += 2;
              }
              setting.available
                  .sort((a, b) => a.usbValue.compareTo(b.usbValue));
              break;
            default:
              //unkown
              break;
          }

          break;
        case 4: //White blanace color temp
          offset += 4;
          setting.value =
              setting.fromUsb(bytes.getUint16(offset, Endian.little));
          var nn = bytes.getUint16(offset, Endian.little);

          offset += 2;
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            case 1:
              var min = bytes.getUint16(offset, Endian.little);
              offset += 2;
              var max = bytes.getUint16(offset, Endian.little);
              offset += 2;
              var steps = bytes.getUint16(offset, Endian.little);
              offset += 2;

              if (setting.settingsId == SettingsId.WhiteBalanceColorTemp) {
                //extra
                for (int i = min; i <= max; i += steps) {
                  setting.available.add(setting.fromUsb(i));
                }
              }
              break;
            case 2:
              var num = bytes.getUint16(offset, Endian.little);
              offset += 2;
              setting.available.clear();
              for (int i = 0; i < num; i++) {
                setting.available.add(
                    setting.fromUsb(bytes.getUint16(offset, Endian.little)));
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
            setting.value =
                setting.fromUsb(bytes.getUint16(offset, Endian.little));
            offset += 2;
            setting.subValue =
                setting.fromUsb(bytes.getUint16(offset, Endian.little));
            offset += 2;
            if (setting.subValue.usbValue == 1 &&
                setting.settingsId == SettingsId.ShutterSpeed) {
              setting.value = ShutterSpeedValue(setting.value.usbValue.toDouble());
            }else{
              setting.value = ShutterSpeedValue(setting.subValue.usbValue.toDouble() / 10.0);
            }
          } else {
            setting.value =
                setting.fromUsb(bytes.getUint32(offset, Endian.little));
            offset += 4;
          }
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            case 1:
              //TODO?
              var min = bytes.getUint32(offset, Endian.little);
              offset += 4;
              var max = bytes.getUint32(offset, Endian.little);
              offset += 4;
              var steps = bytes.getUint32(offset, Endian.little);
              offset += 4;
              break;
            case 2:
              var num = bytes.getUint16(offset, Endian.little);
              offset += 2;
              setting.available.clear();
              for (int i = 0; i < num; i++) {
                setting.available.add(
                    setting.fromUsb(bytes.getUint32(offset, Endian.little)));
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
