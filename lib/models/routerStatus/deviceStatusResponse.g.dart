// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceStatusResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceStatusResponse _$DeviceStatusResponseFromJson(Map<String, dynamic> json) {
  return DeviceStatusResponse(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeviceStatusResponseToJson(
        DeviceStatusResponse instance) =>
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
    json['upstreamBandwidth'] as String,
    json['downstreamBandwidth'] as String,
    json['wanLinkStatus'] as String,
    json['internetStatus'] as String,
    json['wifiStatus'] as String,
    json['wifi5GStatus'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'upstreamBandwidth': instance.upstreamBandwidth,
      'downstreamBandwidth': instance.downstreamBandwidth,
      'wanLinkStatus': instance.wanLinkStatus,
      'internetStatus': instance.internetStatus,
      'wifiStatus': instance.wifiStatus,
      'wifi5GStatus': instance.wifi5GStatus,
    };
