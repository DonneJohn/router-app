///
///Created by slkk on 2019/10/31/0031 16:29
///
import 'package:json_annotation/json_annotation.dart';

part 'getGuestWifiResponseModel.g.dart';

@JsonSerializable()
class GetGuestWifiResponseModel {
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetGuestWifiResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory GetGuestWifiResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetGuestWifiResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetGuestWifiResponseModelToJson(this);
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
  final String ssid;
  final String password;

  Result(this.status, this.ssid, this.password);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
