// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestUpdateInternetConnect3Model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUpdateInternetConnect3Model _$RequestUpdateInternetConnect3ModelFromJson(
    Map<String, dynamic> json) {
  return RequestUpdateInternetConnect3Model(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RequestUpdateInternetConnect3ModelToJson(
        RequestUpdateInternetConnect3Model instance) =>
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
    (json['timing'] as List)
        ?.map((e) =>
            e == null ? null : Timing.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'host': instance.host,
      'timing': instance.timing,
    };

Timing _$TimingFromJson(Map<String, dynamic> json) {
  return Timing(
    id: json['id'] as String,
    status: json['status'] as String,
    repeat: json['repeat'] == null
        ? null
        : Repeat.fromJson(json['repeat'] as Map<String, dynamic>),
    start: json['start'] as String,
    end: json['end'] as String,
  );
}

Map<String, dynamic> _$TimingToJson(Timing instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'repeat': instance.repeat,
      'start': instance.start,
      'end': instance.end,
    };

Repeat _$RepeatFromJson(Map<String, dynamic> json) {
  return Repeat(
    type: json['type'] as String,
    weekdays: json['weekdays'] as String,
  );
}

Map<String, dynamic> _$RepeatToJson(Repeat instance) => <String, dynamic>{
      'type': instance.type,
      'weekdays': instance.weekdays,
    };
