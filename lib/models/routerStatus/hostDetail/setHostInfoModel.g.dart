// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setHostInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetHostInfoModel _$SetHostInfoModelFromJson(Map<String, dynamic> json) {
  return SetHostInfoModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetHostInfoModelToJson(SetHostInfoModel instance) =>
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
    host: json['host'] as String,
    info: json['info'] == null
        ? null
        : Info.fromJson(json['info'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'host': instance.host,
      'info': instance.info,
    };

Info _$InfoFromJson(Map<String, dynamic> json) {
  return Info(
    nickname: json['nickname'] as String,
    type: json['type'] as String,
    vendor: json['vendor'] as String,
    model: json['model'] as String,
  );
}

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'nickname': instance.nickname,
      'type': instance.type,
      'vendor': instance.vendor,
      'model': instance.model,
    };
