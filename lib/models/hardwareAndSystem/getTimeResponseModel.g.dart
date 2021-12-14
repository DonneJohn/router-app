// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getTimeResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTimeResponseModel _$GetTimeResponseModelFromJson(Map<String, dynamic> json) {
  return GetTimeResponseModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : Parameter.fromJson(json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetTimeResponseModelToJson(
        GetTimeResponseModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'return_parameter': instance.return_parameter,
    };

Parameter _$ParameterFromJson(Map<String, dynamic> json) {
  return Parameter(
    json['type'] as String,
    json['sequence'] as String,
    json['status'] as String,
    json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
      'type': instance.type,
      'sequence': instance.sequence,
      'status': instance.status,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['timezone'] as String,
    json['date'] == null
        ? null
        : Date.fromJson(json['date'] as Map<String, dynamic>),
    json['time'] == null
        ? null
        : Time.fromJson(json['time'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'timezone': instance.timezone,
      'date': instance.date,
      'time': instance.time,
    };

Date _$DateFromJson(Map<String, dynamic> json) {
  return Date(
    json['year'] as String,
    json['month'] as String,
    json['day'] as String,
  );
}

Map<String, dynamic> _$DateToJson(Date instance) => <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
    };

Time _$TimeFromJson(Map<String, dynamic> json) {
  return Time(
    json['hour'] as String,
    json['minute'] as String,
  );
}

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
    };
