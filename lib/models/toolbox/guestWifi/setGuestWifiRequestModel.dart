///
///Created by slkk on 2019/11/1/0001 14:30
///
import 'package:json_annotation/json_annotation.dart';

part 'setGuestWifiRequestModel.g.dart';

@JsonSerializable()
class SetGuestWifiRequestModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  SetGuestWifiRequestModel(
      this.version, this.sender, this.receiver, this.parameter);

  factory SetGuestWifiRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SetGuestWifiRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetGuestWifiRequestModelToJson(this);
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
  final String status;
  final String ssid;
  final String password;

  Data(this.status, this.ssid, this.password);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
