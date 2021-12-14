///
///Created by slkk on 2019/11/7/0007 18:22
///
import 'package:json_annotation/json_annotation.dart';

part 'getDeviceInfoResponseModel.g.dart';

@JsonSerializable()
class GetDeviceInfoResponseModel {
  @JsonKey(includeIfNull: false)
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetDeviceInfoResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory GetDeviceInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetDeviceInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetDeviceInfoResponseModelToJson(this);
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
  final String model;
  @JsonKey(includeIfNull: false)
  final String hardwareVersion;
  @JsonKey(includeIfNull: false)
  final String softwareVersion;
  @JsonKey(includeIfNull: false)
  final String macAddress;
  @JsonKey(includeIfNull: false)
  final String processors;
  @JsonKey(includeIfNull: false)
  final String frequency;
  @JsonKey(includeIfNull: false)
  final String ddrSize;
  @JsonKey(includeIfNull: false)
  final String ddrType;
  @JsonKey(includeIfNull: false)
  final String ddrFrequency;
  @JsonKey(includeIfNull: false)
  final String flashSize;
  @JsonKey(includeIfNull: false)
  final String flashType;
  @JsonKey(includeIfNull: false)
  final String scenario;

  Result(
      this.model,
      this.hardwareVersion,
      this.softwareVersion,
      this.macAddress,
      this.processors,
      this.frequency,
      this.ddrSize,
      this.ddrType,
      this.ddrFrequency,
      this.flashSize,
      this.flashType,
      this.scenario);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
