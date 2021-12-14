///
///Created by slkk on 2019/9/5/0005 17:05
///

import 'package:json_annotation/json_annotation.dart';

part 'getHostInfoModel.g.dart';

@JsonSerializable()
class HostInfoModel {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  HostInfoModel(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory HostInfoModel.fromJson(Map<String, dynamic> json) =>
      _$HostInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$HostInfoModelToJson(this);
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
  final String mac;
  final String name;
  final String nickname;
  final String type;
  final String vendor;
  final String model;
  final String linkType;
  final String linkTime;
  final String address;

  Result(this.mac, this.name, this.nickname, this.type, this.vendor, this.model,
      this.linkType, this.linkTime, this.address);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
