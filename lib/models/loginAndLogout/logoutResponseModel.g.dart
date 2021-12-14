// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logoutResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogoutResponseModel _$LogoutResponseModelFromJson(Map<String, dynamic> json) {
  return LogoutResponseModel(
    json['code'] as int,
    json['result'] as String,
  );
}

Map<String, dynamic> _$LogoutResponseModelToJson(
        LogoutResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'result': instance.result,
    };
