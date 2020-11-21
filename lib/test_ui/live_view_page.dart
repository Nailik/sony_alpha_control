import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/sonyalphacontrol.dart';
import 'package:sonyalphacontrol/wifi/api/live_view.dart';

class LiveViewPage extends StatefulWidget {
  final SonyCameraDevice? device;

  const LiveViewPage(this.device) : super();

  @override
  _LiveViewPageState createState() => _LiveViewPageState(device);
}

class _LiveViewPageState extends State<LiveViewPage> {
  final SonyCameraDevice? device;
  late LiveView live;

  _LiveViewPageState(this.device) {
    live = LiveView(device as SonyCameraWifiDevice?);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('LiveView'),
            ),
            body: Container(
              child: StreamBuilder<Payload>(
                  stream: live.streamLiveView(),
                  builder: (BuildContext context, AsyncSnapshot<Payload> snapshot) {
                    if (snapshot.hasData == true) {
                      return Image(
                          image: (snapshot.data as LiveViewPayload).image, fit: BoxFit.cover, gaplessPlayback: true);
                    } else {
                      return Text("loading");
                    }
                  }),
            )));
  }
}
