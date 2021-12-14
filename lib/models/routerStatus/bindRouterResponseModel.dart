import 'package:json_annotation/json_annotation.dart';

part 'bindRouterResponseModel.g.dart';

///
///Created by slkk on 2019/9/4
///
@JsonSerializable()
class BindRouterResponseModel {
  final int code;
  @JsonKey(includeIfNull: false)
  final String result;
  @JsonKey(includeIfNull: false)
  final Data data;

  BindRouterResponseModel({this.code, this.result, this.data});

  factory BindRouterResponseModel.formJson(Map<String, dynamic> json) =>
      _$BindRouterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BindRouterResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  final String uuid;
  final String type;
  final String operator;
  final String agent_host;
  final int agent_port;

  Data(this.uuid, this.type, this.operator, this.agent_host, this.agent_port);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
