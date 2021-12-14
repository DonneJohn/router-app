///
///Created by slkk on 2019/11/12/0012 13:12
///
import 'package:json_annotation/json_annotation.dart';

part 'listAntiStealResponse.g.dart';

@JsonSerializable()
class ListAntiStealResponse {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  ListAntiStealResponse(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory ListAntiStealResponse.fromJson(Map<String, dynamic> json) =>
      _$ListAntiStealResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListAntiStealResponseToJson(this);
}

@JsonSerializable()
class ReturnParameter {
  final String type;
  final String sequence;
  final String status;
  final Result result;

  ReturnParameter(this.type, this.sequence, this.status, this.result);

  factory ReturnParameter.fromJson(Map<String, dynamic> json) =>
      _$ReturnParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ReturnParameterToJson(this);
}

@JsonSerializable()
class Result {
  @JsonKey(includeIfNull: false)
  final List<AntiStealItem> whitelists;
  @JsonKey(includeIfNull: false)
  final List<AntiStealItem> blacklists;

  Result(this.whitelists, this.blacklists);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class AntiStealItem {
  final String id;
  final String nickname;
  final String mac;

  AntiStealItem(this.id, this.nickname, this.mac);

  factory AntiStealItem.fromJson(Map<String, dynamic> json) =>
      _$AntiStealItemFromJson(json);

  Map<String, dynamic> toJson() => _$AntiStealItemToJson(this);
}
