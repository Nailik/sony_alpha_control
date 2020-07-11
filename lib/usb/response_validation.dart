import 'package:flutter_usb/Response.dart';

extension ResponseValidation on Response {
  bool isSuccess() {
    return true;
  }

  bool isValidResponse() {
    if(inData.length == 0){
      return true;
    }
    if(inData.length == 1){
      return inData[0] == 1;
    }
    return inData[0] == 1 && inData[1] == 0x20;
  }
}
