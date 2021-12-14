import 'package:json_annotation/json_annotation.dart';

part 'loginResponseModel.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final int code;

  final String result;

  final Data data;

  LoginResponseModel({this.code, this.result, this.data});

  factory LoginResponseModel.formJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  final String uuid;
  final String token;
  @JsonKey(includeIfNull: false)
  final int userid;
  final String clientid;

  Data(this.uuid, this.token, this.userid, this.clientid);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
