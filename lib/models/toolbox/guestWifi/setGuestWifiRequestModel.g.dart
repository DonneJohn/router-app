// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setGuestWifiRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetGuestWifiRequestModel _$SetGuestWifiRequestModelFromJson(
    Map<String, dynamic> json) {
  return SetGuestWifiRequestModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetGuestWifiRequestModelToJson(
        SetGuestWifiRequestModel instance) =>
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
    json['ssid'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'status': instance.status,
      'ssid': instance.ssid,
      'password': instance.password,
    };
