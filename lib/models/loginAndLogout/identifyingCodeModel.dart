import 'package:json_annotation/json_annotation.dart';

part 'identifyingCodeModel.g.dart';

@JsonSerializable()
class IdentifyingCodeModel {
  final int code;
  @JsonKey(includeIfNull: false)
  final String result;
  @JsonKey(includeIfNull: false)
  Data data;

  IdentifyingCodeModel({this.code, this.result, this.data});

  factory IdentifyingCodeModel.formJson(Map<String, dynamic> json) =>
      _$IdentifyingCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$IdentifyingCodeModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(includeIfNull: false)
  String code;

  @JsonKey(includeIfNull: false)
  Data(this.code);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
