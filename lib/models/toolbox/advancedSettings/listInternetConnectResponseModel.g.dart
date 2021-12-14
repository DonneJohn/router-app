// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listInternetConnectResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListInternetConnectResponse _$ListInternetConnectResponseFromJson(
    Map<String, dynamic> json) {
  return ListInternetConnectResponse(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ListInternetConnectResponseToJson(
        ListInternetConnectResponse instance) =>
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
    status: json['status'] as String,
    mode: json['mode'] as String,
    hosts: (json['hosts'] as List)
        ?.map(
            (e) => e == null ? null : Host.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mode', instance.mode);
  writeNotNull('hosts', instance.hosts);
  return val;
}

Host _$HostFromJson(Map<String, dynamic> json) {
  return Host(
    id: json['id'] as String,
    mac: json['mac'] as String,
    name: json['name'] as String,
    nickname: json['nickname'] as String,
    type: json['type'] as String,
    timing: (json['timing'] as List)
        ?.map((e) =>
            e == null ? null : TimingModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HostToJson(Host instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('mac', instance.mac);
  writeNotNull('name', instance.name);
  writeNotNull('nickname', instance.nickname);
  writeNotNull('type', instance.type);
  writeNotNull('timing', instance.timing);
  return val;
}

TimingModel _$TimingModelFromJson(Map<String, dynamic> json) {
  return TimingModel(
    status: json['status'] as String,
    id: json['id'] as String,
    repeat: json['repeat'] == null
        ? null
        : Repeat.fromJson(json['repeat'] as Map<String, dynamic>),
    start: json['start'] as String,
    end: json['end'] as String,
  );
}

Map<String, dynamic> _$TimingModelToJson(TimingModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('id', instance.id);
  writeNotNull('repeat', instance.repeat);
  writeNotNull('start', instance.start);
  writeNotNull('end', instance.end);
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
  writeNotNull('weekdays', instance.weekdays);
  return val;
}
