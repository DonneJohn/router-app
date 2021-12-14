///
///Created by slkk on 2019/9/18/0018 15:30
///
import 'package:json_annotation/json_annotation.dart';

part 'commonDioResponseModel.g.dart';

@JsonSerializable()
class CommonDioResponseModel {
  final int code;
  final String result;
  @JsonKey(includeIfNull: false)
  final Data data;

  CommonDioResponseModel({this.code, this.result, this.data});

  factory CommonDioResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CommonDioResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommonDioResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(includeIfNull: false)
  final String avator;
  @JsonKey(includeIfNull: false)
  final String nickname;

  Data(this.avator, this.nickname);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
