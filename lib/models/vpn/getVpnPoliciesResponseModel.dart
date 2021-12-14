///
///Created by slkk on 2019/9/16/0016 15:36
///
import 'package:json_annotation/json_annotation.dart';

part 'getVpnPoliciesResponseModel.g.dart';

@JsonSerializable()
class GetVpnPoliciesResponseModel {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetVpnPoliciesResponseModel(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory GetVpnPoliciesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetVpnPoliciesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetVpnPoliciesResponseModelToJson(this);
}

@JsonSerializable()
class ReturnParameter {
  final String type;
  final String sequence;
  final String status;
  final Result result;

  ReturnParameter(this.type, this.sequence, this.status, this.result);

  factory ReturnParameter.fromJson(Map<String, dynamic> json) =>
      _$ReturnParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnParameterToJson(this);
}

@JsonSerializable()
class Result {
  final List<Sources> sources;
  final List<Destinations> destinations;

  Result({this.sources, this.destinations});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Sources {
  String id;
  String name;
  String mac;

  Sources(
    this.id,
    this.name,
    this.mac,
  );

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);

  Map<String, dynamic> toJson() => _$SourcesToJson(this);
}

@JsonSerializable()
class Destinations {
  String id;
  String name;
  String mac;

  Destinations(
    this.id,
    this.name,
  );

  factory Destinations.fromJson(Map<String, dynamic> json) =>
      _$DestinationsFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationsToJson(this);
}
