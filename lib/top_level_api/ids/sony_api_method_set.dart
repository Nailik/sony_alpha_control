import 'package:collection/collection.dart';
import 'package:sonyalphacontrol/top_level_api/ids/setting_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/sony_web_api_method_ids.dart';
import 'package:sonyalphacontrol/top_level_api/ids/web_api_version_ids.dart';

class WebApiMethod {
  final SonyWebApiMethodId apiName;

  final SettingsId settingsId;
  final List<String> parameterTypes;
  final List<String> responseTypes;
  final WebApiVersionId
      version; //all the versions that are available for this method

  WebApiMethod(this.apiName, this.settingsId, this.parameterTypes,
      this.responseTypes, this.version);

  @override
  bool operator ==(o) =>
      o is WebApiMethod &&
      settingsId == o.settingsId &&
      apiName == o.apiName &&
      const ListEquality().equals(parameterTypes, o.parameterTypes) &&
      const ListEquality().equals(responseTypes, o.responseTypes) &&
      version == o.version;

  // \n parameterTypes: \n $parameterTypes \n responseTypes: \n $responseTypes";
  @override
  String toString() =>
      "apiName: $apiName settingsId: $settingsId version: $version";

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
