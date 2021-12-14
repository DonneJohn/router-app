// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostDetailModel _$HostDetailModelFromJson(Map<String, dynamic> json) {
  return HostDetailModel(
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

Map<String, dynamic> _$HostDetailModelToJson(HostDetailModel instance) =>
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

Map<String, dynamic> _$ReturnParameterToJson(ReturnParameter instance) =>
    <String, dynamic>{
      'type': instance.type,
      'sequence': instance.sequence,
      'status': instance.status,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['mac'] as String,
    json['name'] as String,
    json['nickname'] as String,
    json['onlineAlert'] as String,
    json['storageAccess'] as String,
    json['runningRate'] == null
        ? null
        : RunningRate.fromJson(json['runningRate'] as Map<String, dynamic>),
    json['traffic'] == null
        ? null
        : Traffic.fromJson(json['traffic'] as Map<String, dynamic>),
    json['ratelimit'] == null
        ? null
        : RateLimit.fromJson(json['ratelimit'] as Map<String, dynamic>),
    json['internetConnect'] as String,
    json['internetAccess'] as String,
    json['linkType'] as String,
    json['linkTime'] as String,
    json['inBlacklist'] as String,
    json['type'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('mac', instance.mac);
  writeNotNull('name', instance.name);
  writeNotNull('nickname', instance.nickname);
  writeNotNull('onlineAlert', instance.onlineAlert);
  writeNotNull('storageAccess', instance.storageAccess);
  writeNotNull('runningRate', instance.runningRate);
  writeNotNull('traffic', instance.traffic);
  writeNotNull('ratelimit', instance.ratelimit);
  writeNotNull('internetConnect', instance.internetConnect);
  writeNotNull('internetAccess', instance.internetAccess);
  writeNotNull('linkType', instance.linkType);
  writeNotNull('linkTime', instance.linkTime);
  writeNotNull('inBlacklist', instance.inBlacklist);
  writeNotNull('type', instance.type);
  writeNotNull('address', instance.address);
  return val;
}

RunningRate _$RunningRateFromJson(Map<String, dynamic> json) {
  return RunningRate(
    json['upstream'] as String,
    json['downstream'] as String,
  );
}

Map<String, dynamic> _$RunningRateToJson(RunningRate instance) =>
    <String, dynamic>{
      'upstream': instance.upstream,
      'downstream': instance.downstream,
    };

Traffic _$TrafficFromJson(Map<String, dynamic> json) {
  return Traffic(
    json['upload'] as String,
    json['download'] as String,
  );
}

Map<String, dynamic> _$TrafficToJson(Traffic instance) => <String, dynamic>{
      'upload': instance.upload,
      'download': instance.download,
    };

RateLimit _$RateLimitFromJson(Map<String, dynamic> json) {
  return RateLimit(
    json['status'] as String,
    json['upstream'] as String,
    json['downstream'] as String,
  );
}

Map<String, dynamic> _$RateLimitToJson(RateLimit instance) => <String, dynamic>{
      'status': instance.status,
      'upstream': instance.upstream,
      'downstream': instance.downstream,
    };
