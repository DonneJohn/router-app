///
///Created by slkk on 2019/9/10/0010 09:32
///
import 'package:json_annotation/json_annotation.dart';

part 'requestSetWifiInfoModel.g.dart';

@JsonSerializable()
class RequestSetWifiInfoModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  RequestSetWifiInfoModel(
      this.version, this.sender, this.receiver, this.parameter);

  factory RequestSetWifiInfoModel.fromJson(Map<String, dynamic> json) =>
      _$RequestSetWifiInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestSetWifiInfoModelToJson(this);
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
  final String type;
  final String status;
  final String ssid;
  @JsonKey(includeIfNull: false)
  final String hidden;
  @JsonKey(includeIfNull: false)
  final String channel;
  @JsonKey(includeIfNull: false)
  final String bandwidth;
  @JsonKey(includeIfNull: false)
  final String power;
  @JsonKey(includeIfNull: false)
  final String signal;
  @JsonKey(includeIfNull: false)
  final String security;
  @JsonKey(includeIfNull: false)
  final String secret;

  Data(this.type, this.status, this.ssid, this.hidden, this.channel,
      this.bandwidth, this.power, this.signal, this.security, this.secret);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
