// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getLedResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetLedResponseModel _$GetLedResponseModelFromJson(Map<String, dynamic> json) {
  return GetLedResponseModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : Parameter.fromJson(json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetLedResponseModelToJson(
        GetLedResponseModel instance) =>
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
    json['ledStatus'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'ledStatus': instance.ledStatus,
    };
