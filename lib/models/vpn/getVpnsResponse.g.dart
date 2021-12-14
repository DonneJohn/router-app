// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getVpnsResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVpnsResponse _$GetVpnsResponseFromJson(Map<String, dynamic> json) {
  return GetVpnsResponse(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetVpnsResponseToJson(GetVpnsResponse instance) =>
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
    json['policy'] as String,
    (json['vpn'] as List)
        ?.map((e) => e == null ? null : Vpn.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'policy': instance.policy,
      'vpn': instance.vpn,
    };

Vpn _$VpnFromJson(Map<String, dynamic> json) {
  return Vpn(
    json['id'] as String,
    json['name'] as String,
    json['protocol'] as String,
    json['server'] as String,
    json['status'] as String,
  );
}

Map<String, dynamic> _$VpnToJson(Vpn instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('protocol', instance.protocol);
  writeNotNull('server', instance.server);
  writeNotNull('status', instance.status);
  return val;
}
