// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getSmartRateLimitResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSmartRateLimitResponseModel _$GetSmartRateLimitResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetSmartRateLimitResponseModel(
    json['errorCode'] as int,
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetSmartRateLimitResponseModelToJson(
        GetSmartRateLimitResponseModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'return_parameter': instance.return_parameter,
    };

ReturnParameter _$ReturnParameterFromJson(Map<String, dynamic> json) {
  return ReturnParameter(
    json['type'] as String,
    json['sequence'] as String,
    json['status'] as String,
    json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReturnParameterToJson(ReturnParameter instance) =>
    <String, dynamic>{
      'type': instance.type,
      'sequence': instance.sequence,
      'status': instance.status,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['status'] as String,
    json['policy'] as String,
    json['bandwidth'] == null
        ? null
        : Bandwidth.fromJson(json['bandwidth'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
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
