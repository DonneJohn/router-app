///
///Created by slkk on 2019/9/23/0023 10:57
///
import 'package:json_annotation/json_annotation.dart';

part 'getInternetAccessResponseModel.g.dart';

@JsonSerializable()
class GetInternetAccessResponseModel {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetInternetAccessResponseModel(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory GetInternetAccessResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetInternetAccessResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetInternetAccessResponseModelToJson(this);
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
  final String type;
  @JsonKey(includeIfNull: false)
  final List<BlockList> whitelist;
  @JsonKey(includeIfNull: false)
  final List<BlockList> blacklist;

  Result(this.type, this.whitelist, this.blacklist);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class BlockList {
  String id;
  String host;

  BlockList(
    this.id,
    this.host,
  );

  factory BlockList.fromJson(Map<String, dynamic> json) =>
      _$BlockListFromJson(json);

  Map<String, dynamic> toJson() => _$BlockListToJson(this);
}
