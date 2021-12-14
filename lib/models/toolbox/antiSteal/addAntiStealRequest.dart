import 'package:equatable/equatable.dart';
///
///Created by slkk on 2019/11/12/0012 13:49
///
import 'package:json_annotation/json_annotation.dart';

part 'addAntiStealRequest.g.dart';

@JsonSerializable()
class AddAntiStealRequest {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  AddAntiStealRequest(this.version, this.sender, this.receiver, this.parameter);

  factory AddAntiStealRequest.fromJson(Map<String, dynamic> json) =>
      _$AddAntiStealRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddAntiStealRequestToJson(this);
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
  @JsonKey(includeIfNull: false)
  final List<AntiStealItem> whitelists;
  @JsonKey(includeIfNull: false)
  final List<AntiStealItem> blacklists;

  Data({this.whitelists, this.blacklists});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AntiStealItem extends Equatable{
  @JsonKey(includeIfNull: false)
  final String nickname;
  @JsonKey(includeIfNull: false)
  final String mac;
  @JsonKey(includeIfNull: false)
  final String id;

  AntiStealItem({this.nickname, this.mac, this.id});

  factory AntiStealItem.fromJson(Map<String, dynamic> json) =>
      _$AntiStealItemFromJson(json);

  Map<String, dynamic> toJson() => _$AntiStealItemToJson(this);

  @override
  // TODO: implement props
  List<Object> get props => [mac];
}
