///
///Created by slkk on 2019/9/16/0016 16:03
///

import 'package:json_annotation/json_annotation.dart';

part 'addVpnPolicyRequestModel.g.dart';

@JsonSerializable()
class AddVpnPolicyRequestModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  AddVpnPolicyRequestModel(
      this.version, this.sender, this.receiver, this.parameter);

  factory AddVpnPolicyRequestModel.formJson(Map<String, dynamic> json) =>
      _$AddVpnPolicyRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddVpnPolicyRequestModelToJson(this);
}

@JsonSerializable()
class Parameter {
  final String type;
  final String sequence;
  final Data data;

  Parameter(this.type, this.sequence, {this.data});

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

@JsonSerializable()
class Data {
  final List<Sources> sources;
  final List<Destinations> destinations;

  Data({
    this.sources,
    this.destinations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Sources {
  final String id;
  final String name;
  final String mac;

  Sources(this.name, this.mac, {this.id});

  factory Sources.fromJson(Map<String, dynamic> json) =>
      _$SourcesFromJson(json);

  Map<String, dynamic> toJson() => _$SourcesToJson(this);
}

@JsonSerializable()
class Destinations {
  final String name;
  final String id;

  Destinations({this.name, this.id});

  factory Destinations.fromJson(Map<String, dynamic> json) =>
      _$DestinationsFromJson(json);

  Map<String, dynamic> toJson() => _$DestinationsToJson(this);
}
