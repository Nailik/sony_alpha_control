import 'flutter_usb.dart';

class Command {
  int outDataLength;
  List<int> inData;
  int sendTimeout;
  int receiveTimeout;
  List<int>? endIdentifier; //when this comes in it stops reading

  Command(this.inData,
      {this.outDataLength = 1024, this.sendTimeout = -1, this.receiveTimeout = -1, this.endIdentifier}) {
    if (sendTimeout == -1) {
      sendTimeout = FlutterUsb.sendTimeout;
    }
    if (receiveTimeout == 1) {
      receiveTimeout = FlutterUsb.receiveTimeout;
    }
  }

  List<dynamic> get commandList {
    List<dynamic> list = List.empty();
    list.add(outDataLength);
    list.add(inData.toByteList());
    list.add(sendTimeout);
    list.add(receiveTimeout);
    list.add(endIdentifier);
    return list;
  }
}
