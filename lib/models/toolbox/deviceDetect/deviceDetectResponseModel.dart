///
///Created by slkk on 2019/11/7/0007 14:30
///
import 'package:json_annotation/json_annotation.dart';

part 'deviceDetectResponseModel.g.dart';

@JsonSerializable()
class DeviceDetectResponseModel {
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  DeviceDetectResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory DeviceDetectResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeviceDetectResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceDetectResponseModelToJson(this);
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
  final String phase;
  @JsonKey(includeIfNull: false)
  final String wanState;
  @JsonKey(includeIfNull: false)
  final InternetState internetState;
  @JsonKey(includeIfNull: false)
  final WifiState wifiState;
  @JsonKey(includeIfNull: false)
  final Wifi5GState wifi5GState;
  @JsonKey(includeIfNull: false)
  final Password password;

  Result(
    this.phase,
    this.wanState,
    this.internetState,
    this.wifiState,
    this.wifi5GState,
    this.password,
  );

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class InternetState {
  final String status;
  final String reason;

  InternetState(this.status, this.reason);

  factory InternetState.fromJson(Map<String, dynamic> json) =>
      _$InternetStateFromJson(json);

  Map<String, dynamic> toJson() => _$InternetStateToJson(this);
}

@JsonSerializable()
class WifiState {
  final String status;

  WifiState(this.status);

  factory WifiState.fromJson(Map<String, dynamic> json) =>
      _$WifiStateFromJson(json);

  Map<String, dynamic> toJson() => _$WifiStateToJson(this);
}

@JsonSerializable()
class Wifi5GState {
  final String status;

  Wifi5GState(this.status);

  factory Wifi5GState.fromJson(Map<String, dynamic> json) =>
      _$Wifi5GStateFromJson(json);

  Map<String, dynamic> toJson() => _$Wifi5GStateToJson(this);
}

@JsonSerializable()
class Password {
  final String wifiPassword;
  final String wifi5GPassword;
  final String adminPassword;

  Password(this.wifiPassword, this.wifi5GPassword, this.adminPassword);

  factory Password.fromJson(Map<String, dynamic> json) =>
      _$PasswordFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordToJson(this);
}
