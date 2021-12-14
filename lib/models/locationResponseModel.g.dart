// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponseModel _$LocationResponseModelFromJson(
    Map<String, dynamic> json) {
  return LocationResponseModel(
    json['code'] as int,
    json['result'] as String,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LocationResponseModelToJson(
        LocationResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'result': instance.result,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['region'] as String,
    json['operator'] as String,
    json['agent_host'] as String,
    json['agent_port'] as int,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'region': instance.region,
      'operator': instance.operatorl,
      'agent_host': instance.agent_host,
      'agent_port': instance.agent_port,
    };
