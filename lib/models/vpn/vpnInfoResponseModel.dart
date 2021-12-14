///
///Created by slkk on 2019/9/16/0016 14:50
///
import 'package:json_annotation/json_annotation.dart';

part 'vpnInfoResponseModel.g.dart';

@JsonSerializable()
class VpnInfoResponseModel {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  VpnInfoResponseModel(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory VpnInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VpnInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$VpnInfoResponseModelToJson(this);
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
  final String id;
  final String name;
  final String protocol;
  final String server;
  final String username;
  final String password;

  Result(this.id, this.name, this.protocol, this.server, this.username,
      this.password);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
