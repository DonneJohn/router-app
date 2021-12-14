///
///Created by slkk on 2019/9/23/0023 13:59
///
import 'package:json_annotation/json_annotation.dart';

part 'modifyInternetAccessRequestModel.g.dart';

@JsonSerializable()
class ModifyInternetAccessRequestModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  ModifyInternetAccessRequestModel(
      this.version, this.sender, this.receiver, this.parameter);

  factory ModifyInternetAccessRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$ModifyInternetAccessRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ModifyInternetAccessRequestModelToJson(this);
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
  @JsonKey(includeIfNull: false)
  final List<BlockList> whitelist;
  @JsonKey(includeIfNull: false)
  final List<BlockList> blacklist;

  Data(this.host, {this.whitelist, this.blacklist});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class BlockList {
  @JsonKey(includeIfNull: false)
  String id;
  @JsonKey(includeIfNull: false)
  String host;

  BlockList({
    this.id,
    this.host,
  });

  factory BlockList.fromJson(Map<String, dynamic> json) =>
      _$BlockListFromJson(json);

  Map<String, dynamic> toJson() => _$BlockListToJson(this);
}
