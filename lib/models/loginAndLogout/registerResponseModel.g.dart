// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registerResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
    Map<String, dynamic> json) {
  return RegisterResponseModel(
    code: json['code'] as int,
    result: json['result'] as String,
    reason: json['reason'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RegisterResponseModelToJson(
    RegisterResponseModel instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'result': instance.result,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reason', instance.reason);
  writeNotNull('data', instance.data);
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['token'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'token': instance.token,
    };
