///
///Created by slkk on 2019/9/11/0011 10:49
///
import 'package:json_annotation/json_annotation.dart';

part 'setNetworkModel.g.dart';

@JsonSerializable()
class SetNetworkModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  SetNetworkModel(this.version, this.sender, this.receiver, this.parameter);

  factory SetNetworkModel.fromJson(Map<String, dynamic> json) =>
      _$SetNetworkModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetNetworkModelToJson(this);
}

@JsonSerializable()
class Parameter {
  final String type;
  final String sequence;
  final Data data;

  Parameter(this.type, this.sequence, this.data);

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

@JsonSerializable()
class Data {
  final String mode;
  @JsonKey(includeIfNull: false)
  final Pppoe PPPoE;
  @JsonKey(includeIfNull: false)
  final Dhcp DHCP;
  @JsonKey(includeIfNull: false)
  final Statics Static;
  @JsonKey(includeIfNull: false)
  final Repeaters Repeater;

  Data(this.mode, {this.PPPoE, this.DHCP, this.Static, this.Repeater});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Pppoe {
  final String username;
  final String password;

  Pppoe(this.username, this.password);

  factory Pppoe.fromJson(Map<String, dynamic> json) => _$PppoeFromJson(json);

  Map<String, dynamic> toJson() => _$PppoeToJson(this);
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
class Statics {
  final String ip;
  final String netmask;
  final String gateway;
  final String dns;
  final String dns2;

  Statics(this.ip, this.netmask, this.gateway, this.dns, {this.dns2});

  factory Statics.fromJson(Map<String, dynamic> json) =>
      _$StaticsFromJson(json);

  Map<String, dynamic> toJson() => _$StaticsToJson(this);
}

@JsonSerializable()
class Repeaters {
  final String ssid;
  final String password;

  Repeaters(
    this.ssid,
    this.password,
  );

  factory Repeaters.fromJson(Map<String, dynamic> json) =>
      _$RepeatersFromJson(json);

  Map<String, dynamic> toJson() => _$RepeatersToJson(this);
}
