// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getUpgradeResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUpgradeResponseModel _$GetUpgradeResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetUpgradeResponseModel(
    code: json['code'] as int,
    result: json['result'] as String,
    data: json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetUpgradeResponseModelToJson(
    GetUpgradeResponseModel instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'result': instance.result,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    version: json['version'] as String,
    versionid: json['versionid'] as String,
    date: json['date'] as String,
    upgrade_image: json['upgrade_image'] as String,
    release_notes: json['release_notes'] as String,
    description: json['description'] as String,
    username: json['username'] as String,
    password: json['password'] as String,
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('version', instance.version);
  writeNotNull('versionid', instance.versionid);
  writeNotNull('date', instance.date);
  writeNotNull('upgrade_image', instance.upgrade_image);
  writeNotNull('release_notes', instance.release_notes);
  writeNotNull('description', instance.description);
  writeNotNull('username', instance.username);
  writeNotNull('password', instance.password);
  return val;
}
