// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identifyingCodeModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdentifyingCodeModel _$IdentifyingCodeModelFromJson(Map<String, dynamic> json) {
  return IdentifyingCodeModel(
    code: json['code'] as int,
    result: json['result'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IdentifyingCodeModelToJson(
    IdentifyingCodeModel instance) {
  final val = <String, dynamic>{
    'code': instance.code,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', instance.result);
  writeNotNull('data', instance.data);
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['code'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  return val;
}
