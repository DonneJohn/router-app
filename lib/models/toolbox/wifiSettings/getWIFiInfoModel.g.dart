// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getWIFiInfoModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetWIFiInfoResponseModel _$GetWIFiInfoResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetWIFiInfoResponseModel(
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

Map<String, dynamic> _$GetWIFiInfoResponseModelToJson(
        GetWIFiInfoResponseModel instance) =>
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
    json['type'] as String,
    json['status'] as String,
    json['ssid'] as String,
    json['hidden'] as String,
    json['channel'] as String,
    json['bandwidth'] as String,
    json['power'] as String,
    json['signal'] as String,
    json['security'] as String,
    json['secret'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'type': instance.type,
      'status': instance.status,
      'ssid': instance.ssid,
      'hidden': instance.hidden,
      'channel': instance.channel,
      'bandwidth': instance.bandwidth,
      'power': instance.power,
      'signal': instance.signal,
      'security': instance.security,
      'secret': instance.secret,
    };
