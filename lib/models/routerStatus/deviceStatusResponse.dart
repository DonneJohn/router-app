///
///Created by slkk on 2019/9/20/0020 10:31
///
import 'package:json_annotation/json_annotation.dart';

part 'deviceStatusResponse.g.dart';

@JsonSerializable()
class DeviceStatusResponse {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  DeviceStatusResponse(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory DeviceStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceStatusResponseToJson(this);
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
  final String upstreamBandwidth;
  final String downstreamBandwidth;
  final String wanLinkStatus;
  final String internetStatus;
  final String wifiStatus;
  final String wifi5GStatus;

  Result(this.upstreamBandwidth, this.downstreamBandwidth, this.wanLinkStatus,
      this.internetStatus, this.wifiStatus, this.wifi5GStatus);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
