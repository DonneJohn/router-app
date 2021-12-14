//Created by slkk on 2019/9/12/0012 14:06
import 'package:json_annotation/json_annotation.dart';

part 'getVpnsResponse.g.dart';

@JsonSerializable()
class GetVpnsResponse {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetVpnsResponse(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory GetVpnsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetVpnsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetVpnsResponseToJson(this);
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
  final String policy;
  final List<Vpn> vpn;

  Result(this.policy, this.vpn);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Vpn {
  String id;
  String name;
  @JsonKey(includeIfNull: false)
  String protocol;
  @JsonKey(includeIfNull: false)
  String server;
  @JsonKey(includeIfNull: false)
  String status;

  Vpn(
    this.id,
    this.name,
    this.protocol,
    this.server,
    this.status,
  );

  factory Vpn.fromJson(Map<String, dynamic> json) => _$VpnFromJson(json);

  Map<String, dynamic> toJson() => _$VpnToJson(this);
}
