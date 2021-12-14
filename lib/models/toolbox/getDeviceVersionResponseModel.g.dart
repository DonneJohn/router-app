// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getDeviceVersionResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDeviceVersionResponseModel _$GetDeviceVersionResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetDeviceVersionResponseModel(
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

Map<String, dynamic> _$GetDeviceVersionResponseModelToJson(
        GetDeviceVersionResponseModel instance) =>
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
    json['upgradeCount'] as String,
    json['currentVersion'] as String,
    json['internalVersion'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{
    'upgradeCount': instance.upgradeCount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('currentVersion', instance.currentVersion);
  writeNotNull('internalVersion', instance.internalVersion);
  return val;
}
