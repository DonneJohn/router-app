///
///Created by slkk on 2019/11/1/0001 16:13
///
import 'package:json_annotation/json_annotation.dart';

part 'setSmartRateLimitRequestModel.g.dart';

@JsonSerializable()
class SetSmartRateLimitRequestModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  SetSmartRateLimitRequestModel(
      this.version, this.sender, this.receiver, this.parameter);

  factory SetSmartRateLimitRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SetSmartRateLimitRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetSmartRateLimitRequestModelToJson(this);
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
  final String status;
  final String policy;
  final Bandwidth bandwidth;

  Data(this.status, this.policy, this.bandwidth);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Bandwidth {
  final String downstream;
  final String upstream;

  Bandwidth(this.downstream, this.upstream);

  factory Bandwidth.fromJson(Map<String, dynamic> json) =>
      _$BandwidthFromJson(json);

  Map<String, dynamic> toJson() => _$BandwidthToJson(this);
}
