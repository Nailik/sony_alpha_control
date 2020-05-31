import 'package:flutterusb/Command.dart';
import 'package:flutterusb/UsbDevice.dart';
import 'package:flutterusb/flutter_usb.dart';
import 'package:sonyalphacontrol/usb/api/sony_camera.dart';

import '../usb/api/commands.dart';

class SonyApi{

  static SonyCamera connectedCamera;

  static connectToCamera(UsbDevice device) async{
    await FlutterUsb.connectToUsbDevice(device);
    await FlutterUsb.sendCommand(Command(Commands.Connect));
    connectedCamera = SonyCamera(device);
  }

}
