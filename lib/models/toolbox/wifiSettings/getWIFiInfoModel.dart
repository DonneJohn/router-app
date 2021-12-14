///
///Created by slkk on 2019/9/9/0009 17:16
///
import 'package:json_annotation/json_annotation.dart';

part 'getWIFiInfoModel.g.dart';

@JsonSerializable()
class GetWIFiInfoResponseModel {
  @JsonKey(includeIfNull: false)
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetWIFiInfoResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory GetWIFiInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetWIFiInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetWIFiInfoResponseModelToJson(this);
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
  final String type;
  final String status;
  final String ssid;
  final String hidden;
  final String channel;
  final String bandwidth;
  final String power;
  final String signal;
  final String security;
  final String secret;

  Result(this.type, this.status, this.ssid, this.hidden, this.channel,
      this.bandwidth, this.power, this.signal, this.security, this.secret);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
