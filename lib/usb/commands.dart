import 'dart:typed_data';

import 'package:flutterusb/Command.dart';
import 'package:sonyalphacontrol/top_level_api/ids/focus_mode_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/opcodes_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';

class Commands {
  static var Connect = [
    0x01,
    0x92,
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
    0x03,
    0x00,
    0x00,
    0x00,
    0x03,
    0x00,
    0x00,
    0x00
  ];

  static var settingswhatavailable = [
    0x02,
    0x92,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0xC8,
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

  static var readcurrentsettings = [
    0x09,
    0x92,
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
    0x03,
    0x00,
    0x00,
    0x00
  ];


  static Uint8List getCommandMainSettingI32(SettingsId settingsId, var value) {
    return getCommandSettingI32(OpCodeId.MainSetting, settingsId, value);
  }

  static Uint8List getCommandSettingI32(
      OpCodeId mainSetting, SettingsId settingsId, value) {
    return getCommandSetting(mainSetting, settingsId, value, 0, 4, 0);
  }

  static Uint8List getCommandMainSettingI16(SettingsId settingsId, var value) {
    return getCommandSettingI16(OpCodeId.MainSetting, settingsId, value);
  }

  static Uint8List getCommandSubSettingU8(SettingsId settingsId, var value) {
    return getCommandSettingU8(OpCodeId.SubSetting, settingsId, value);
  }

  static Uint8List getCommandSettingU8(
      OpCodeId mainSetting, SettingsId settingsId, value) {
    return getCommandSetting(mainSetting, settingsId, value, 0, 1, 0);
  }

  static Uint8List getCommandSubSettingI16(SettingsId settingsId, var value) {
    return getCommandSettingI16(OpCodeId.SubSetting, settingsId, value);
  }

  static Uint8List getCommandMainSettingI16_2(SettingsId settingsId, var value1, var value2) {
    return getCommandSetting(OpCodeId.MainSetting, settingsId, value1, value2, 2, 2);
  }

  static Uint8List getCommandSettingI16(
      OpCodeId mainSetting, SettingsId settingsId, value) {
    return getCommandSetting(mainSetting, settingsId, value, 0, 2, 0);
  }

  static Uint8List getCommandSetting(OpCodeId opCodeId, SettingsId settingsId,
      int value1, int value2, int value1DataSize, int value2DataSize) {
    Uint8List list = CommandT.createCommand(40);
    list.writeUInt16(opCodeId.value);
    list.goTo(10);
    list.writeUInt16(settingsId.value);
    list.goTo(30);
    list.writeUInt8(1);
    list.goTo(34);
    list.writeUInt8(4);
    list.goTo(38);

    addValueToCommand(list, value1, value1DataSize);
    addValueToCommand(list, value2, value2DataSize);

    return list;
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

  static Command getImageCommand(bool liveView, bool info,
      {double imageSizeInBytes = 1024}) {
    if(imageSizeInBytes != 1024){
      imageSizeInBytes += 32;
    }
    // Should be only 29 bytes of extra space required, add a little extra just in case
    //TODO if not 1024
    OpCodeId opcode = info ? OpCodeId.GetImageInfo : OpCodeId.GetImageData;
    SettingsId settingsId =
        liveView ? SettingsId.LiveViewInfo : SettingsId.PhotoInfo;

    Uint8List list = CommandT.createCommand(40);
    list.writeUInt16(opcode.value);
    list.goTo(10);
    list.writeUInt16(settingsId.value);
    list.writeUInt8(0xFF);
    list.writeUInt8(0xFF);
    list.goTo(30);
    list.writeUInt8(1);
    list.goTo(34);
    list.writeUInt8(3);

    return Command(list, outDataLength: imageSizeInBytes); //TODO image size in bytes
  }
}

extension CommandT on Uint8List {
  static int position = 0;

  static Uint8List createCommand(int f) {
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
