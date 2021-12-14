import 'package:json_annotation/json_annotation.dart';

part 'getHostsListResponse.g.dart';

@JsonSerializable()
class HostsListResponse {
  @JsonKey(includeIfNull: false)
  final int errorCode;
  @JsonKey(includeIfNull: false)
  final String version;
  @JsonKey(includeIfNull: false)
  final String sender;
  @JsonKey(includeIfNull: false)
  final String receiver;
  @JsonKey(includeIfNull: false)
  final ReturnParameter return_parameter;

  HostsListResponse(
      {this.errorCode,
      this.version,
      this.sender,
      this.receiver,
      this.return_parameter});

  factory HostsListResponse.fromJson(Map<String, dynamic> json) =>
      _$HostsListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HostsListResponseToJson(this);
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
  final List<Host> hosts;

  Result(this.hosts);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Host {
  final String mac;
  final String name;
  final String nickname;
  final String status;
  final String address;
  final String type;
  final String internetAccess;
  final RunningRate runningRate;

  Host(
    this.mac,
    this.name,
    this.nickname,
    this.status,
    this.address,
    this.type,
    this.internetAccess,
    this.runningRate,
  );

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

  Map<String, dynamic> toJson() => _$HostToJson(this);
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
