// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commonRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonRequestModel _$CommonRequestModelFromJson(Map<String, dynamic> json) {
  return CommonRequestModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommonRequestModelToJson(CommonRequestModel instance) =>
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
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ParameterToJson(Parameter instance) {
  final val = <String, dynamic>{
    'type': instance.type,
    'sequence': instance.sequence,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    type: json['type'] as String,
    host: json['host'] as String,
    id: json['id'] as String,
    protocol: json['protocol'] as String,
    name: json['name'] as String,
    server: json['server'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
    status: json['status'] as String,
    policy: json['policy'] as String,
    timezone: json['timezone'] as String,
    timing: (json['timing'] as List)
        ?.map((e) =>
            e == null ? null : Timing.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('host', instance.host);
  writeNotNull('type', instance.type);
  writeNotNull('id', instance.id);
  writeNotNull('protocol', instance.protocol);
  writeNotNull('name', instance.name);
  writeNotNull('server', instance.server);
  writeNotNull('username', instance.username);
  writeNotNull('password', instance.password);
  writeNotNull('status', instance.status);
  writeNotNull('policy', instance.policy);
  writeNotNull('timezone', instance.timezone);
  writeNotNull('timing', instance.timing);
  return val;
}

Timing _$TimingFromJson(Map<String, dynamic> json) {
  return Timing(
    id: json['id'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$TimingToJson(Timing instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
    };
