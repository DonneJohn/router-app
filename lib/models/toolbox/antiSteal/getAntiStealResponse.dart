///
///Created by slkk on 2019/10/31/0031 14:16
///
import 'package:json_annotation/json_annotation.dart';

part 'getAntiStealResponse.g.dart';

@JsonSerializable()
class GetAntiStealResponseModel {
  @JsonKey(includeIfNull: false)
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetAntiStealResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory GetAntiStealResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetAntiStealResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetAntiStealResponseModelToJson(this);
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
  final String mode;

  Result(this.status, this.mode);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
