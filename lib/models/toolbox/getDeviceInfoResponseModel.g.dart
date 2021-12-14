// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getDeviceInfoResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDeviceInfoResponseModel _$GetDeviceInfoResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetDeviceInfoResponseModel(
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

Map<String, dynamic> _$GetDeviceInfoResponseModelToJson(
        GetDeviceInfoResponseModel instance) =>
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
    json['model'] as String,
    json['hardwareVersion'] as String,
    json['softwareVersion'] as String,
    json['macAddress'] as String,
    json['processors'] as String,
    json['frequency'] as String,
    json['ddrSize'] as String,
    json['ddrType'] as String,
    json['ddrFrequency'] as String,
    json['flashSize'] as String,
    json['flashType'] as String,
    json['scenario'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{
    'model': instance.model,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('hardwareVersion', instance.hardwareVersion);
  writeNotNull('softwareVersion', instance.softwareVersion);
  writeNotNull('macAddress', instance.macAddress);
  writeNotNull('processors', instance.processors);
  writeNotNull('frequency', instance.frequency);
  writeNotNull('ddrSize', instance.ddrSize);
  writeNotNull('ddrType', instance.ddrType);
  writeNotNull('ddrFrequency', instance.ddrFrequency);
  writeNotNull('flashSize', instance.flashSize);
  writeNotNull('flashType', instance.flashType);
  writeNotNull('scenario', instance.scenario);
  return val;
}
