///
///Created by slkk on 2019/9/17/0017 16:56
///
import 'package:json_annotation/json_annotation.dart';

part 'getLedResponseModel.g.dart';

@JsonSerializable()
class GetLedResponseModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter return_parameter;

  GetLedResponseModel(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory GetLedResponseModel.formJson(Map<String, dynamic> json) =>
      _$GetLedResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetLedResponseModelToJson(this);
}

@JsonSerializable()
class Parameter {
  final String type;
  final String sequence;
  final String status;
  final Result result;

  Parameter(this.type, this.sequence, this.status, this.result);

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

@JsonSerializable()
class Result {
  final String ledStatus;

  Result(this.ledStatus);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
