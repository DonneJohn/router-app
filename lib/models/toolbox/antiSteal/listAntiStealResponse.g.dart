// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listAntiStealResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListAntiStealResponse _$ListAntiStealResponseFromJson(
    Map<String, dynamic> json) {
  return ListAntiStealResponse(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ListAntiStealResponseToJson(
        ListAntiStealResponse instance) =>
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
    (json['whitelists'] as List)
        ?.map((e) => e == null
            ? null
            : AntiStealItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['blacklists'] as List)
        ?.map((e) => e == null
            ? null
            : AntiStealItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('whitelists', instance.whitelists);
  writeNotNull('blacklists', instance.blacklists);
  return val;
}

AntiStealItem _$AntiStealItemFromJson(Map<String, dynamic> json) {
  return AntiStealItem(
    json['id'] as String,
    json['nickname'] as String,
    json['mac'] as String,
  );
}

Map<String, dynamic> _$AntiStealItemToJson(AntiStealItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'mac': instance.mac,
    };
