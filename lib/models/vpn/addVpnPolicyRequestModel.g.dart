// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'addVpnPolicyRequestModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddVpnPolicyRequestModel _$AddVpnPolicyRequestModelFromJson(
    Map<String, dynamic> json) {
  return AddVpnPolicyRequestModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddVpnPolicyRequestModelToJson(
        AddVpnPolicyRequestModel instance) =>
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
    data: json['data'] == null
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
    sources: (json['sources'] as List)
        ?.map((e) =>
            e == null ? null : Sources.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    destinations: (json['destinations'] as List)
        ?.map((e) =>
            e == null ? null : Destinations.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'sources': instance.sources,
      'destinations': instance.destinations,
    };

Sources _$SourcesFromJson(Map<String, dynamic> json) {
  return Sources(
    json['name'] as String,
    json['mac'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$SourcesToJson(Sources instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mac': instance.mac,
    };

Destinations _$DestinationsFromJson(Map<String, dynamic> json) {
  return Destinations(
    name: json['name'] as String,
    id: json['id'] as String,
  );
}

Map<String, dynamic> _$DestinationsToJson(Destinations instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
