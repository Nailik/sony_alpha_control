import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sonyalphacontrol/top_level_api/api/force_update.dart';
import 'package:sonyalphacontrol/top_level_api/api/sony_api.dart';
import 'package:sonyalphacontrol/top_level_api/device/camera_settings.dart';
import 'package:sonyalphacontrol/top_level_api/device/settings_item.dart';
import 'package:sonyalphacontrol/top_level_api/device/sony_camera_device.dart';
import 'package:sonyalphacontrol/top_level_api/device/value.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_service_type_ids.dart';

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

                      ///MethodTypes (get) camera
                      getMethodTypesRowCamera(),

                      ///MethodTypes (get) avContent
                      getMethodTypesRowAvContent(),

                      ///MethodTypes (get) system
                      getMethodTypesRowSystem(),

                      ///MethodTypes (get) guide
                      getMethodTypesRowGuide(),

                      ///ApplicationInfo (get)
                      getApplicationInfoRow(),

                      ///ApiList (getAvailable)
                      getApiListRow(),

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

                      ///LiveViewWithSize (start)
                      getLiveViewWithSizeRow(),

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

  ///Versions (get) Camera
  Widget getVersionsRowCamera() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.versionsCamera,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " Camera"),
                    onTap: () => device.api
                        .getWebApiVersions(SonyWebApiServiceTypeId.CAMERA)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<WebApiVersionsValue>(
                                hint: Text("available"),
                                items: device
                                    .cameraSettings.versionsCamera.available
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
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.versionsAvContent,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " AvContent"),
                    onTap: () => device.api
                        .getWebApiVersions(SonyWebApiServiceTypeId.AV_CONTENT)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<WebApiVersionsValue>(
                                hint: Text("available"),
                                items: device
                                    .cameraSettings.versionsAvContent.available
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
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.versionsSystem,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " System"),
                    onTap: () => device.api
                        .getWebApiVersions(SonyWebApiServiceTypeId.SYSTEM)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<WebApiVersionsValue>(
                                hint: Text("available"),
                                items: device
                                    .cameraSettings.versionsSystem.available
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
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.versionsGuide,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    title: Text(ItemId.Versions.name + " Guide"),
                    onTap: () => device.api
                        .getWebApiVersions(SonyWebApiServiceTypeId.GUIDE)),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(16),
                              child: DropdownButton<WebApiVersionsValue>(
                                hint: Text("available"),
                                items: device
                                    .cameraSettings.versionsGuide.available
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
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.methodTypesCamera,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " Camera"),
                onTap: () =>
                    device.api.getMethodTypes(SonyWebApiServiceTypeId.CAMERA)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.methodTypesCamera.available
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
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.methodTypesAvContent,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " AvContent"),
                onTap: () => device.api
                    .getMethodTypes(SonyWebApiServiceTypeId.AV_CONTENT)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device
                            .cameraSettings.methodTypesAvContent.available
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
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.methodTypesSystem,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " System"),
                onTap: () =>
                    device.api.getMethodTypes(SonyWebApiServiceTypeId.SYSTEM)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.methodTypesSystem.available
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
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.methodTypesGuide,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
                title: Text(ItemId.MethodTypes.name + " Guide"),
                onTap: () =>
                    device.api.getMethodTypes(SonyWebApiServiceTypeId.GUIDE)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: DropdownButton<WebApiMethodValue>(
                        isExpanded: true,
                        hint: Text("available"),
                        items: device.cameraSettings.methodTypesGuide.available
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

  ///ApplicationInfo (get)
  Widget getApplicationInfoRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.applicationInfo,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ApplicationInfo.name),
              subtitle: Text(
                  device.cameraSettings.applicationInfo.value?.name ??
                      "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
  }

  ///ApiList (getAvailable)
  Widget getApiListRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.apiList,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.ApiList.name),
              subtitle: Text(
                  device.cameraSettings.apiList.value?.name ?? "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
  }

  ///AvailableSettings (get)
  Widget getAvailableSettingsRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.availableSettings,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.AvailableSettings.name),
              subtitle: Text(
                  device.cameraSettings.availableSettings.value?.name ??
                      "NotAvailable"),
            ),
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
              subtitle: Text(device.cameraSettings.cameraFunction.value?.name ??
                  "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
  }

  ///CapturePhoto (act)
  Widget getCapturePhotoRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.capturePhoto,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.CapturePhoto.name),
              subtitle: Text(device.cameraSettings.capturePhoto.value?.name ??
                  "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
  }

  ///CameraSetup (stop)
  Widget getCameraSetupRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.cameraSetup,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.CameraSetup.name),
              subtitle: Text(device.cameraSettings.cameraSetup.value?.name ??
                  "NotAvailable"),
            ),
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

  ///LiveViewWithSize (start)
  Widget getLiveViewWithSizeRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.liveViewWithSize,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.LiveViewWithSize.name),
              subtitle: Text(
                  device.cameraSettings.liveViewWithSize.value?.name ??
                      "NotAvailable"),
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
              subtitle: Text(
                  device.cameraSettings.zoom.value?.name ?? "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
  }

  ///HalfPressShutter (act, cancel)
  Widget getHalfPressShutterRow() {
    return ListenableProvider<SettingsItem>(
      create: (context) => device.cameraSettings.halfPressShutter,
      child: Consumer<SettingsItem>(
        builder: (context, model, _) => Card(
          child: Column(children: [
            ListTile(
              title: Text(ItemId.HalfPressShutter.name),
              subtitle: Text(
                  device.cameraSettings.halfPressShutter.value?.name ??
                      "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
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
              subtitle: Text(device.cameraSettings.selfTimer.value?.name ??
                  "NotAvailable"),
            ),
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
              subtitle: Text(device.cameraSettings.meteringMode.value?.name ??
                  "NotAvailable"),
            ),
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
              subtitle:
                  Text(device.cameraSettings.ev.value?.name ?? "NotAvailable"),
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
                      subtitle: Text(
                          device.cameraSettings.fNumber.value?.name ??
                              "NotAvailable"),
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
                      subtitle: Text(device.cameraSettings.iso.value?.name ??
                          "NotAvailable"),
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
              subtitle: Text(device.cameraSettings.liveViewSize.value?.name ??
                  "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
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
              subtitle: Text(
                  device.cameraSettings.postViewImageSize.value?.name ??
                      "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
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
              subtitle: Text(device.cameraSettings.programShift.value?.name ??
                  "NotAvailable"),
            ),
          ]),
        ),
      ),
    );
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
              subtitle: Text(device.cameraSettings.zoomSetting.value?.name ??
                  "NotAvailable"),
            ),
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
