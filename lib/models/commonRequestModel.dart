///
///Created by slkk on 2019/9/3/0003 10:38
///

import 'package:json_annotation/json_annotation.dart';

part 'commonRequestModel.g.dart';

@JsonSerializable()
class CommonRequestModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  CommonRequestModel(this.version, this.sender, this.receiver, this.parameter);

  factory CommonRequestModel.formJson(Map<String, dynamic> json) =>
      _$CommonRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonRequestModelToJson(this);
}

@JsonSerializable()
class Parameter {
  final String type;
  final String sequence;
  @JsonKey(includeIfNull: false)
  final Data data;

  Parameter(this.type, this.sequence, {this.data});

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(includeIfNull: false)
  final String host;
  @JsonKey(includeIfNull: false)
  final String type;
  @JsonKey(includeIfNull: false)
  final String id;
  @JsonKey(includeIfNull: false)
  final String protocol;
  @JsonKey(includeIfNull: false)
  final String name;
  @JsonKey(includeIfNull: false)
  final String server;
  @JsonKey(includeIfNull: false)
  final String username;
  @JsonKey(includeIfNull: false)
  final String password;
  @JsonKey(includeIfNull: false)
  final String status;
  @JsonKey(includeIfNull: false)
  final String policy;
  @JsonKey(includeIfNull: false)
  final String timezone;
  @JsonKey(includeIfNull: false)
  final List<Timing> timing;

  Data(
      {this.type,
      this.host,
      this.id,
      this.protocol,
      this.name,
      this.server,
      this.username,
      this.password,
      this.status,
      this.policy,
      this.timezone,
      this.timing});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Timing {
  final String id;
  final String status;

  Timing({this.id, this.status});

  factory Timing.fromJson(Map<String, dynamic> json) => _$TimingFromJson(json);

  Map<String, dynamic> toJson() => _$TimingToJson(this);
}
