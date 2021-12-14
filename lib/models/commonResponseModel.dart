///
///Created by slkk on 2019/9/9/0009 14:24

import 'package:json_annotation/json_annotation.dart';

part 'commonResponseModel.g.dart';

@JsonSerializable()
class CommonResponseModel {
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  CommonResponseModel(
      this.version, this.sender, this.receiver, this.return_parameter, this.errorCode);

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CommonResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseModelToJson(this);
}

@JsonSerializable()
class ReturnParameter {
  final String type;
  final String sequence;
  final String status;
  @JsonKey(includeIfNull: false)
  final Result result;

  ReturnParameter(this.type, this.sequence, this.status, this.result);

  factory ReturnParameter.fromJson(Map<String, dynamic> json) =>
      _$ReturnParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnParameterToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(includeIfNull: false)
  final String status;
  @JsonKey(includeIfNull: false)
  SpeedTestResult downstream;
  @JsonKey(includeIfNull: false)
  SpeedTestResult upstream;
  @JsonKey(includeIfNull: false)
  String mac;

  Result({this.status, this.downstream, this.upstream});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class SpeedTestResult {
  final String bandwidth;

  SpeedTestResult({this.bandwidth});

  factory SpeedTestResult.fromJson(Map<String, dynamic> json) =>
      _$SpeedTestResultFromJson(json);

  Map<String, dynamic> toJson() => _$SpeedTestResultToJson(this);
}
