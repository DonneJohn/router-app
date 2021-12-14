// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bindRouterResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BindRouterResponseModel _$BindRouterResponseModelFromJson(
    Map<String, dynamic> json) {
  return BindRouterResponseModel(
    code: json['code'] as int,
    result: json['result'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BindRouterResponseModelToJson(
    BindRouterResponseModel instance) {
  final val = <String, dynamic>{
    'code': instance.code,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', instance.result);
  writeNotNull('data', instance.data);
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['uuid'] as String,
    json['type'] as String,
    json['operator'] as String,
    json['agent_host'] as String,
    json['agent_port'] as int,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'type': instance.type,
      'operator': instance.operator,
      'agent_host': instance.agent_host,
      'agent_port': instance.agent_port,
    };
