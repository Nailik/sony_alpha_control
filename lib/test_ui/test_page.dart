import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/sonyalphacontrol.dart';
import 'package:sonyalphacontrol/test_ui/live_view_page.dart';

class TestsPage extends StatefulWidget {
  final SonyCameraDevice device;

  const TestsPage({Key key, this.device}) : super(key: key);

  @override
  TestsPageState createState() => TestsPageState(device);
}

class TestsPageState extends State<TestsPage> {
  static ValueNotifier<String> path = ValueNotifier("Empty");

  final SonyCameraDevice device;

  TestsPageState(this.device);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.update),
                  tooltip: 'Poll updates',
                  onPressed: () {
                    device.api.pollSettings();
                  },
                ),
              ],
            ),
            backgroundColor: Colors.blueGrey,
            body: ListenableProvider<CameraSettings>(
                create: (context) => SonyApi.connectedCamera.cameraSettings,
                child: Consumer<CameraSettings>(
                  builder: (context, model, _) => ListView(
                    children: <Widget>[
                      ///Versions (get) camera
                      getVersionsRowCamera(),

                      ///Versions (get) avContent
                      getVersionsRowAvContent(),

                      ///Versions (get) system
                      getVersionsRowSystem(),

                      ///Versions (get) guide
                      getVersionsRowGuide(),

                      ///Versions (get) accessControl
                      getVersionsRowAccessControl(),

                      ///MethodTypes (get) camera
                      getMethodTypesRowCamera(),

                      ///MethodTypes (get) avContent
                      getMethodTypesRowAvContent(),

                      ///MethodTypes (get) system
                      getMethodTypesRowSystem(),

                      ///MethodTypes (get) guide
                      getMethodTypesRowGuide(),

                      ///MethodTypes (get) accessControl
                      getMethodTypesRowAccessControl(),

                      ///AvailableApiList (get)
                      getAvailableFunctionsRow(),

                      ///ApplicationInfo (get)
                      getApplicationInfoRow(),

                      ///AvailableSettings (get)
                      getAvailableSettingsRow(),

                      ///CameraFunction (set, get, getSupported, getAvailable)
                      getCameraFunctionsRow(),

                      ///CapturePhoto (act)
                      getCapturePhotoRow(),

                      ///CameraSetup (stop)
                      getCameraSetupRow(),

                      ///LiveView (start, stop)
                      getLiveViewRow(),

                      ///Zoom (act)
                      getZoomRow(),

                      ///HalfPressShutter (act, cancel)
                      getHalfPressShutterRow(),

                      ///SelfTimer (set, get, getSupported, getAvailable)
                      getSelfTimerRow(),

                      ///ContShootingMode (set, get, getSupported, getAvailable)
                      getContShootingModeRow(),

                      ///ContShootingSpeed (set, get, getSupported, getAvailable)
                      getContShootingSpeedRow(),

                      ///ContShooting (start, stop)
                      getContShootingRow(),

                      ///Movie Recording (start, stop)
                      getMovieRecordingRow(),

                      ///Audio Recording (start, stop)
                      getAudioRecordingRow(),

                      ///Loop Recording (start, stop)
                      getLoopRecordingRow(),

                      ///MeteringMode (get, getSupported)
                      getMeteringModeRow(),

                      ///Ev (set, get, getSupported, getAvailable)
                      getEVRow(),

                      ///FNumber (set, get, getSupported, getAvailable)
                      getFNumberRow(),

                      ///Iso (set, get, getSupported, getAvailable)
                      getIsoRow(),

                      ///LiveViewSize (set, get, getSupported, getAvailable)
                      getLiveViewSizeRow(),

                      ///PostViewImageSize (set, get, getSupported, getAvailable)
                      getPostViewImageSizeRow(),

                      ///ProgramShift (set, get, getSupported, getAvailable)
                      getProgramShiftRow(),

                      ///ShutterSpeed (set, get, getSupported, getAvailable)
                      getShutterSpeedRow(),

                      ///FocusAreaSpot (set, get)
                      getFocusAreaSpotRow(),

                      ///WhiteBalance (set, get, getSupported, getAvailable)
                      getWhiteBalanceModeRow(),
                      getWhiteBalanceColorTempRow(),

                      ///FlashMode (set, get, getSupported, getAvailable)
                      getFlashRow(),

                      ///FocusMode (set, get, getSupported, getAvailable)
                      getFocusModeRow(),

                      ///ZoomSetting (set, get, getSupported, getAvailable)
                      getZoomSettingRow(),

                      ///StorageInformation (get)
                      getStorageInformationRow(),

                      ///LiveViewInfo (set, get)
                      getLiveViewFrameInfoRow(),

                      ///SilentShootingSettings (set, get, getSupported, getAvailable)
                      getSilentShootingSettingsRow(),

                      ///ShootMode (set, get, getSupported, getAvailable)
                      getShootModeRow(),

                      ///Image File Format (set, get, getSupported, getAvailable)
                      getImageFileFormatRow(),

                      ///Image Size (set, get, getSupported, getAvailable)
                      getImageSizeRow(),

                      ///Aspect Ratio (set, get, getSupported, getAvailable)
                      getAspectRatioRow()
                    ],
                  ),
                )),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0)),
                  child: Text("reload"),
                  color: Colors.blue,
                  onPressed: () {
                    device.updateSettings();
                  },
                )
              ],
            )));
  }

  TextStyle getTextStyle(Function function) {
    Color color = Colors.black12;

    switch (function.availability()) {
      case FunctionAvailability.Available:
        color = Colors.green;
        break;
      case FunctionAvailability.Supported:
        color = Colors.orange;
        break;
      case FunctionAvailability.Unsupported:
        color = Colors.red;
        break;
    }

    return TextStyle(color: color);
  }

  ///Versions (get) Camera
  Widget getVersionsRowCamera() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.versionsCamera,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " Camera"),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text("getWebApiVersions", style: getTextStyle(device.api.getWebApiVersionsCamera))]),
                    onTap: () => device.api.getWebApiVersionsCamera(update: ForceUpdate.On)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: DropdownButton<WebApiVersionsValue>(
                            isExpanded: true,
                            hint: Text("available"),
                            items: device.cameraSettings.versionsCamera.values
                                .map<DropdownMenuItem<WebApiVersionsValue>>(
                                    (e) => DropdownMenuItem<WebApiVersionsValue>(child: Text(e.name), value: e))
                                .toList(),
                            onChanged: (value) {},
                          )))
                ]),
              ]),
        ),
      ),
    );
  }

  ///Versions (get) avContent
  Widget getVersionsRowAvContent() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.versionsAvContent,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " AvContent"),
                    subtitle: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text("getWebApiVersionsAvContent", style: getTextStyle(device.api.getWebApiVersionsAvContent))
                    ]),
                    onTap: () => device.api.getWebApiVersionsAvContent(update: ForceUpdate.On)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: DropdownButton<WebApiVersionsValue>(
                            isExpanded: true,
                            hint: Text("available"),
                            items: device.cameraSettings.versionsAvContent.values
                                .map<DropdownMenuItem<WebApiVersionsValue>>(
                                    (e) => DropdownMenuItem<WebApiVersionsValue>(child: Text(e.name), value: e))
                                .toList(),
                            onChanged: (value) {},
                          )))
                ]),
              ]),
        ),
      ),
    );
  }

  ///Versions (get) system
  Widget getVersionsRowSystem() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.versionsSystem,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " System"),
                    subtitle: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Text("getWebApiVersionsSystem", style: getTextStyle(device.api.getWebApiVersionsSystem))
                    ]),
                    onTap: () => device.api.getWebApiVersionsSystem(update: ForceUpdate.On)),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: DropdownButton<WebApiVersionsValue>(
                            isExpanded: true,
                            hint: Text("available"),
                            items: device.cameraSettings.versionsSystem.values
                                    .map<DropdownMenuItem<WebApiVersionsValue>>(
                                        (e) => DropdownMenuItem<
                                                WebApiVersionsValue>(
                                            child: Text(e.name), value: e))
                                    .toList(),
                                onChanged: (value) {},
                              )))
                    ]),
              ]),
        ),
      ),
    );
  }

  ///Versions (get) guide
  Widget getVersionsRowGuide() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.versionsGuide,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " Guide"),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("getWebApiVersionsGuide", style: getTextStyle(device.api.getWebApiVersionsGuide))
                        ]),
                    onTap: () => device.api.getWebApiVersionsGuide(update: ForceUpdate.On)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<WebApiVersionsValue>(
                                isExpanded: true,
                                hint: Text("available"),
                                items: device
                                    .cameraSettings.versionsGuide.values
                                    .map<DropdownMenuItem<WebApiVersionsValue>>(
                                        (e) => DropdownMenuItem<
                                                WebApiVersionsValue>(
                                            child: Text(e.name), value: e))
                                    .toList(),
                                onChanged: (value) {},
                              )))
                    ]),
              ]),
        ),
      ),
    );
  }

  ///Versions (get) accessControl
  Widget getVersionsRowAccessControl() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.versionsAccessControl,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " AccessControl"),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("getWebApiVersionsAccessControl",
                              style: getTextStyle(device.api.getWebApiVersionsAccessControl))
                        ]),
                    onTap: () => device.api.getWebApiVersionsAccessControl(update: ForceUpdate.On)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<WebApiVersionsValue>(
                                isExpanded: true,
                                hint: Text("available"),
                                items: device
                                    .cameraSettings.versionsAccessControl.values
                                    .map<DropdownMenuItem<WebApiVersionsValue>>(
                                        (e) => DropdownMenuItem<
                                                WebApiVersionsValue>(
                                            child: Text(e.name), value: e))
                                    .toList(),
                                onChanged: (value) {},
                              )))
                    ]),
              ]),
        ),
      ),
    );
  }

  ///MethodTypes (get) camera
  Widget getMethodTypesRowCamera() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.methodTypesCamera,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " Camera"),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("getMethodTypesCamera", style: getTextStyle(device.api.getMethodTypesCamera))
                    ]),
                onTap: () => device.api.getMethodTypesCamera(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.methodTypesCamera.values
                            .map<DropdownMenuItem<WebApiMethodValue>>((e) =>
                            DropdownMenuItem<WebApiMethodValue>(
                                child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) {},
                      )))
            ]),
          ]),
        ),
      ),
    );
  }

  ///MethodTypes (get) avContent
  Widget getMethodTypesRowAvContent() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.methodTypesAvContent,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " AvContent"),
                subtitle:
                Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("getMethodTypesAvContent", style: getTextStyle(device.api.getMethodTypesAvContent))
                    ]),
                onTap: () => device.api.getMethodTypesAvContent(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.methodTypesAvContent.values
                            .map<DropdownMenuItem<WebApiMethodValue>>((e) =>
                            DropdownMenuItem<WebApiMethodValue>(
                                child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) {},
                      )))
            ]),
          ]),
        ),
      ),
    );
  }

  ///MethodTypes (get) system
  Widget getMethodTypesRowSystem() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.methodTypesSystem,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " System"),
                subtitle:
                Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("getMethodTypesSystem", style: getTextStyle(device.api.getMethodTypesSystem))
                    ]),
                onTap: () => device.api.getMethodTypesSystem(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.methodTypesSystem.values
                            .map<DropdownMenuItem<WebApiMethodValue>>((e) =>
                            DropdownMenuItem<WebApiMethodValue>(
                                child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) {},
                      )))
            ]),
          ]),
        ),
      ),
    );
  }

  ///MethodTypes (get) guide
  Widget getMethodTypesRowGuide() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.methodTypesGuide,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " Guide"),
                subtitle:
                Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("getWebApiVersionsAvContent", style: getTextStyle(device.api.getMethodTypesGuide))
                    ]),
                onTap: () => device.api.getMethodTypesGuide(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.methodTypesGuide.values
                            .map<DropdownMenuItem<WebApiMethodValue>>((e) =>
                            DropdownMenuItem<WebApiMethodValue>(
                                child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) {},
                      )))
            ]),
          ]),
        ),
      ),
    );
  }

  ///MethodTypes (get) accessControl
  Widget getMethodTypesRowAccessControl() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.methodTypesAccessControl,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " AccessControl"),
                subtitle:
                Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("getWebApiVersionsAvContent", style: getTextStyle(device.api.getMethodTypesAccessControl))
                    ]),
                onTap: () => device.api.getMethodTypesAccessControl(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device
                            .cameraSettings.methodTypesAccessControl.values
                            .map<DropdownMenuItem<WebApiMethodValue>>((e) =>
                                DropdownMenuItem<WebApiMethodValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) {},
                      )))
            ]),
          ]),
        ),
      ),
    );
  }

  ///AvailableApiList (get)
  Widget getAvailableFunctionsRow() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.availableFunctions,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.AvailableFunctions.name),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("getAvailableFunctions", style: getTextStyle(device.api.getAvailableFunctions))]),
                onTap: () => device.api.getAvailableFunctions(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ApiFunctionValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.availableFunctions.values
                            .map<DropdownMenuItem<ApiFunctionValue>>(
                                (e) => DropdownMenuItem<ApiFunctionValue>(child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) {},
                      )))
            ]),
          ]),
        ),
      ),
    );
  }

  ///ApplicationInfo (get)
  Widget getApplicationInfoRow() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.applicationInfo,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.ApplicationInfo.name),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("getApplicationInfo", style: getTextStyle(device.api.getApplicationInfo))]),
                onTap: () => device.api.getApplicationInfo(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<StringValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.applicationInfo.values
                            .map<DropdownMenuItem<StringValue>>(
                                (e) => DropdownMenuItem<StringValue>(child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) {},
                      )))
            ]),
          ]),
        ),
      ),
    );
  }

  ///AvailableSettings (get)
  Widget getAvailableSettingsRow() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.availableSettings,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.AvailableSettings.name),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("getAvailableSettings", style: getTextStyle(device.api.getAvailableSettings))]),
                onTap: () => device.api.getAvailableSettings(false, update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<StringValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.availableSettings.values
                            .map<DropdownMenuItem<StringValue>>(
                                (e) => DropdownMenuItem<StringValue>(child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) {},
                      )))
            ]),
          ]),
        ),
      ),
    );
  }

  ///CameraFunction (set, get, getSupported, getAvailable)
  Widget getCameraFunctionsRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.cameraFunction,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.CameraFunction.name),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("setCameraFunction", style: getTextStyle(device.api.setCameraFunction)),
                Text("getCameraFunction", style: getTextStyle(device.api.getCameraFunction)),
                Text(device.cameraSettings.cameraFunction.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
              ]),
              onTap: () => device.api.getCameraFunction(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<CameraFunctionValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.cameraFunction.available
                            .map<DropdownMenuItem<CameraFunctionValue>>((e) =>
                                DropdownMenuItem<CameraFunctionValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setCameraFunction(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<CameraFunctionValue>(
                        isExpanded: true,
                        hint: Text("supported"),
                        items: device.cameraSettings.cameraFunction.supported
                            .map<DropdownMenuItem<CameraFunctionValue>>((e) =>
                                DropdownMenuItem<CameraFunctionValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setCameraFunction(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///CapturePhoto (act, await)
  Widget getCapturePhotoRow() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.capturePhoto,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.CapturePhoto.name + " ACT"),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("actCapturePhoto", style: getTextStyle(device.api.actCapturePhoto))]),
                onTap: () => device.api.actCapturePhoto()),
            ListTile(
              title: Text(ItemId.CapturePhoto.name + " AWAIT"),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("awaitCapturePhoto", style: getTextStyle(device.api.actCapturePhoto))]),
              onTap: () => device.api.awaitCapturePhoto(),
            ),
            Text(device.cameraSettings.capturePhoto.values.toString()),
          ]),
        ),
      ),
    );
  }

  ///CameraSetup (start, stop)
  Widget getCameraSetupRow() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.cameraSetup,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.CameraSetup.name + " START"),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text("startCameraSetup", style: getTextStyle(device.api.startCameraSetup))]),
                onTap: () => device.api.startCameraSetup()),
            ListTile(
              title: Text(ItemId.CameraSetup.name + " STOP"),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("stopCameraSetup", style: getTextStyle(device.api.stopCameraSetup))]),
              onTap: () => device.api.stopCameraSetup(),
            )
          ]),
        ),
      ),
    );
  }

  ///Zoom (act)
  Widget getZoomRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.zoom,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.Zoom.name),
                subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(device.cameraSettings.zoom.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
                  Text("actZoom", style: getTextStyle(device.api.actZoom))
                ]),
                onTap: () {}),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text("In"),
                    onTap: () => device.api.actZoom("in", "1shot")),
              ),
              Expanded(
                child: ListTile(
                    title: Text("Out"),
                    onTap: () => device.api.actZoom("out", "1shot")),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text("In"),
                    onTap: () => device.api.actZoom("in", "1shot")),
              ),
              Expanded(
                child: ListTile(
                    title: Text("Out"),
                    onTap: () => device.api.actZoom("out", "1shot")),
              )
            ]),
          ]),
        ),
      ),
    );
  }

  ///HalfPressShutter (act, cancel)
  Widget getHalfPressShutterRow() {
    return ListenableProvider<InfoItem>(
        create: (context) => device.cameraSettings.halfPressShutter,
        child: Consumer<InfoItem>(
          builder: (context, model, _) => Card(
            child: Column(children: [
              ListTile(
                  title: Text(ItemId.HalfPressShutter.name),
                  subtitle: Text(
                      device.cameraSettings.halfPressShutter.value?.name ??
                          "NotAvailable",
                      textAlign: TextAlign.start),
                  onTap: () {}),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Expanded(
                  child: ListTile(
                      title: Text(ItemId.HalfPressShutter.name + " ACT"),
                      subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text("actHalfPressShutter", style: getTextStyle(device.api.actHalfPressShutter))]),
                      onTap: () => device.api.actHalfPressShutter()),
                ),
                Expanded(
                  child: ListTile(
                      title: Text(ItemId.HalfPressShutter.name + " CANCEL"),
                      subtitle: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                        Text("cancelHalfPressShutter", style: getTextStyle(device.api.cancelHalfPressShutter))
                      ]),
                      onTap: () => device.api.cancelHalfPressShutter()),
                )
              ]),
            ]),
          ),
        ));
  }

  ///SelfTimer (set, get, getSupported, getAvailable)
  Widget getSelfTimerRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.selfTimer,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.SelfTimer.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(device.cameraSettings.selfTimer.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
                Text("getSelfTimer", style: getTextStyle(device.api.getSelfTimer)),
                Text("setSelfTimer", style: getTextStyle(device.api.setSelfTimer))
              ]),
              onTap: () => device.api.getSelfTimer(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<IntValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.selfTimer.available
                            .map<DropdownMenuItem<IntValue>>((e) =>
                                DropdownMenuItem<IntValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setSelfTimer(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<IntValue>(
                        isExpanded: true,
                        hint: Text("supported"),
                        items: device.cameraSettings.selfTimer.supported
                            .map<DropdownMenuItem<IntValue>>((e) =>
                                DropdownMenuItem<IntValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setSelfTimer(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///ContShootingMode (set, get, getSupported, getAvailable)
  Widget getContShootingModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.contShootingMode,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ContShootingMode.name),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(device.cameraSettings.contShootingMode.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
                Text("setContShootingMode", style: getTextStyle(device.api.setContShootingMode)),
                Text("getContShootingMode", style: getTextStyle(device.api.getContShootingMode))
              ]),
              onTap: () => device.api.getContShootingMode(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ContShootingModeValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.contShootingMode.available
                            .map<DropdownMenuItem<ContShootingModeValue>>(
                                (e) => DropdownMenuItem<ContShootingModeValue>(child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setContShootingMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ContShootingModeValue>(
                        isExpanded: true,
                        hint: Text("supported"),
                        items: device.cameraSettings.contShootingMode.supported
                            .map<DropdownMenuItem<ContShootingModeValue>>(
                                (e) => DropdownMenuItem<ContShootingModeValue>(child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setContShootingMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }


  ///ContShootingSpeed (set, get, getSupported, getAvailable)
  Widget getContShootingSpeedRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.contShootingSpeed,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ContShootingSpeed.name),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(device.cameraSettings.contShootingSpeed.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
                Text("setContShootingSpeed", style: getTextStyle(device.api.setContShootingSpeed)),
                Text("getContShootingSpeed", style: getTextStyle(device.api.getContShootingSpeed))
              ]),
              onTap: () => device.api.getContShootingSpeed(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ContShootingSpeedValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.contShootingSpeed.available
                            .map<DropdownMenuItem<ContShootingSpeedValue>>(
                                (e) => DropdownMenuItem<ContShootingSpeedValue>(child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setContShootingSpeed(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ContShootingSpeedValue>(
                        isExpanded: true,
                        hint: Text("supported"),
                        items: device.cameraSettings.contShootingSpeed.supported
                            .map<DropdownMenuItem<ContShootingSpeedValue>>(
                                (e) => DropdownMenuItem<ContShootingSpeedValue>(child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setContShootingSpeed(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///ContShooting (start, stop)
  Widget getContShootingRow() {
    return ListenableProvider<InfoItem>(
      create: (context) => device.cameraSettings.contShooting,
      child: Consumer<InfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ContShooting.name),
              subtitle:
                  Text(device.cameraSettings.contShooting.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text(ItemId.ContShooting.name + " START"),
                    subtitle: Text("startContShooting", style: getTextStyle(device.api.startContShooting)),
                    onTap: () => device.api.startContShooting()),
              ),
              Expanded(
                child: ListTile(
                    title: Text(ItemId.ContShooting.name + " STOP"),
                    subtitle: Text("stopContShooting", style: getTextStyle(device.api.stopContShooting)),
                    onTap: () => device.api.stopContShooting()),
              )
            ]),
          ]),
        ),
      ),
    );
  }

  ///Movie Rec (start, stop)
  Widget getMovieRecordingRow() {
    return ListenableProvider<InfoItem>(
      create: (context) => device.cameraSettings.movieRecording,
      child: Consumer<InfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.MovieRecording.name),
              subtitle: Text(device.cameraSettings.movieRecording.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text(ItemId.MovieRecording.name + " START"),
                    subtitle: Text("startMovieRec", style: getTextStyle(device.api.startMovieRecording)),
                    onTap: () => device.api.startMovieRecording()),
              ),
              Expanded(
                child: ListTile(
                    title: Text(ItemId.MovieRecording.name + " STOP"),
                    subtitle: Text("stopMovieRec", style: getTextStyle(device.api.stopMovieRecording)),
                    onTap: () => device.api.stopMovieRecording()),
              )
            ]),
          ]),
        ),
      ),
    );
  }

  ///Movie Rec (start, stop)
  Widget getAudioRecordingRow() {
    return ListenableProvider<InfoItem>(
      create: (context) => device.cameraSettings.audioRecording,
      child: Consumer<InfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.AudioRecording.name),
              subtitle: Text(device.cameraSettings.audioRecording.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text(ItemId.AudioRecording.name + " START"),
                    subtitle: Text("startAudioRec", style: getTextStyle(device.api.startAudioRecording)),
                    onTap: () => device.api.startAudioRecording()),
              ),
              Expanded(
                child: ListTile(
                    title: Text(ItemId.AudioRecording.name + " STOP"),
                    subtitle: Text("stopAudioRec", style: getTextStyle(device.api.stopAudioRecording)),
                    onTap: () => device.api.stopAudioRecording()),
              )
            ]),
          ]),
        ),
      ),
    );
  }

  ///Loop Rec (start, stop)
  Widget getLoopRecordingRow() {
    return ListenableProvider<InfoItem>(
      create: (context) => device.cameraSettings.loopRecording,
      child: Consumer<InfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.LoopRecording.name),
              subtitle: Text(device.cameraSettings.loopRecording.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text(ItemId.LoopRecording.name + " START"),
                    subtitle: Text("startLoopRecording", style: getTextStyle(device.api.startLoopRecording)),
                    onTap: () => device.api.startLoopRecording()),
              ),
              Expanded(
                child: ListTile(
                    title: Text(ItemId.LoopRecording.name + " STOP"),
                    subtitle: Text("stopLoopRecording", style: getTextStyle(device.api.stopLoopRecording)),
                    onTap: () => device.api.stopLoopRecording()),
              )
            ]),
          ]),
        ),
      ),
    );
  }

  ///Live View (start, stop)
  Widget getLiveViewRow() {
    return ListenableProvider<InfoItem>(
      create: (context) => device.cameraSettings.liveView,
      child: Consumer<InfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.LiveView.name),
              subtitle: Text(device.cameraSettings.liveView.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text(ItemId.LiveView.name + " START"),
                    subtitle: Text("startLiveView", style: getTextStyle(device.api.startLiveView)),
                    onTap: () async{
                      await device.api.startLiveView();

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LiveViewPage(device)),
                      );
                    }),
              ),
              Expanded(
                child: ListTile(
                    title: Text(ItemId.LiveView.name + " STOP"),
                    subtitle: Text("stopLiveView", style: getTextStyle(device.api.stopLiveView)),
                    onTap: () => device.api.stopLiveView()),
              )
            ]),
          ]),
        ),
      ),
    );
  }

  ///MeteringMode (get, getSupported)
  Widget getMeteringModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.meteringMode,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.MeteringMode.name),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(device.cameraSettings.meteringMode.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
                Text("setContShootingSpeed", style: getTextStyle(device.api.setContShootingSpeed)),
                Text("getContShootingSpeed ", style: getTextStyle(device.api.getContShootingSpeed))
              ]),
              onTap: () => device.api.getMeteringMode(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<MeteringModeValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.meteringMode.available
                            .map<DropdownMenuItem<MeteringModeValue>>((e) =>
                                DropdownMenuItem<MeteringModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setMeteringMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<MeteringModeValue>(
                        isExpanded: true,
                        hint: Text("supported"),
                        items: device.cameraSettings.meteringMode.supported
                            .map<DropdownMenuItem<MeteringModeValue>>((e) =>
                                DropdownMenuItem<MeteringModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setMeteringMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///Ev (set, get, getSupported, getAvailable)
  Widget getEVRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.exposureCompensation,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ExposureCompensation.name),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(device.cameraSettings.exposureCompensation.value?.name ?? "NotAvailable",
                    textAlign: TextAlign.start),
                Text("getExposureCompensation", style: getTextStyle(device.api.getExposureCompensation)),
                Text("setExposureCompensation", style: getTextStyle(device.api.setExposureCompensation))
              ]),
              onTap: () => device.api.getExposureCompensation(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(title: Text("Up"), onTap: () => device.api.modifyExposureCompensation(1)),
              ),
              Expanded(
                child: ListTile(title: Text("Down"), onTap: () => device.api.modifyExposureCompensation(-1)),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<EvValue>(
                        hint: Text("available"),
                        items: device.cameraSettings.exposureCompensation.available
                            .map<DropdownMenuItem<EvValue>>((e) =>
                            DropdownMenuItem<EvValue>(
                                child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setExposureCompensation(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<EvValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings.exposureCompensation.supported
                            .map<DropdownMenuItem<EvValue>>((e) =>
                            DropdownMenuItem<EvValue>(
                                child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setExposureCompensation(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///FNumber (set, get, getSupported, getAvailable)
  Widget getFNumberRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.fNumber,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.FNumber.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.fNumber.value?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            Text("setFNumber", style: getTextStyle(device.api.setFNumber)),
                            Text("getFNumber", style: getTextStyle(device.api.getFNumber)),
                            Text("modifyFNumber", style: getTextStyle(device.api.modifyFNumber))
                          ]),
                      onTap: () =>
                          device.api.getFNumber(update: ForceUpdate.On),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ListTile(
                                title: Text("Up"),
                                onTap: () => device.api.modifyFNumber(1)),
                          ),
                          Expanded(
                            child: ListTile(
                                title: Text("Down"),
                                onTap: () => device.api.modifyFNumber(-1)),
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<DoubleValue>(
                                    hint: Text("available"),
                                    items: device
                                        .cameraSettings.fNumber.available
                                        .map<DropdownMenuItem<DoubleValue>>(
                                            (e) =>
                                                DropdownMenuItem<DoubleValue>(
                                                    child: Text(e.name),
                                                    value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setFNumber(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<DoubleValue>(
                                    hint: Text("supported"),
                                    items: device
                                        .cameraSettings.fNumber.supported
                                        .map<DropdownMenuItem<DoubleValue>>(
                                            (e) =>
                                                DropdownMenuItem<DoubleValue>(
                                                    child: Text(e.name),
                                                    value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setFNumber(value),
                                  ))),
                        ]),
                  ]),
                )));
  }

  ///Iso (set, get, getSupported, getAvailable)
  Widget getIsoRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.iso,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.IsoSpeedRate.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.iso.value?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            Text("setIso", style: getTextStyle(device.api.setIso)),
                            Text("getIso", style: getTextStyle(device.api.getIso)),
                            Text("modifyIso", style: getTextStyle(device.api.modifyIso))
                          ]),
                      onTap: () => device.api.getIso(update: ForceUpdate.On),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ListTile(
                                title: Text("Up"),
                                onTap: () => device.api.modifyIso(1)),
                          ),
                          Expanded(
                            child: ListTile(
                                title: Text("Down"),
                                onTap: () => device.api.modifyIso(-1)),
                          )
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<IsoValue>(
                                    hint: Text("available"),
                                    items: device.cameraSettings.iso.available
                                        .map<DropdownMenuItem<IsoValue>>((e) =>
                                            DropdownMenuItem<IsoValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setIso(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<IsoValue>(
                                    hint: Text("supported"),
                                    items: device.cameraSettings.iso.supported
                                        .map<DropdownMenuItem<IsoValue>>((e) =>
                                            DropdownMenuItem<IsoValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setIso(value),
                                  ))),
                        ]),
                  ]),
                )));
  }

  ///LiveViewSize (set, get, getSupported, getAvailable)
  Widget getLiveViewSizeRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.liveViewSize,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.LiveViewSize.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.liveViewSize.value
                                    ?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            Text("getLiveViewSize", style: getTextStyle(device.api.getLiveViewSize)),
                            Text("startLiveViewWithSize", style: getTextStyle(device.api.startLiveViewWithSize)),
                          ]),
                      onTap: () =>
                          device.api.getLiveViewSize(update: ForceUpdate.On),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<LiveViewSizeValue>(
                                    hint: Text("available"),
                                    items: device
                                        .cameraSettings.liveViewSize.available
                                        .map<
                                            DropdownMenuItem<
                                                LiveViewSizeValue>>((e) =>
                                            DropdownMenuItem<LiveViewSizeValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.startLiveViewWithSize(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<LiveViewSizeValue>(
                                    hint: Text("supported"),
                                    items: device
                                        .cameraSettings.liveViewSize.supported
                                        .map<
                                            DropdownMenuItem<
                                                LiveViewSizeValue>>((e) =>
                                            DropdownMenuItem<LiveViewSizeValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.startLiveViewWithSize(value),
                                  ))),
                        ]),
                  ]),
                )));
  }

  ///PostViewImageSize (set, get, getSupported, getAvailable)
  Widget getPostViewImageSizeRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.postViewImageSize,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.PostViewImageSize.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.postViewImageSize.value
                                    ?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            Text("setPostViewImageSize", style: getTextStyle(device.api.setPostViewImageSize)),
                            Text("getPostViewImageSize", style: getTextStyle(device.api.getPostViewImageSize))
                          ]),
                      onTap: () => device.api
                          .getPostViewImageSize(update: ForceUpdate.On),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<PostViewImageSizeValue>(
                                    hint: Text("available"),
                                    items: device.cameraSettings
                                        .postViewImageSize.available
                                        .map<
                                            DropdownMenuItem<
                                                PostViewImageSizeValue>>((e) =>
                                            DropdownMenuItem<
                                                    PostViewImageSizeValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setPostViewImageSize(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<PostViewImageSizeValue>(
                                    hint: Text("supported"),
                                    items: device.cameraSettings
                                        .postViewImageSize.supported
                                        .map<
                                            DropdownMenuItem<
                                                PostViewImageSizeValue>>((e) =>
                                            DropdownMenuItem<
                                                    PostViewImageSizeValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setPostViewImageSize(value),
                                  ))),
                        ]),
                  ]),
                )));
  }

  ///ProgramShift (set, get, getSupported, getAvailable)
  Widget getProgramShiftRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.programShift,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.ProgramShift.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.programShift.value
                                    ?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            Text("getProgramShift", style: getTextStyle(device.api.getProgramShift)),
                            Text("setProgramShift", style: getTextStyle(device.api.setProgramShift)),
                          ]),
                      onTap: () =>
                          device.api.getProgramShift(update: ForceUpdate.On),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<IntValue>(
                                    hint: Text("available"),
                                    items: device
                                        .cameraSettings.programShift.available
                                        .map<DropdownMenuItem<IntValue>>((e) =>
                                            DropdownMenuItem<IntValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setProgramShift(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<IntValue>(
                                    hint: Text("supported"),
                                    items: device
                                        .cameraSettings.programShift.supported
                                        .map<DropdownMenuItem<IntValue>>((e) =>
                                            DropdownMenuItem<IntValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setProgramShift(value),
                                  ))),
                        ]),
                  ]),
                )));
  }

  ///ShutterSpeed (set, get, getSupported, getAvailable)
  Widget getShutterSpeedRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.shutterSpeed,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ShutterSpeed.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.shutterSpeed.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    Text("getShutterSpeed", style: getTextStyle(device.api.getShutterSpeed)),
                    Text("modifyShutterSpeed", style: getTextStyle(device.api.modifyShutterSpeed)),
                    Text("setProgramShift", style: getTextStyle(device.api.setProgramShift)),
                  ]),
              onTap: () => device.api.getShutterSpeed(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text("Up"),
                    onTap: () => device.api.modifyShutterSpeed(1)),
              ),
              Expanded(
                child: ListTile(
                    title: Text("Down"),
                    onTap: () => device.api.modifyShutterSpeed(-1)),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ShutterSpeedValue>(
                        hint: Text("available"),
                        items: device.cameraSettings.shutterSpeed.available
                            .map<DropdownMenuItem<ShutterSpeedValue>>((e) =>
                                DropdownMenuItem<ShutterSpeedValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setShutterSpeed(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ShutterSpeedValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings.shutterSpeed.supported
                            .map<DropdownMenuItem<ShutterSpeedValue>>((e) =>
                                DropdownMenuItem<ShutterSpeedValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setShutterSpeed(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///FocusAreaSpot (set, get, getSupported, getAvailable)
  Widget getFocusAreaSpotRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => (device.cameraSettings.focusAreaSpot),
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.FocusAreaSpot.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.focusAreaSpot.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    Text("setFocusAreaSpot", style: getTextStyle(device.api.setFocusAreaSpot)),
                    Text("getFocusAreaSpot", style: getTextStyle(device.api.getFocusAreaSpot)),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }

  ///WhiteBalance (set, get, getSupported, getAvailable)
  Widget getWhiteBalanceModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.whiteBalanceMode,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.WhiteBalanceMode.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.whiteBalanceMode.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    Text("setWhiteBalanceMode", style: getTextStyle(device.api.setWhiteBalanceMode)),
                    Text("getWhiteBalanceMode", style: getTextStyle(device.api.getWhiteBalanceMode)),
                  ]),
              onTap: () =>
                  device.api.getWhiteBalanceMode(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WhiteBalanceModeValue>(
                        hint: Text("available"),
                        items: device.cameraSettings.whiteBalanceMode.available
                            .map<DropdownMenuItem<WhiteBalanceModeValue>>((e) =>
                                DropdownMenuItem<WhiteBalanceModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setWhiteBalanceMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WhiteBalanceModeValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings.whiteBalanceMode.supported
                            .map<DropdownMenuItem<WhiteBalanceModeValue>>((e) =>
                                DropdownMenuItem<WhiteBalanceModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setWhiteBalanceMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///White Balance Color Temp

  Widget getWhiteBalanceColorTempRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.whiteBalanceColorTemp,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.WhiteBalanceColorTemp.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.whiteBalanceColorTemp.value
                            ?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    Text("setWhiteBalanceColorTemp", style: getTextStyle(device.api.setWhiteBalanceColorTemp)),
                    Text("modifyWhiteBalanceColorTemp", style: getTextStyle(device.api.modifyWhiteBalanceColorTemp)),
                    Text("getWhiteBalanceColorTemp", style: getTextStyle(device.api.getWhiteBalanceColorTemp)),
                  ]),
              onTap: () =>
                  device.api.getWhiteBalanceColorTemp(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text("Up"),
                    onTap: () => device.api.modifyWhiteBalanceColorTemp(1)),
              ),
              Expanded(
                child: ListTile(
                    title: Text("Down"),
                    onTap: () => device.api.modifyWhiteBalanceColorTemp(-1)),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WhiteBalanceColorTempValue>(
                        hint: Text("available"),
                        items: device
                            .cameraSettings.whiteBalanceColorTemp.available
                            .map<DropdownMenuItem<WhiteBalanceColorTempValue>>(
                                (e) => DropdownMenuItem<
                                        WhiteBalanceColorTempValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setWhiteBalanceColorTemp(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WhiteBalanceColorTempValue>(
                        hint: Text("supported"),
                        items: device
                            .cameraSettings.whiteBalanceColorTemp.supported
                            .map<DropdownMenuItem<WhiteBalanceColorTempValue>>(
                                (e) => DropdownMenuItem<
                                        WhiteBalanceColorTempValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) =>
                            device.api.setWhiteBalanceColorTemp(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///FlashMode (set, get, getSupported, getAvailable)
  Widget getFlashRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.flashMode,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.FlashMode.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.flashMode.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    Text("setFlashMode", style: getTextStyle(device.api.setFlashMode)),
                    Text("getFlashMode", style: getTextStyle(device.api.getFlashMode)),
                  ]),
              onTap: () => device.api.getFlashMode(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<FlashModeValue>(
                        hint: Text("available"),
                        items: device.cameraSettings.flashMode.available
                            .map<DropdownMenuItem<FlashModeValue>>((e) =>
                                DropdownMenuItem<FlashModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setFlashMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<FlashModeValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings.flashMode.supported
                            .map<DropdownMenuItem<FlashModeValue>>((e) =>
                                DropdownMenuItem<FlashModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setFlashMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///FocusMode (set, get, getSupported, getAvailable)
  Widget getFocusModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.focusMode,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.FocusMode.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.focusMode.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    Text("setFocusMode", style: getTextStyle(device.api.setFocusMode)),
                    Text("getFocusMode", style: getTextStyle(device.api.getFocusMode)),
                  ]),
              onTap: () => device.api.getFocusMode(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<FocusModeValue>(
                        hint: Text("available"),
                        items: device.cameraSettings.focusMode.available
                            .map<DropdownMenuItem<FocusModeValue>>((e) =>
                                DropdownMenuItem<FocusModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setFocusMode(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<FocusModeValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings.focusMode.supported
                            .map<DropdownMenuItem<FocusModeValue>>((e) =>
                                DropdownMenuItem<FocusModeValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setFocusMode(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///ZoomSetting (set, get, getSupported, getAvailable)
  Widget getZoomSettingRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.zoomSetting,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ZoomSetting.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.zoomSetting.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    Text("setZoomSetting", style: getTextStyle(device.api.setZoomSetting)),
                    Text("getZoomSetting", style: getTextStyle(device.api.getZoomSetting)),
                  ]),
              onTap: () => device.api.getZoomSetting(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ZoomSettingValue>(
                        hint: Text("available"),
                        items: device.cameraSettings.zoomSetting.available
                            .map<DropdownMenuItem<ZoomSettingValue>>((e) =>
                                DropdownMenuItem<ZoomSettingValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setZoomSetting(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ZoomSettingValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings.zoomSetting.supported
                            .map<DropdownMenuItem<ZoomSettingValue>>((e) =>
                                DropdownMenuItem<ZoomSettingValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setZoomSetting(value),
                      ))),
            ]),
          ]),
        ),
      ),
    );
  }

  ///StorageInformation (get)
  Widget getStorageInformationRow() {
    return ListenableProvider<ListInfoItem>(
      create: (context) => device.cameraSettings.storageInformation,
      child: Consumer<ListInfoItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.StorageInformation.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("getStorageInformation", style: getTextStyle(device.api.getStorageInformation))]),
              onTap: () => device.api.getStorageInformation(update: ForceUpdate.On),
            ),
            Padding(
                    padding: EdgeInsets.all(16),
                    child: DropdownButton<StringValue>(
                      isExpanded: true,
                      hint: Text("available"),
                      items: device.cameraSettings.storageInformation.values
                          .map<DropdownMenuItem<StringValue>>(
                              (e) => DropdownMenuItem<StringValue>(child: Text(e.name), value: e))
                          .toList(),
                      onChanged: (value) => {},
                    )),
          ]),
        ),
      ),
    );
  }

  ///LiveViewInfo (set, get)
  Widget getLiveViewFrameInfoRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.liveViewFrameInfo,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) =>
            Card(
              child: Column(children: [
                ListTile(
                  title: Text(ItemId.LiveViewFrameInfo.name),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            device.cameraSettings.silentShooting.value?.name ??
                                "NotAvailable",
                            textAlign: TextAlign.start),
                        Text("setLiveViewInfo", style: getTextStyle(device.api.setLiveViewFrameInfo)),
                        Text("getLiveViewInfo", style: getTextStyle(device.api.getLiveViewFrameInfo)),
                      ]),
            ),
          ]),
        ),
      ),
    );
  }

  ///SilentShootingSettings (set, get, getSupported, getAvailable)
  Widget getSilentShootingSettingsRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.silentShooting,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) =>
                Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.SilentShooting.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.silentShooting.value
                                    ?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            Text("setSilentShooting", style: getTextStyle(device.api.setSilentShooting)),
                            Text("getSilentShooting", style: getTextStyle(device.api.getSilentShooting)),
                          ]),
                      onTap: () =>
                          device.api.getSilentShooting(update: ForceUpdate.On),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<OnOffValue>(
                                    hint: Text("available"),
                                    items: device
                                        .cameraSettings.silentShooting.available
                                        .map<DropdownMenuItem<OnOffValue>>(
                                            (e) => DropdownMenuItem<OnOffValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setSilentShooting(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<OnOffValue>(
                                    hint: Text("supported"),
                                    items: device
                                        .cameraSettings.silentShooting.supported
                                        .map<DropdownMenuItem<OnOffValue>>(
                                            (e) =>
                                            DropdownMenuItem<OnOffValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setSilentShooting(value),
                                  ))),
                        ]),
                  ]),
                )));
  }

  ///Shoot Mode (set, get, getSupported, getAvailable)
  Widget getShootModeRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.shootMode,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) =>
                Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.ShootMode.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.shootMode.value
                                    ?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            Text("setShootMode", style: getTextStyle(device.api.setShootMode)),
                            Text("getShootMode", style: getTextStyle(device.api.getShootMode))
                          ]),
                      onTap: () =>
                          device.api.getShootMode(update: ForceUpdate.On),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<ShootModeValue>(
                                    hint: Text("available"),
                                    items: device
                                        .cameraSettings.shootMode.available
                                        .map<DropdownMenuItem<ShootModeValue>>(
                                            (e) =>
                                            DropdownMenuItem<ShootModeValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setShootMode(value),
                                  ))),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<ShootModeValue>(
                                    hint: Text("supported"),
                                    items: device
                                        .cameraSettings.shootMode.supported
                                        .map<DropdownMenuItem<ShootModeValue>>(
                                            (e) =>
                                            DropdownMenuItem<ShootModeValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) =>
                                        device.api.setShootMode(value),
                                  ))),
                        ]),
                  ]),
                )));
  }


  ///Image File Format (set, get, getSupported, getAvailable)
  Widget getImageFileFormatRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.imageFileFormat,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) =>
                Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.ImageFileFormat.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.imageFileFormat.value
                                    ?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            Text("setImageFileFormat", style: getTextStyle(device.api.setImageFileFormat)),
                            Text("getImageFileFormat", style: getTextStyle(device.api.getImageFileFormat))
                          ]),
                      onTap: () =>
                          device.api.getImageFileFormat(update: ForceUpdate.On),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: DropdownButton<ImageFileFormatValue>(
                                    hint: Text("available"),
                                    items: device
                                        .cameraSettings.imageFileFormat.available
                                        .map<DropdownMenuItem<ImageFileFormatValue>>(
                                            (e) =>
                                            DropdownMenuItem<ImageFileFormatValue>(
                                                child: Text(e.name), value: e))
                                        .toList(),
                                    onChanged: (value) => device.api.setImageFileFormat(value),
                              ))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<ImageFileFormatValue>(
                                hint: Text("supported"),
                                items: device.cameraSettings.imageFileFormat.supported
                                    .map<DropdownMenuItem<ImageFileFormatValue>>(
                                        (e) => DropdownMenuItem<ImageFileFormatValue>(child: Text(e.name), value: e))
                                    .toList(),
                                onChanged: (value) => device.api.setImageFileFormat(value),
                              ))),
                    ]),
                  ]),
                )));
  }

  ///Image Size
  Widget getImageSizeRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.imageSize,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.ImageSize.name),
                      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(device.cameraSettings.imageSize.value?.name ?? "NotAvailable", textAlign: TextAlign.start),
                        Text("setImageSize", style: getTextStyle(device.api.setImageSize)),
                        Text("getImageSize", style: getTextStyle(device.api.getImageSize))
                      ]),
                      onTap: () => device.api.getImageSize(update: ForceUpdate.On),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<ImageSizeValue>(
                                hint: Text("available"),
                                items: device.cameraSettings.imageSize.available
                                    .map<DropdownMenuItem<ImageSizeValue>>(
                                        (e) => DropdownMenuItem<ImageSizeValue>(child: Text(e.name), value: e))
                                    .toList(),
                                onChanged: (value) => device.api.setImageSize(value),
                              ))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<ImageSizeValue>(
                                hint: Text("supported"),
                                items: device.cameraSettings.imageSize.supported
                                    .map<DropdownMenuItem<ImageSizeValue>>(
                                        (e) => DropdownMenuItem<ImageSizeValue>(child: Text(e.name), value: e))
                                    .toList(),
                                onChanged: (value) => device.api.setImageSize(value),
                              ))),
                    ]),
                  ]),
                )));
  }

  ///Aspect Ratio
  Widget getAspectRatioRow() {
    return ListenableProvider<SettingsItem>(
        create: (context) => device.cameraSettings.aspectRatio,
        child: Consumer<SettingsItem>(
            builder: (context, model, _) => Card(
                  child: Column(children: [
                    ListTile(
                      title: Text(ItemId.ImageFileFormat.name),
                      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(device.cameraSettings.aspectRatio.value?.name ?? "NotAvailable",
                            textAlign: TextAlign.start),
                        Text("setAspectRatio", style: getTextStyle(device.api.setAspectRatio)),
                        Text("getAspectRatio", style: getTextStyle(device.api.getAspectRatio))
                      ]),
                      onTap: () => device.api.getAspectRatio(update: ForceUpdate.On),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<AspectRatioValue>(
                                hint: Text("available"),
                                items: device.cameraSettings.aspectRatio.available
                                    .map<DropdownMenuItem<AspectRatioValue>>(
                                        (e) => DropdownMenuItem<AspectRatioValue>(child: Text(e.name), value: e))
                                    .toList(),
                                onChanged: (value) => device.api.setAspectRatio(value),
                              ))),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<AspectRatioValue>(
                                hint: Text("supported"),
                                items: device.cameraSettings.aspectRatio.supported
                                    .map<DropdownMenuItem<AspectRatioValue>>(
                                        (e) => DropdownMenuItem<AspectRatioValue>(child: Text(e.name), value: e))
                                    .toList(),
                                onChanged: (value) => device.api.setAspectRatio(value),
                              ))),
                    ]),
                  ]),
                )));
  }
}
