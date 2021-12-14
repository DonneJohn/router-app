///
///Created by slkk on 2019/11/6/0006 16:46
///
import 'package:json_annotation/json_annotation.dart';

part 'getBindListResponseModel.g.dart';

@JsonSerializable()
class GetBindListResponseModel {
  final int code;
  @JsonKey(includeIfNull: false)
  final String result;
  @JsonKey(includeIfNull: false)
  final List<BindDevice> data;

  GetBindListResponseModel({this.code, this.result, this.data});

  factory GetBindListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetBindListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetBindListResponseModelToJson(this);
}

@JsonSerializable()
class BindDevice {
  final String mac;
  final String model;
  final String nickname;
  final String type;
  final String uuid;

  BindDevice(this.mac, this.model, this.nickname, this.type, this.uuid);

  factory BindDevice.fromJson(Map<String, dynamic> json) =>
      _$BindDeviceFromJson(json);

  Map<String, dynamic> toJson() => _$BindDeviceToJson(this);
}
