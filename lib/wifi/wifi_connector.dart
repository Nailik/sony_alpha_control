// find the address
/*


 */
import 'dart:io';

class WifiConnector {
  static var SSDP_PORT = 1900;
  static var SSDP_MX = 1;
  static var SSDP_ADDRESS = "239.255.255.250";
  static var SSDP_ST = "ssdp:all";

  static var request =
      "M-SEARCH * HTTP/1.1\r\nHOST: $SSDP_ADDRESS:$SSDP_PORT\r\nMAN: \"ssdp:discover\"\r\nMX: $SSDP_MX\r\nST: $SSDP_ST\r\n\r\n";

  static var socket;

  static Future<bool> ssdpRequest() async {
    if (socket == null) { //when not on camera cannot access?
      socket = await RawDatagramSocket.bind(InternetAddress("192.168.122.131"), 0);
      socket.forEach((RawSocketEvent event) {
        if (event == RawSocketEvent.read) {
          Datagram dg = socket.receive();
          print(new String.fromCharCodes(dg.data));
        }
      });
    }
    socket.send(request.codeUnits, InternetAddress(SSDP_ADDRESS), SSDP_PORT);
    //M-SEARCH * HTTP/1.1
    //HOST: 239.255.255.250:1900
    //MAN: "ssdp:discover"
    //MX: 1
    //ST: ssdp:all
  }
}
