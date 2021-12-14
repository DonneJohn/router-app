// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getBindListResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBindListResponseModel _$GetBindListResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetBindListResponseModel(
    code: json['code'] as int,
    result: json['result'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BindDevice.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GetBindListResponseModelToJson(
        GetBindListResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'result': instance.result,
      'data': instance.data,
    };

BindDevice _$BindDeviceFromJson(Map<String, dynamic> json) {
  return BindDevice(
    json['mac'] as String,
    json['model'] as String,
    json['nickname'] as String,
    json['type'] as String,
    json['uuid'] as String,
  );
}

Map<String, dynamic> _$BindDeviceToJson(BindDevice instance) =>
    <String, dynamic>{
      'mac': instance.mac,
      'model': instance.model,
      'nickname': instance.nickname,
      'type': instance.type,
      'uuid': instance.uuid,
    };
