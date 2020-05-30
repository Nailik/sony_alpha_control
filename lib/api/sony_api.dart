import 'package:flutterusb/Command.dart';
import 'package:flutterusb/UsbDevice.dart';
import 'package:flutterusb/flutter_usb.dart';
import 'package:sonyalphacontrol/api/sony_camera.dart';

import 'commands.dart';

class SonyApi{

  static SonyCamera connectedCamera;

  static connectToCamera(UsbDevice device) async{
    await FlutterUsb.connectToUsbDevice(device);
    await FlutterUsb.sendCommand(Command(Commands.Connect));
    connectedCamera = SonyCamera(device);
  }

}

/*
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
 */