import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/sonyalphacontrol.dart';

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
            appBar: AppBar(),
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

                      ///ShootingMode (set, get, getSupported, getAvailable)
                      getShootingModeRow(),

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
                      getLiveViewInfoRow(),

                      ///SilentShootingSettings (set, get, getSupported, getAvailable)
                      getSilentShootingSettings()
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

  //service, function, method
  //green = supported and available
  //orange = supported and not available
  //red = unsupported
  Widget getText(ItemId itemId, ApiMethodId apiMethodId,
      {SonyWebApiServiceTypeId serviceId = SonyWebApiServiceTypeId.CAMERA}) {
    Color color = Colors.black12;

    switch (device.api.checkFunction(itemId, apiMethodId, service: serviceId)) {
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

    return Text(apiMethodId.name, style: TextStyle(color: color));
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
                        children: [getText(ItemId.Versions, ApiMethodId.GET)]),
                    onTap: () => device.api.getWebApiVersions(
                        SonyWebApiServiceTypeId.CAMERA,
                        update: ForceUpdate.On)),
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
                                    .cameraSettings.versionsCamera.values
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
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          getText(ItemId.Versions, ApiMethodId.GET,
                              serviceId: SonyWebApiServiceTypeId.AV_CONTENT)
                        ]),
                    onTap: () => device.api.getWebApiVersions(
                        SonyWebApiServiceTypeId.AV_CONTENT,
                        update: ForceUpdate.On)),
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
                                    .cameraSettings.versionsAvContent.values
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
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          getText(ItemId.Versions, ApiMethodId.GET,
                              serviceId: SonyWebApiServiceTypeId.SYSTEM)
                        ]),
                    onTap: () => device.api.getWebApiVersions(
                        SonyWebApiServiceTypeId.SYSTEM,
                        update: ForceUpdate.On)),
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
                                    .cameraSettings.versionsSystem.values
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
                          getText(ItemId.Versions, ApiMethodId.GET,
                              serviceId: SonyWebApiServiceTypeId.GUIDE)
                        ]),
                    onTap: () => device.api.getWebApiVersions(
                        SonyWebApiServiceTypeId.GUIDE,
                        update: ForceUpdate.On)),
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
                          getText(ItemId.Versions, ApiMethodId.GET,
                              serviceId: SonyWebApiServiceTypeId.ACCESS_CONTROL)
                        ]),
                    onTap: () => device.api.getWebApiVersions(
                        SonyWebApiServiceTypeId.ACCESS_CONTROL,
                        update: ForceUpdate.On)),
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
                    children: [getText(ItemId.MethodTypes, ApiMethodId.GET)]),
                onTap: () => device.api.getMethodTypes(
                    SonyWebApiServiceTypeId.CAMERA,
                    update: ForceUpdate.On)),
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
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  getText(ItemId.MethodTypes, ApiMethodId.GET,
                      serviceId: SonyWebApiServiceTypeId.AV_CONTENT)
                ]),
                onTap: () => device.api.getMethodTypes(
                    SonyWebApiServiceTypeId.AV_CONTENT,
                    update: ForceUpdate.On)),
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
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  getText(ItemId.MethodTypes, ApiMethodId.GET,
                      serviceId: SonyWebApiServiceTypeId.SYSTEM)
                ]),
                onTap: () => device.api.getMethodTypes(
                    SonyWebApiServiceTypeId.SYSTEM,
                    update: ForceUpdate.On)),
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
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  getText(ItemId.MethodTypes, ApiMethodId.GET,
                      serviceId: SonyWebApiServiceTypeId.GUIDE)
                ]),
                onTap: () => device.api.getMethodTypes(
                    SonyWebApiServiceTypeId.GUIDE,
                    update: ForceUpdate.On)),
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
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  getText(ItemId.MethodTypes, ApiMethodId.GET,
                      serviceId: SonyWebApiServiceTypeId.ACCESS_CONTROL)
                ]),
                onTap: () => device.api.getMethodTypes(
                    SonyWebApiServiceTypeId.ACCESS_CONTROL,
                    update: ForceUpdate.On)),
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
                title: Text(ItemId.ApiList.name),
                subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      getText(ItemId.ApiList, ApiMethodId.GET_AVAILABLE)
                    ]),
                onTap: () =>
                    device.api.getAvailableFunctions(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<ApiFunctionValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.availableFunctions.values
                            .map<DropdownMenuItem<ApiFunctionValue>>((e) =>
                                DropdownMenuItem<ApiFunctionValue>(
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
                    children: [
                      getText(ItemId.ApplicationInfo, ApiMethodId.GET)
                    ]),
                onTap: () =>
                    device.api.getApplicationInfo(update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<StringValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.applicationInfo.values
                            .map<DropdownMenuItem<StringValue>>((e) =>
                                DropdownMenuItem<StringValue>(
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
                    children: [
                      getText(ItemId.AvailableSettings, ApiMethodId.GET)
                    ]),
                onTap: () => device.api
                    .getAvailableSettings(false, update: ForceUpdate.On)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<StringValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.availableSettings.values
                            .map<DropdownMenuItem<StringValue>>((e) =>
                                DropdownMenuItem<StringValue>(
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

  ///CameraFunction (set, get, getSupported, getAvailable)
  Widget getCameraFunctionsRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.cameraFunction,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.CameraFunction.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.cameraFunction.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    getText(ItemId.CameraFunction, ApiMethodId.SET),
                    getText(ItemId.CameraFunction, ApiMethodId.GET),
                    getText(ItemId.CameraFunction, ApiMethodId.GET_AVAILABLE),
                    getText(ItemId.CameraFunction, ApiMethodId.GET_SUPPORTED)
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
                    children: [getText(ItemId.CapturePhoto, ApiMethodId.ACT)]),
                onTap: () => device.api.actCapturePhoto()),
            ListTile(
              title: Text(ItemId.CapturePhoto.name + " AWAIT"),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [getText(ItemId.CapturePhoto, ApiMethodId.AWAIT)]),
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
                    children: [getText(ItemId.CameraSetup, ApiMethodId.START)]),
                onTap: () => device.api.startRecMode()),
            ListTile(
              title: Text(ItemId.CameraSetup.name + " STOP"),
              subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [getText(ItemId.CameraSetup, ApiMethodId.STOP)]),
              onTap: () => device.api.stopRecMode(),
            )
          ]),
        ),
      ),
    );
  }

  ///LiveView (start, stop)
  Widget getLiveViewRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.liveView,
      //TODO availabilty of functions?
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.LiveView.name),
              subtitle: Text(
                  device.cameraSettings.liveView.value?.name ?? "NotAvailable"),
            ),
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
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          device.cameraSettings.zoom.value?.name ??
                              "NotAvailable",
                          textAlign: TextAlign.start),
                      getText(ItemId.Zoom, ApiMethodId.ACT)
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
        //TODO Info item? is act is cancele
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
                          children: [
                            getText(ItemId.HalfPressShutter, ApiMethodId.ACT)
                          ]),
                      onTap: () => device.api.actHalfPressShutter()),
                ),
                Expanded(
                  child: ListTile(
                      title: Text(ItemId.HalfPressShutter.name + " CANCEL"),
                      subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            getText(ItemId.HalfPressShutter, ApiMethodId.CANCEL)
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
                    Text(
                        device.cameraSettings.selfTimer.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    getText(ItemId.SelfTimer, ApiMethodId.SET),
                    getText(ItemId.SelfTimer, ApiMethodId.GET),
                    getText(ItemId.SelfTimer, ApiMethodId.GET_AVAILABLE),
                    getText(ItemId.SelfTimer, ApiMethodId.GET_SUPPORTED)
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
              subtitle: Text(
                  device.cameraSettings.contShootingMode.value?.name ??
                      "NotAvailable"),
            ),
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
              subtitle: Text(
                  device.cameraSettings.contShootingSpeed.value?.name ??
                      "NotAvailable"),
            ),
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
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        device.cameraSettings.meteringMode.value?.name ??
                            "NotAvailable",
                        textAlign: TextAlign.start),
                    getText(ItemId.MeteringMode, ApiMethodId.SET),
                    getText(ItemId.MeteringMode, ApiMethodId.GET),
                    getText(ItemId.MeteringMode, ApiMethodId.GET_AVAILABLE),
                    getText(ItemId.MeteringMode, ApiMethodId.GET_SUPPORTED)
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
      create: (context) => device.cameraSettings.ev,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.EV.name),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(device.cameraSettings.ev.value?.name ?? "NotAvailable",
                        textAlign: TextAlign.start),
                    getText(ItemId.EV, ApiMethodId.SET),
                    getText(ItemId.EV, ApiMethodId.GET),
                    getText(ItemId.EV, ApiMethodId.GET_AVAILABLE),
                    getText(ItemId.EV, ApiMethodId.GET_SUPPORTED)
                  ]),
              onTap: () => device.api.getEV(update: ForceUpdate.On),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: ListTile(
                    title: Text("Up"), onTap: () => device.api.modifyEV(1)),
              ),
              Expanded(
                child: ListTile(
                    title: Text("Down"), onTap: () => device.api.modifyEV(-1)),
              )
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<EvValue>(
                        hint: Text("available"),
                        items: device.cameraSettings.ev.available
                            .map<DropdownMenuItem<EvValue>>((e) =>
                                DropdownMenuItem<EvValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setEV(value),
                      ))),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<EvValue>(
                        hint: Text("supported"),
                        items: device.cameraSettings.ev.supported
                            .map<DropdownMenuItem<EvValue>>((e) =>
                                DropdownMenuItem<EvValue>(
                                    child: Text(e.name), value: e))
                            .toList(),
                        onChanged: (value) => device.api.setEV(value),
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
                            getText(ItemId.FNumber, ApiMethodId.SET),
                            getText(ItemId.FNumber, ApiMethodId.GET),
                            getText(ItemId.FNumber, ApiMethodId.GET_AVAILABLE),
                            getText(ItemId.FNumber, ApiMethodId.GET_SUPPORTED)
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
                      title: Text(ItemId.ISO.name),
                      subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                device.cameraSettings.iso.value?.name ??
                                    "NotAvailable",
                                textAlign: TextAlign.start),
                            getText(ItemId.ISO, ApiMethodId.SET),
                            getText(ItemId.ISO, ApiMethodId.GET),
                            getText(ItemId.ISO, ApiMethodId.GET_AVAILABLE),
                            getText(ItemId.ISO, ApiMethodId.GET_SUPPORTED)
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
                            getText(ItemId.LiveViewWithSize, ApiMethodId.START),
                            //Start live view with size //TODO result is url where stored
                            getText(ItemId.LiveViewSize, ApiMethodId.GET),
                            getText(
                                ItemId.LiveViewSize, ApiMethodId.GET_AVAILABLE),
                            getText(
                                ItemId.LiveViewSize, ApiMethodId.GET_SUPPORTED)
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
                            getText(ItemId.PostViewImageSize, ApiMethodId.SET),
                            getText(ItemId.PostViewImageSize, ApiMethodId.GET),
                            getText(ItemId.PostViewImageSize,
                                ApiMethodId.GET_AVAILABLE),
                            getText(ItemId.PostViewImageSize,
                                ApiMethodId.GET_SUPPORTED)
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
                            getText(ItemId.ProgramShift, ApiMethodId.SET),
                            getText(ItemId.ProgramShift, ApiMethodId.GET),
                            getText(
                                ItemId.ProgramShift, ApiMethodId.GET_AVAILABLE),
                            getText(
                                ItemId.ProgramShift, ApiMethodId.GET_SUPPORTED)
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

  ///ShootingMode (set, get, getSupported, getAvailable)
  Widget getShootingModeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.shootingMode,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ShootingMode.name),
              subtitle: Text(device.cameraSettings.shootingMode.value?.name ??
                  "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
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
              subtitle: Text(device.cameraSettings.shutterSpeed.value?.name ??
                  "NotAvailable"),
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
              subtitle: Text(device.cameraSettings.focusAreaSpot.value?.name ??
                  "NotAvailable"),
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
              subtitle: Text(
                  device.cameraSettings.whiteBalanceMode.value?.name ??
                      "NotAvailable"),
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

  Widget getWhiteBalanceColorTempRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.whiteBalanceColorTemp,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.WhiteBalanceColorTemp.name),
              subtitle: Text(
                  device.cameraSettings.whiteBalanceColorTemp.value?.name ??
                      "NotAvailable"),
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
              subtitle: Text(device.cameraSettings.flashMode.value?.name ??
                  "NotAvailable"),
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
              subtitle: Text(device.cameraSettings.focusMode.value?.name ??
                  "NotAvailable"),
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
                    getText(ItemId.ZoomSetting, ApiMethodId.SET),
                    getText(ItemId.ZoomSetting, ApiMethodId.GET),
                    getText(ItemId.ZoomSetting, ApiMethodId.GET_AVAILABLE),
                    getText(ItemId.ZoomSetting, ApiMethodId.GET_SUPPORTED)
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
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.storageInformation,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.StorageInformation.name),
              subtitle: Text(
                  device.cameraSettings.storageInformation.value?.name ??
                      "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
  }

  ///LiveViewInfo (set, get)
  Widget getLiveViewInfoRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.liveViewInfo,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.LiveViewInfo.name),
              subtitle: Text(device.cameraSettings.liveViewInfo.value?.name ??
                  "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
  }

  ///SilentShootingSettings (set, get, getSupported, getAvailable)
  Widget getSilentShootingSettings() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.silentShootingSettings,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.SilentShootingSettings.name),
              subtitle: Text(
                  device.cameraSettings.silentShootingSettings.value?.name ??
                      "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
  }
}
