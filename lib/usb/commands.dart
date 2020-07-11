import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_usb/Command.dart';
import 'package:flutter_usb/Response.dart';
import 'package:flutter_usb/flutter_usb.dart';
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';

class Commands {
  static var index = 1;

//omost often used values as default
  static SonyCommand getCommandSetting(SettingsId settingsId,
      {OpCodeId opCodeId = OpCodeId.SubSetting,
      int value1 = 0,
      int value2 = 0,
      int value1DataSize = 2,
      int value2DataSize = 0,
      int outDataLength = 1024}) {
    if (Platform.isWindows) {
      var length = 40;
      //if we have a second value the command needs to be little bit longer
      if (value2DataSize != 0) {
        length += 2;
      }
      if (opCodeId == OpCodeId.Connect && settingsId == SettingsId.Connect) {
        length = 38;
      }

      Uint8List list = CommandT.createCommand(length);
      //wia is used
      list.writeUInt16(opCodeId.usbValue);
      list.goTo(10);
      list.writeUInt16(settingsId.usbValue);
      list.goTo(30);
      if (settingsId == SettingsId.Connect) {
        list.writeUInt8(3);
      } else {
        list.writeUInt8(1);
      }
      list.goTo(34);
      if (settingsId == SettingsId.AvailableSettings ||
          settingsId == SettingsId.CameraInfo ||
          settingsId == SettingsId.Connect) {
        list.writeUInt8(3);
      } else {
        list.writeUInt8(4);
      }
      list.goTo(38);

      addValueToCommand(list, value1, value1DataSize);
      addValueToCommand(list, value2, value2DataSize);

      return SonyCommand(Command(list, outDataLength: outDataLength));
    } else if (Platform.isAndroid) {

      Uint8List list = CommandT.createCommand(16);
      //TODO not always 2 lists
      //0000   10 00 00 00 01 00 07 92 08 00 00 00 07 50 00 00
      //0000   0e 00 00 00 02 00 07 92 08 00 00 00 01 00

      //0000   10 00 00 00 01 00 05 92 09 00 00 00 04 50 00 00
      //0000   0e 00 00 00 02 00 05 92 09 00 00 00 02 00

      //0000   10 00 00 00 01 00 05 92 0a 00 00 00 04 50 00 00
      //0000   0e 00 00 00 02 00 05 92 0a 00 00 00 10 00
      //maxbe not two lists when only one value?

      //2 lists
      //Uint8List list = CommandT.createCommand(10);
      //start with length
      list.writeUInt8(0x10);
      //skip 3
      list.goTo(4);
      //write part
      list.writeUInt8(1); //TODO maybe value?!
      //skip 1
      list.writeUInt8(0);
      //write opcode
      list.writeUInt16(opCodeId.usbValue);
      //write index
      list.writeUInt8(index);
      //skip 3
      list.goTo(12);
      //write settings id
      list.writeUInt16(settingsId.usbValue);

      var length = 0x0e;
      if (value2DataSize != 0) {
        length += 2;
      }

      if(value1DataSize == 0 && value2DataSize == 0){
        //only one command, eg when reading settings
        return SonyCommand(Command(list, outDataLength: outDataLength));
      }

      Uint8List list2 = CommandT.createCommand(16);
      //start with length
      if (value2DataSize != 0) {
        list2.writeUInt8(length);
      } else {
        list2.writeUInt8(length);
      }
      //skip 3
      list2.goTo(4);
      //write part
      list2.writeUInt8(2);
      //skip 1
      list2.writeUInt8(0);
      //write opcode
      list2.writeUInt16(opCodeId.usbValue);
      //write index
      list2.writeUInt8(index);
      //skip 3
      list2.goTo(12);
      //write settings value
      addValueToCommand(
          list2, value1, value1DataSize); //write 8 or 16 bit value
      addValueToCommand(
          list2, value2, value2DataSize); //write max 16 bit value at moment

      return SonyCommand(Command(list),
          command2: Command(list2, outDataLength: outDataLength));
    }

    return null;
  }

  static addValueToCommand(Uint8List list, int value, int valueDataSize) {
    switch (valueDataSize) {
      case 1:
        list.writeUInt8(value);
        break;
      case 2:
        list.writeUInt16(value);
        break;
      case 4:
        list.writeUInt32(value);
        break;
    }
  }

  //0000   10 00 00 00 01 00 08 10 51 06 00 00 01 c0 ff ff //10 09 getImageInfo //photo info c0 01
  //0000   10 00 00 00 01 00 08 10 4e 06 00 00 02 c0 ff ff //10 08 getImageInfo //LiveViewInfo c0 02
  //0000   10 00 00 00 01 00 09 10 4d 06 00 00 01 c0 ff ff //10 09 getImageData //photo info c0 01

  //0000   10 00 00 00 01 00 09 10 52 06 00 00 01 c0 ff ff //10 09 getImageData //photo info c0 01

  static SonyCommand getImageCommand(bool liveView, bool info,
      {int imageSizeInBytes = 1024}) {
    if (imageSizeInBytes != 1024) {
      imageSizeInBytes += 32;
    }
    // Should be only 29 bytes of extra space required, add a little extra just in case
    //TODO if not 1024
    OpCodeId opcode = info ? OpCodeId.GetImageInfo : OpCodeId.GetImageData;
    SettingsId settingsId =
        liveView ? SettingsId.LiveViewInfo : SettingsId.PhotoInfo;

    Uint8List list = CommandT.createCommand(40);
    list.writeUInt16(opcode.usbValue);
    list.goTo(10);
    list.writeUInt16(settingsId.usbValue);
    list.writeUInt8(0xFF);
    list.writeUInt8(0xFF);
    list.goTo(30);
    list.writeUInt8(1);
    list.goTo(34);
    list.writeUInt8(3);

    return SonyCommand(Command(list, outDataLength: imageSizeInBytes));
  }
}

extension CommandT on Uint8List {
  static int position = 0;

  static Uint8List createCommand(int f) {
    Commands.index++;

    position = 0;
    return Uint8List(f);
  }

  writeUInt8(value) {
    buffer.asByteData().setUint8(position, value);
    position++;
  }

  writeUInt16(value) {
    buffer.asByteData().setUint16(position, value, Endian.little);
    position += 2;
  }

  writeUInt32(value) {
    buffer.asByteData().setUint16(position, value, Endian.little);
    position += 4;
  }

  goTo(newPosition) {
    position = newPosition;
  }

  finishCommand() {
    position = 0;
  }
}

class SonyCommand {
  Command command1;
  Command command2;

  SonyCommand(this.command1, {this.command2});

  Future<Response> send() async {
    print("send SonyCommand two? ${command2 != null}");
    if (command2 != null) {
      command1.outDataLength = 0;
      await FlutterUsb.sendCommand(command1);
      return await FlutterUsb.sendCommand(command2);
    }
    return await FlutterUsb.sendCommand(command1);
  }
}
