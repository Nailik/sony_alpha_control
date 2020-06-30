import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestsPage extends StatefulWidget {
  @override
  _TestsPageState createState() => _TestsPageState();
}

class _TestsPageState extends State<TestsPage> {
  @override
  Widget build(BuildContext context) {
    //SonyApi.connectedCamera.startAutoUpdate();
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          getRow1(),
          getRow2(),
          getRow3(),
          getRow4(),
          getRow5(),
        ],
      )),
    );
  }

  Widget getRow1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Text("aspect"),Text("image size"), Text("file format"), Text("battery")],
    );
  }

  Widget getRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Text("capture mode"),Text("cont shooting"), Text("focus"), Text("focus field"), Text("post production (effect)")],
    );
  }

  Widget getRow3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Text("metering mode"),Text("white balance"),Text("dro"),Text("effect")],
    );
  }

  Widget getRow4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Text("shutter"),Text("f"),Text("ev"),Text("iso")],
    );
  }

  Widget getRow5() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Text("other")],
    );
  }
}
