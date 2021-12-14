// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modifyInternetAccessRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModifyInternetAccessRequestModel _$ModifyInternetAccessRequestModelFromJson(
    Map<String, dynamic> json) {
  return ModifyInternetAccessRequestModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ModifyInternetAccessRequestModelToJson(
        ModifyInternetAccessRequestModel instance) =>
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
    json['host'] as String,
    whitelist: (json['whitelist'] as List)
        ?.map((e) =>
            e == null ? null : BlockList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    blacklist: (json['blacklist'] as List)
        ?.map((e) =>
            e == null ? null : BlockList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{
    'host': instance.host,
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
    id: json['id'] as String,
    host: json['host'] as String,
  );
}

Map<String, dynamic> _$BlockListToJson(BlockList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('host', instance.host);
  return val;
}
