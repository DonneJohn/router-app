///
///Created by slkk on 2019/9/18/0018 16:43
///
import 'package:json_annotation/json_annotation.dart';

part 'locationResponseModel.g.dart';

@JsonSerializable()
class LocationResponseModel {
  final int code;
  final String result;
  final Data data;


  LocationResponseModel(this.code, this.result, this.data);

  factory LocationResponseModel.formJson(Map<String, dynamic> json) =>
      _$LocationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationResponseModelToJson(this);
}

@JsonSerializable()
class Data{
  final String region;
  final String operatorl;
  final String agent_host;
  final int agent_port;

  Data(this.region, this.operatorl, this.agent_host, this.agent_port);
  factory Data.fromJson(Map<String, dynamic> json) =>
      _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}