// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setSmartRateLimitRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetSmartRateLimitRequestModel _$SetSmartRateLimitRequestModelFromJson(
    Map<String, dynamic> json) {
  return SetSmartRateLimitRequestModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetSmartRateLimitRequestModelToJson(
        SetSmartRateLimitRequestModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'parameter': instance.parameter,
    };

Parameter _$ParameterFromJson(Map<String, dynamic> json) {
  return Parameter(
    json['type'] as String,
    json['sequence'] as String,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
      'type': instance.type,
      'sequence': instance.sequence,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['status'] as String,
    json['policy'] as String,
    json['bandwidth'] == null
        ? null
        : Bandwidth.fromJson(json['bandwidth'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'status': instance.status,
      'policy': instance.policy,
      'bandwidth': instance.bandwidth,
    };

Bandwidth _$BandwidthFromJson(Map<String, dynamic> json) {
  return Bandwidth(
    json['downstream'] as String,
    json['upstream'] as String,
  );
}

Map<String, dynamic> _$BandwidthToJson(Bandwidth instance) => <String, dynamic>{
      'downstream': instance.downstream,
      'upstream': instance.upstream,
    };
