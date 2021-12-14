// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getHostInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostInfoModel _$HostInfoModelFromJson(Map<String, dynamic> json) {
  return HostInfoModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HostInfoModelToJson(HostInfoModel instance) =>
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
    json['mac'] as String,
    json['name'] as String,
    json['nickname'] as String,
    json['type'] as String,
    json['vendor'] as String,
    json['model'] as String,
    json['linkType'] as String,
    json['linkTime'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'mac': instance.mac,
      'name': instance.name,
      'nickname': instance.nickname,
      'type': instance.type,
      'vendor': instance.vendor,
      'model': instance.model,
      'linkType': instance.linkType,
      'linkTime': instance.linkTime,
      'address': instance.address,
    };
