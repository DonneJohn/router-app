///
///Created by slkk on 2019/9/29/0029 15:04
///
import 'package:json_annotation/json_annotation.dart';

part 'setHostInfoModel.g.dart';

@JsonSerializable()
class SetHostInfoModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  SetHostInfoModel(this.version, this.sender, this.receiver, this.parameter);

  factory SetHostInfoModel.fromJson(Map<String, dynamic> json) =>
      _$SetHostInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetHostInfoModelToJson(this);
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
  final String host;
  final Info info;

  Data({this.host, this.info});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Info {
  final String nickname;
  final String type;
  final String vendor;
  final String model;

  Info({this.nickname, this.type, this.vendor, this.model});

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
