// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getInternetAccessResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInternetAccessResponseModel _$GetInternetAccessResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetInternetAccessResponseModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetInternetAccessResponseModelToJson(
        GetInternetAccessResponseModel instance) =>
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
    (json['whitelist'] as List)
        ?.map((e) =>
            e == null ? null : BlockList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['blacklist'] as List)
        ?.map((e) =>
            e == null ? null : BlockList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{
    'type': instance.type,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('whitelist', instance.whitelist);
  writeNotNull('blacklist', instance.blacklist);
  return val;
}

BlockList _$BlockListFromJson(Map<String, dynamic> json) {
  return BlockList(
    json['id'] as String,
    json['host'] as String,
  );
}

Map<String, dynamic> _$BlockListToJson(BlockList instance) => <String, dynamic>{
      'id': instance.id,
      'host': instance.host,
    };
