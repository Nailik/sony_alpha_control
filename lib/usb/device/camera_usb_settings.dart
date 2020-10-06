import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_usb/Response.dart';
import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/item_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/white_balance_ab_ids.dart';

import '../commands/usb_commands.dart';

class CameraUsbSettings extends CameraSettings {
  List<int> mainSettings = new List();
  List<int> subSettings = new List();

  @override
  Future<bool> update() async {
    var response = await UsbCommands.getCommandSetting(
            ItemId.AvailableSettings,
            opCodeId: OpCodeId.SettingsList,
            value1: 0,
            value2: 0,
            value1DataSize: 0,
            value2DataSize: 0)
        .send();
    //1, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    // 200, 0, 31, 0, 0, 0, 4, 80, 5, 80, 7, 80, 10

    //on android
    //98, 0, 0, 0, 2, 0, 2, 146, 4, 0, 0, 0,
    //299...
    analyzeSettingsAvailable(response);

    response = await UsbCommands.getCommandSetting(ItemId.CameraInfo,
            opCodeId: OpCodeId.Settings,
            value1: 0,
            value2: 0,
            value1DataSize: 0,
            value2DataSize: 0,
            outDataLength: 4000)
        .send();

    //1, 32, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    //37, 0, 0, 0, 0, 0, 0, 0, 4, 80, 2, 0, 1, 1, 2, 16, 2, 5, 0,
    try {
      analyzeSettings(response);
    } catch (e) {
      print(e);
    }

    notifyListeners();

    return true;
  }

  analyzeSettingsAvailable(Response response) {
    if (!isValidResponse(response)) return;
    var bytes = Uint8List.fromList(response.inData).buffer.asByteData();

    int offset = 30; //TODO maybe only wia offset?
    if (Platform.isAndroid) {
      offset = 12;
    }
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
    // if (!isValidResponse(response)) return;

    var byteList = response.inData.toByteList();
    var bytes = byteList.buffer.asByteData();

    int offset = 30; //TODO maybe only wia offset?
    if (Platform.isAndroid) {
      offset = 12;
    }
    var numSettings = bytes.getUint32(offset, Endian.little); //37
    offset += 4;
    var unk = bytes.getUint32(offset, Endian.little); //always 0?
    offset += 4;

    for (int i = 0; i < numSettings; i++) {
      var settingsId = bytes.getUint16(offset, Endian.little);
      offset += 2;

      ItemId settingsIdEnum = SettingsIdExtension.getIdFromUsb(settingsId);

      SettingsItem setting = getItem(settingsIdEnum);
      if (setting == null) {
        print("ERROR ******");
      }

      //TODO check if i know this settings id
      var dataType = bytes.getUint16(offset, Endian.little);
      offset += 2;

      switch (dataType) {
        case 1:
          offset += 3;

          setting.updateItem(setting.fromUsb(bytes.getUint8(offset)),
              setting.available, setting.supported);

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
          setting.updateItem(setting.fromUsb(bytes.getUint8(offset)),
              setting.available, setting.supported);
          offset++;
          var subDataType = bytes.getUint8(offset);
          offset++;
          switch (subDataType) {
            //white balance ab //-7 + 7 (0,5)
            case 1:
              var min = bytes.getUint8(offset);
              offset += 1;
              var max = bytes.getUint8(offset);
              offset += 1;
              var steps = bytes.getUint8(offset); //??
              offset += 1;

              if (setting.itemId == ItemId.WhiteBalanceAB ||
                  setting.itemId == ItemId.WhiteBalanceGM) {
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

                    //TODO
                    //setting.updateItem(setting.value, setting.subValue, setting.available, setting.supported);
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
              //TODO
              // setting.updateItem(setting.value, setting.subValue, setting.available, setting.supported);
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
          setting.updateItem(
              setting.fromUsb(bytes.getInt16(offset, Endian.little)),
              setting.available,
              setting.supported);

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
          setting.updateItem(
              setting.fromUsb(bytes.getUint16(offset, Endian.little)),
              setting.available,
              setting.supported);

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

              if (setting.itemId == ItemId.WhiteBalanceColorTemp) {
                //extra
                //TODO
                //setting.updateItem(setting.value, setting.subValue, setting.available, setting.supported);
                for (int i = min; i <= max; i += steps) {
                  setting.available.add(setting.fromUsb(i));
                }
              }
              break;
            case 2:
              var num = bytes.getUint16(offset, Endian.little);
              offset += 2;
              //TODO
              //setting.updateItem(setting.value, setting.subValue, setting.available, setting.supported);
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
            var value = bytes.getUint16(offset, Endian.little);
            offset += 2;
            var subValue = bytes.getUint16(offset, Endian.little);
            offset += 2;
            //TODO  setting.fromUsb(subValue), for sub value?
            setting.updateItem(setting.fromUsb(value, subValue: subValue),
                setting.available, setting.supported);
          } else {
            setting.updateItem(
                setting.fromUsb(bytes.getUint32(offset, Endian.little)),
                setting.available,
                setting.supported);
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
