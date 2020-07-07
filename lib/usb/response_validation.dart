import 'package:flutter_usb/Response.dart';

extension ResponseValidation on Response {
  bool isSuccess() {
    return true;
  }

  bool isValidResponse() {
    return inData[0] == 1 && inData[1] == 0x20;
  }
}
