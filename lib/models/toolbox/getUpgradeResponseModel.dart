///
///Created by slkk on 2019/11/18/0018 15:34
///
import 'package:json_annotation/json_annotation.dart';

part 'getUpgradeResponseModel.g.dart';

@JsonSerializable()
class GetUpgradeResponseModel {
  final int code;
  final String result;
  @JsonKey(includeIfNull: false)
  final Data data;

  GetUpgradeResponseModel({this.code, this.result, this.data});

  factory GetUpgradeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetUpgradeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetUpgradeResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(includeIfNull: false)
  final String version;
  @JsonKey(includeIfNull: false)
  final String versionid;
  @JsonKey(includeIfNull: false)
  final String date;
  @JsonKey(includeIfNull: false)
  final String upgrade_image;
  @JsonKey(includeIfNull: false)
  final String release_notes;
  @JsonKey(includeIfNull: false)
  final String description;
  @JsonKey(includeIfNull: false)
  final String username;
  @JsonKey(includeIfNull: false)
  final String password;

  Data(
      {this.version,
      this.versionid,
      this.date,
      this.upgrade_image,
      this.release_notes,
      this.description,
      this.username,
      this.password});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
