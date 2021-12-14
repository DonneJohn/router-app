///
///Created by slkk on 2019/11/18/0018 14:52
///
import 'package:json_annotation/json_annotation.dart';

part 'getDeviceVersionResponseModel.g.dart';

@JsonSerializable()
class GetDeviceVersionResponseModel {
  @JsonKey(includeIfNull: false)
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetDeviceVersionResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory GetDeviceVersionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetDeviceVersionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetDeviceVersionResponseModelToJson(this);
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
  final String upgradeCount;
  @JsonKey(includeIfNull: false)
  final String currentVersion;
  @JsonKey(includeIfNull: false)
  final String internalVersion;

  @JsonKey(includeIfNull: false)
  Result(this.upgradeCount, this.currentVersion, this.internalVersion);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
