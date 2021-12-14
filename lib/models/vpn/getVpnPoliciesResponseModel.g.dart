// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getVpnPoliciesResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetVpnPoliciesResponseModel _$GetVpnPoliciesResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetVpnPoliciesResponseModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GetVpnPoliciesResponseModelToJson(
        GetVpnPoliciesResponseModel instance) =>
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

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'sources': instance.sources,
      'destinations': instance.destinations,
    };

Sources _$SourcesFromJson(Map<String, dynamic> json) {
  return Sources(
    json['id'] as String,
    json['name'] as String,
    json['mac'] as String,
  );
}

Map<String, dynamic> _$SourcesToJson(Sources instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mac': instance.mac,
    };

Destinations _$DestinationsFromJson(Map<String, dynamic> json) {
  return Destinations(
    json['id'] as String,
    json['name'] as String,
  )..mac = json['mac'] as String;
}

Map<String, dynamic> _$DestinationsToJson(Destinations instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mac': instance.mac,
    };
