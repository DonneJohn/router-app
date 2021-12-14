// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setRebootScheduleRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetRebootScheduleRequestModel _$SetRebootScheduleRequestModelFromJson(
    Map<String, dynamic> json) {
  return SetRebootScheduleRequestModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetRebootScheduleRequestModelToJson(
        SetRebootScheduleRequestModel instance) =>
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
    (json['schedules'] as List)
        ?.map((e) =>
            e == null ? null : Schedule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'schedules': instance.schedules,
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    id: json['id'] as String,
    status: json['status'] as String,
    repeat: json['repeat'] == null
        ? null
        : Repeat.fromJson(json['repeat'] as Map<String, dynamic>),
    time: json['time'] as String,
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('repeat', instance.repeat);
  val['time'] = instance.time;
  return val;
}

Repeat _$RepeatFromJson(Map<String, dynamic> json) {
  return Repeat(
    type: json['type'] as String,
    weekdays: json['weekdays'] as String,
  );
}

Map<String, dynamic> _$RepeatToJson(Repeat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  val['weekdays'] = instance.weekdays;
  return val;
}
