///
///Created by slkk on 2019/9/20/0020 14:13
///
import 'package:json_annotation/json_annotation.dart';

part 'updateHostDetailRequestModel.g.dart';

@JsonSerializable()
class UpdateHostDetailRequestModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  UpdateHostDetailRequestModel(
      this.version, this.sender, this.receiver, this.parameter);

  factory UpdateHostDetailRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateHostDetailRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateHostDetailRequestModelToJson(this);
}

@JsonSerializable()
class Parameter {
  final String type;
  final String sequence;
  final Data data;

  Parameter(this.type, this.sequence, this.data);

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

@JsonSerializable()
class Data {
  final String host;
  @JsonKey(includeIfNull: false)
  final String nickname;
  @JsonKey(includeIfNull: false)
  final String onlineAlert;
  @JsonKey(includeIfNull: false)
  final String storageAccess;
  @JsonKey(includeIfNull: false)
  final String inBlacklist;
  @JsonKey(includeIfNull: false)
  final Ratelimit ratelimit;

  Data(this.host, {this.nickname, this.onlineAlert, this.storageAccess,
      this.inBlacklist, this.ratelimit});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Ratelimit {
  final String status;
  @JsonKey(includeIfNull: false)
  final String upstream;
  @JsonKey(includeIfNull: false)
  final String downstream;

  Ratelimit(
      {this.status,
    this.upstream,
    this.downstream,
  });

  factory Ratelimit.fromJson(Map<String, dynamic> json) =>
      _$RatelimitFromJson(json);

  Map<String, dynamic> toJson() => _$RatelimitToJson(this);
}
