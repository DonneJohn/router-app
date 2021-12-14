// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getListCronRebootResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetListCronRebootResponseModel _$GetListCronRebootResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetListCronRebootResponseModel(
    json['errorCode'] as int,
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetListCronRebootResponseModelToJson(
        GetListCronRebootResponseModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'return_parameter': instance.return_parameter,
    };

ReturnParameter _$ReturnParameterFromJson(Map<String, dynamic> json) {
  return ReturnParameter(
    json['type'] as String,
    json['sequence'] as String,
    json['status'] as String,
    json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReturnParameterToJson(ReturnParameter instance) =>
    <String, dynamic>{
      'type': instance.type,
      'sequence': instance.sequence,
      'status': instance.status,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    (json['schedules'] as List)
        ?.map((e) =>
            e == null ? null : Schedule.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'schedules': instance.schedules,
    };

Schedule _$ScheduleFromJson(Map<String, dynamic> json) {
  return Schedule(
    json['id'] as String,
    json['status'] as String,
    json['repeat'] == null
        ? null
        : Repeat.fromJson(json['repeat'] as Map<String, dynamic>),
    json['time'] as String,
  );
}

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'repeat': instance.repeat,
      'time': instance.time,
    };

Repeat _$RepeatFromJson(Map<String, dynamic> json) {
  return Repeat(
    json['type'] as String,
    json['weekdays'] as String,
  );
}

Map<String, dynamic> _$RepeatToJson(Repeat instance) => <String, dynamic>{
      'type': instance.type,
      'weekdays': instance.weekdays,
    };
