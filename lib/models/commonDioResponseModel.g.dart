// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commonDioResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonDioResponseModel _$CommonDioResponseModelFromJson(
    Map<String, dynamic> json) {
  return CommonDioResponseModel(
    code: json['code'] as int,
    result: json['result'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommonDioResponseModelToJson(
    CommonDioResponseModel instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'result': instance.result,
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
    json['avator'] as String,
    json['nickname'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('avator', instance.avator);
  writeNotNull('nickname', instance.nickname);
  return val;
}
