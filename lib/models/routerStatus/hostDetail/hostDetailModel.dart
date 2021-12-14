///
///Created by slkk on 2019/9/5/0005 13:38
///

import 'package:json_annotation/json_annotation.dart';

part 'hostDetailModel.g.dart';

///路由器运行状态model
@JsonSerializable()
class HostDetailModel {
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  HostDetailModel(
      this.version, this.sender, this.receiver, this.return_parameter, this.errorCode);

  factory HostDetailModel.fromJson(Map<String, dynamic> json) =>
      _$HostDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$HostDetailModelToJson(this);
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
  @JsonKey(includeIfNull: false)
  final String mac;
  @JsonKey(includeIfNull: false)
  final String name;
  @JsonKey(includeIfNull: false)
  final String nickname;
  @JsonKey(includeIfNull: false)
  final String onlineAlert;
  @JsonKey(includeIfNull: false)
  final String storageAccess;
  @JsonKey(includeIfNull: false)
  final RunningRate runningRate;
  @JsonKey(includeIfNull: false)
  final Traffic traffic;
  @JsonKey(includeIfNull: false)
  final RateLimit ratelimit;
  @JsonKey(includeIfNull: false)
  final String internetConnect;
  @JsonKey(includeIfNull: false)
  final String internetAccess;
  @JsonKey(includeIfNull: false)
  final String linkType;
  @JsonKey(includeIfNull: false)
  final String linkTime;
  @JsonKey(includeIfNull: false)
  final String inBlacklist;
  @JsonKey(includeIfNull: false)
  final String type;
  @JsonKey(includeIfNull: false)
  final String address;

  Result(
      this.mac,
      this.name,
      this.nickname,
      this.onlineAlert,
      this.storageAccess,
      this.runningRate,
      this.traffic,
      this.ratelimit,
      this.internetConnect,
      this.internetAccess,
      this.linkType,
      this.linkTime,
      this.inBlacklist,this.type,this.address);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class RunningRate {
  final String upstream;
  final String downstream;

  RunningRate(this.upstream, this.downstream);

  factory RunningRate.fromJson(Map<String, dynamic> json) =>
      _$RunningRateFromJson(json);

  Map<String, dynamic> toJson() => _$RunningRateToJson(this);
}

@JsonSerializable()
class Traffic {
  final String upload;
  final String download;

  Traffic(this.upload, this.download);

  factory Traffic.fromJson(Map<String, dynamic> json) =>
      _$TrafficFromJson(json);

  Map<String, dynamic> toJson() => _$TrafficToJson(this);
}

@JsonSerializable()
class RateLimit {
  final String status;
  final String upstream;
  final String downstream;

  RateLimit(this.status, this.upstream, this.downstream);

  factory RateLimit.fromJson(Map<String, dynamic> json) =>
      _$RateLimitFromJson(json);

  Map<String, dynamic> toJson() => _$RateLimitToJson(this);
}
