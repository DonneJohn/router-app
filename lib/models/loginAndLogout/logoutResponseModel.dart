///
///Created by slkk on 2019/9/4/0004 13:49
///
import 'package:json_annotation/json_annotation.dart';

part 'logoutResponseModel.g.dart';

@JsonSerializable()
class LogoutResponseModel {
  final int code;
  final String result;

  LogoutResponseModel(this.code, this.result);

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LogoutResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutResponseModelToJson(this);
}
