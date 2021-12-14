// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addInternetConnectRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddInternetConnectRequestModel _$AddInternetConnectRequestModelFromJson(
    Map<String, dynamic> json) {
  return AddInternetConnectRequestModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddInternetConnectRequestModelToJson(
        AddInternetConnectRequestModel instance) =>
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
    timing: (json['timing'] as List)
        ?.map((e) => e == null
            ? null
            : TimingRequestModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'host': instance.host,
      'timing': instance.timing,
    };

TimingRequestModel _$TimingRequestModelFromJson(Map<String, dynamic> json) {
  return TimingRequestModel(
    status: json['status'] as String,
    repeat: json['repeat'] == null
        ? null
        : RequestRepeat.fromJson(json['repeat'] as Map<String, dynamic>),
    start: json['start'] as String,
    end: json['end'] as String,
  );
}

Map<String, dynamic> _$TimingRequestModelToJson(TimingRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('repeat', instance.repeat);
  writeNotNull('start', instance.start);
  writeNotNull('end', instance.end);
  return val;
}

RequestRepeat _$RequestRepeatFromJson(Map<String, dynamic> json) {
  return RequestRepeat(
    type: json['type'] as String,
    weekdays: json['weekdays'] as String,
  );
}

Map<String, dynamic> _$RequestRepeatToJson(RequestRepeat instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('weekdays', instance.weekdays);
  return val;
}
