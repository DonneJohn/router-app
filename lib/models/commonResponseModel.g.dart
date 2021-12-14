// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commonResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonResponseModel _$CommonResponseModelFromJson(Map<String, dynamic> json) {
  return CommonResponseModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
    json['errorCode'] as int,
  );
}

Map<String, dynamic> _$CommonResponseModelToJson(
        CommonResponseModel instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
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

Map<String, dynamic> _$ReturnParameterToJson(ReturnParameter instance) {
  final val = <String, dynamic>{
    'type': instance.type,
    'sequence': instance.sequence,
    'status': instance.status,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', instance.result);
  return val;
}

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    status: json['status'] as String,
    downstream: json['downstream'] == null
        ? null
        : SpeedTestResult.fromJson(json['downstream'] as Map<String, dynamic>),
    upstream: json['upstream'] == null
        ? null
        : SpeedTestResult.fromJson(json['upstream'] as Map<String, dynamic>),
  )..mac = json['mac'] as String;
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('status', instance.status);
  writeNotNull('downstream', instance.downstream);
  writeNotNull('upstream', instance.upstream);
  writeNotNull('mac', instance.mac);
  return val;
}

SpeedTestResult _$SpeedTestResultFromJson(Map<String, dynamic> json) {
  return SpeedTestResult(
    bandwidth: json['bandwidth'] as String,
  );
}

Map<String, dynamic> _$SpeedTestResultToJson(SpeedTestResult instance) =>
    <String, dynamic>{
      'bandwidth': instance.bandwidth,
    };
