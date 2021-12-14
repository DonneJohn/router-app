// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updateHostDetailRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateHostDetailRequestModel _$UpdateHostDetailRequestModelFromJson(
    Map<String, dynamic> json) {
  return UpdateHostDetailRequestModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UpdateHostDetailRequestModelToJson(
        UpdateHostDetailRequestModel instance) =>
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
    json['host'] as String,
    nickname: json['nickname'] as String,
    onlineAlert: json['onlineAlert'] as String,
    storageAccess: json['storageAccess'] as String,
    inBlacklist: json['inBlacklist'] as String,
    ratelimit: json['ratelimit'] == null
        ? null
        : Ratelimit.fromJson(json['ratelimit'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{
    'host': instance.host,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nickname', instance.nickname);
  writeNotNull('onlineAlert', instance.onlineAlert);
  writeNotNull('storageAccess', instance.storageAccess);
  writeNotNull('inBlacklist', instance.inBlacklist);
  writeNotNull('ratelimit', instance.ratelimit);
  return val;
}

Ratelimit _$RatelimitFromJson(Map<String, dynamic> json) {
  return Ratelimit(
    status: json['status'] as String,
    upstream: json['upstream'] as String,
    downstream: json['downstream'] as String,
  );
}

Map<String, dynamic> _$RatelimitToJson(Ratelimit instance) {
  final val = <String, dynamic>{
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('upstream', instance.upstream);
  writeNotNull('downstream', instance.downstream);
  return val;
}
