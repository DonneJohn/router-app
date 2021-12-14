///
///Created by slkk on 2019/11/1/0001 15:16
///
import 'package:json_annotation/json_annotation.dart';

part 'getSmartRateLimitResponse.g.dart';

@JsonSerializable()
class GetSmartRateLimitResponseModel {
  @JsonKey(includeIfNull: false)
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetSmartRateLimitResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory GetSmartRateLimitResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetSmartRateLimitResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetSmartRateLimitResponseModelToJson(this);
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
  final String status;
  final String policy;
  final Bandwidth bandwidth;

  Result(this.status, this.policy, this.bandwidth);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
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
