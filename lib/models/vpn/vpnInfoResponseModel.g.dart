// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vpnInfoResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VpnInfoResponseModel _$VpnInfoResponseModelFromJson(Map<String, dynamic> json) {
  return VpnInfoResponseModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VpnInfoResponseModelToJson(
        VpnInfoResponseModel instance) =>
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
    json['id'] as String,
    json['name'] as String,
    json['protocol'] as String,
    json['server'] as String,
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'protocol': instance.protocol,
      'server': instance.server,
      'username': instance.username,
      'password': instance.password,
    };
