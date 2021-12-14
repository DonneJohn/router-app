// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceRunningStatusModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRunningStatusModel _$DeviceRunningStatusModelFromJson(
    Map<String, dynamic> json) {
  return DeviceRunningStatusModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
    json['errorCode'] as int,
  );
}

Map<String, dynamic> _$DeviceRunningStatusModelToJson(
    DeviceRunningStatusModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('errorCode', instance.errorCode);
  writeNotNull('version', instance.version);
  writeNotNull('sender', instance.sender);
  writeNotNull('receiver', instance.receiver);
  writeNotNull('return_parameter', instance.return_parameter);
  return val;
}

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
    json['version'] as String,
    json['uptime'] as int,
    json['downstreamRate'] as String,
    json['downstreamMaxRate'] as String,
    json['upstreamRate'] as String,
    json['upstreamMaxRate'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'version': instance.version,
      'uptime': instance.uptime,
      'downstreamRate': instance.downstreamRate,
      'downstreamMaxRate': instance.downstreamMaxRate,
      'upstreamRate': instance.upstreamRate,
      'upstreamMaxRate': instance.upstreamMaxRate,
    };
