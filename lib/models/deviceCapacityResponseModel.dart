///
///Created by slkk on 2019/9/3/0003 10:38
///

import 'package:json_annotation/json_annotation.dart';

part 'deviceCapacityResponseModel.g.dart';

///路由器能力集
@JsonSerializable()
class DeviceCapacityResponseModel {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  DeviceCapacityResponseModel(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory DeviceCapacityResponseModel.formJson(Map<String, dynamic> json) =>
      _$DeviceCapacityResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceCapacityResponseModelToJson(this);
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
  final String version;

  Result(this.version);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
