import 'package:json_annotation/json_annotation.dart';

part 'registerResponseModel.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  final int code;
  final String result;
  @JsonKey(includeIfNull: false)
  final String reason;
  @JsonKey(includeIfNull: false)
  final Data data;

  RegisterResponseModel({this.code, this.result, this.reason, this.data});

  factory RegisterResponseModel.formJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  final String token;

  Data(this.token);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
