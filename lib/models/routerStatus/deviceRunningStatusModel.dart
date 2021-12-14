///
///Created by slkk on 2019/9/4/0004 10:43
///
///
import 'package:json_annotation/json_annotation.dart';

part 'deviceRunningStatusModel.g.dart';

///路由器运行状态model
@JsonSerializable()
class DeviceRunningStatusModel {
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

  DeviceRunningStatusModel(this.version, this.sender, this.receiver,
      this.return_parameter, this.errorCode);

  factory DeviceRunningStatusModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceRunningStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRunningStatusModelToJson(this);
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
  final String version;
  final int uptime;
  final String downstreamRate;
  final String downstreamMaxRate;
  final String upstreamRate;
  final String upstreamMaxRate;

  Result(this.version, this.uptime, this.downstreamRate, this.downstreamMaxRate,
      this.upstreamRate, this.upstreamMaxRate);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
