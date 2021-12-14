// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getHostsListResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostsListResponse _$HostsListResponseFromJson(Map<String, dynamic> json) {
  return HostsListResponse(
    errorCode: json['errorCode'] as int,
    version: json['version'] as String,
    sender: json['sender'] as String,
    receiver: json['receiver'] as String,
    return_parameter: json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HostsListResponseToJson(HostsListResponse instance) {
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
    (json['hosts'] as List)
        ?.map(
            (e) => e == null ? null : Host.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'hosts': instance.hosts,
    };

Host _$HostFromJson(Map<String, dynamic> json) {
  return Host(
    json['mac'] as String,
    json['name'] as String,
    json['nickname'] as String,
    json['status'] as String,
    json['address'] as String,
    json['type'] as String,
    json['internetAccess'] as String,
    json['runningRate'] == null
        ? null
        : RunningRate.fromJson(json['runningRate'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HostToJson(Host instance) => <String, dynamic>{
      'mac': instance.mac,
      'name': instance.name,
      'nickname': instance.nickname,
      'status': instance.status,
      'address': instance.address,
      'type': instance.type,
      'internetAccess': instance.internetAccess,
      'runningRate': instance.runningRate,
    };

RunningRate _$RunningRateFromJson(Map<String, dynamic> json) {
  return RunningRate(
    json['upstream'] as String,
    json['downstream'] as String,
  );
}

Map<String, dynamic> _$RunningRateToJson(RunningRate instance) =>
    <String, dynamic>{
      'upstream': instance.upstream,
      'downstream': instance.downstream,
    };
