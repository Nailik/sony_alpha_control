// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi_commands.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WifiCommand _$WifiCommandFromJson(Map<String, dynamic> json) {
  return WifiCommand(
    json['id'] as int,
    json['method'] as String,
    const WebApiVersionConverter().fromJson(json['version'] as String),
    json['params'] as List,
  );
}

Map<String, dynamic> _$WifiCommandToJson(WifiCommand instance) =>
    <String, dynamic>{
      'id': instance.id,
      'method': instance.method,
      'version': const WebApiVersionConverter().toJson(instance.version),
      'params': instance.params,
    };
