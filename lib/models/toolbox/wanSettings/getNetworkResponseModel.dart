///
///Created by slkk on 2019/9/11/0011 09:39
///
import 'package:json_annotation/json_annotation.dart';

part 'getNetworkResponseModel.g.dart';

@JsonSerializable()
class GetNetworkResponseModel {
  @JsonKey(includeIfNull: false)
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetNetworkResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory GetNetworkResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetNetworkResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetNetworkResponseModelToJson(this);
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
  final String mode;
  final String status;
  final String ip;
  final String gateway;
  final String dnsMode;
  final String dns;
  final String dns2;
  @JsonKey(includeIfNull: false)
  final PPPOE PPPoE;
  @JsonKey(includeIfNull: false)
  final Dhcp DHCP;
  @JsonKey(includeIfNull: false)
  final STATIC Static;
  @JsonKey(includeIfNull: false)
  final REPEATER Repeater;

  Result(this.mode, this.status, this.ip, this.gateway, this.dnsMode, this.dns,
      this.dns2,
      {this.PPPoE, this.DHCP, this.Static, this.Repeater});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class PPPOE {
  final String username;
  final String password;

  PPPOE(this.username, this.password);

  factory PPPOE.fromJson(Map<String, dynamic> json) => _$PPPOEFromJson(json);

  Map<String, dynamic> toJson() => _$PPPOEToJson(this);
}

@JsonSerializable()
class Dhcp {
  final String dns;
  final String dns2;

  Dhcp(this.dns, this.dns2);

  factory Dhcp.fromJson(Map<String, dynamic> json) => _$DhcpFromJson(json);

  Map<String, dynamic> toJson() => _$DhcpToJson(this);
}

@JsonSerializable()
class STATIC {
  final String ip;
  final String network;
  final String gateway;
  final String dns;
  final String dns2;

  STATIC(this.ip, this.network, this.gateway, this.dns, this.dns2);

  factory STATIC.fromJson(Map<String, dynamic> json) => _$STATICFromJson(json);

  Map<String, dynamic> toJson() => _$STATICToJson(this);
}

@JsonSerializable()
class REPEATER {
  final String ssid;
  final String password;

  REPEATER(this.ssid, this.password);

  factory REPEATER.fromJson(Map<String, dynamic> json) =>
      _$REPEATERFromJson(json);

  Map<String, dynamic> toJson() => _$REPEATERToJson(this);
}
