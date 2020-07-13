// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sony_api_method_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SonyApiMethodSet _$SonyApiMethodSetFromJson(Map<String, dynamic> json) {
  return SonyApiMethodSet(
    (json['webApiMethods'] as List)
        ?.map((e) =>
            e == null ? null : WebApiMethod.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$SonyApiMethodSetToJson(SonyApiMethodSet instance) =>
    <String, dynamic>{
      'webApiMethods': instance.webApiMethods,
    };

WebApiMethod _$WebApiMethodFromJson(Map<String, dynamic> json) {
  return WebApiMethod(
    const SonyWebApiMethodConverter().fromJson(json['apiName'] as String),
    (json['parameterTypes'] as List)?.map((e) => e as String)?.toList(),
    (json['responseTypes'] as List)?.map((e) => e as String)?.toList(),
    json['version'] as String,
  );
}

Map<String, dynamic> _$WebApiMethodToJson(WebApiMethod instance) =>
    <String, dynamic>{
      'apiName': const SonyWebApiMethodConverter().toJson(instance.apiName),
      'parameterTypes': instance.parameterTypes,
      'responseTypes': instance.responseTypes,
      'version': instance.version,
    };
