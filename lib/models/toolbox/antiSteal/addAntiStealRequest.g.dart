// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addAntiStealRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAntiStealRequest _$AddAntiStealRequestFromJson(Map<String, dynamic> json) {
  return AddAntiStealRequest(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddAntiStealRequestToJson(
        AddAntiStealRequest instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'parameter': instance.parameter,
    };

Parameter _$ParameterFromJson(Map<String, dynamic> json) {
  return Parameter(
    json['type'] as String,
    json['sequence'] as String,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
      'type': instance.type,
      'sequence': instance.sequence,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    whitelists: (json['whitelists'] as List)
        ?.map((e) => e == null
            ? null
            : AntiStealItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    blacklists: (json['blacklists'] as List)
        ?.map((e) => e == null
            ? null
            : AntiStealItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
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
    nickname: json['nickname'] as String,
    mac: json['mac'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$AntiStealItemToJson(AntiStealItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nickname', instance.nickname);
  writeNotNull('mac', instance.mac);
  writeNotNull('id', instance.id);
  return val;
}
