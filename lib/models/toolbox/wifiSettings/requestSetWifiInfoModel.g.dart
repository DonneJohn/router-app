// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestSetWifiInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestSetWifiInfoModel _$RequestSetWifiInfoModelFromJson(
    Map<String, dynamic> json) {
  return RequestSetWifiInfoModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RequestSetWifiInfoModelToJson(
        RequestSetWifiInfoModel instance) =>
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
    json['type'] as String,
    json['status'] as String,
    json['ssid'] as String,
    json['hidden'] as String,
    json['channel'] as String,
    json['bandwidth'] as String,
    json['power'] as String,
    json['signal'] as String,
    json['security'] as String,
    json['secret'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{
    'type': instance.type,
    'status': instance.status,
    'ssid': instance.ssid,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('hidden', instance.hidden);
  writeNotNull('channel', instance.channel);
  writeNotNull('bandwidth', instance.bandwidth);
  writeNotNull('power', instance.power);
  writeNotNull('signal', instance.signal);
  writeNotNull('security', instance.security);
  writeNotNull('secret', instance.secret);
  return val;
}
