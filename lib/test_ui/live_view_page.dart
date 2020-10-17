import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sonyalphacontrol/test_ui/live_view_analyzer.dart';

class LiveViewPage extends StatefulWidget {
  @override
  _LiveViewPageState createState() => _LiveViewPageState();
}

class _LiveViewPageState extends State<LiveViewPage> {

  LiveViewAnalyzer live = LiveViewAnalyzer();

  //this image will store the memory image
  //TODO better draw on canvas?

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    live.start();
  }

  StreamSubscription videoStream;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                title: const Text('LiveView'),
            ),
            body: Container(
                child: ValueListenableBuilder<MemoryImage>(
                    valueListenable: live.memoryImage,
                    builder: (context, value, child) {
                      if (value == null) {
                        return Text("empty");
                      } else {
                        return Image(image: value, fit: BoxFit.cover, gaplessPlayback: true);
                      }
                    }),
            )));
  }
}
