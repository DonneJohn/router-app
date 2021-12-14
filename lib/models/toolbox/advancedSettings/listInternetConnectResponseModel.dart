///
///Created by slkk on 2019/11/12/0012 19:03
///
import 'package:json_annotation/json_annotation.dart';

part 'listInternetConnectResponseModel.g.dart';

@JsonSerializable()
class ListInternetConnectResponse {
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  ListInternetConnectResponse(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory ListInternetConnectResponse.fromJson(Map<String, dynamic> json) =>
      _$ListInternetConnectResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListInternetConnectResponseToJson(this);
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
  final String status;
  @JsonKey(includeIfNull: false)
  final String mode;
  @JsonKey(includeIfNull: false)
  final List<Host> hosts;

  Result({this.status, this.mode, this.hosts});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Host {
  @JsonKey(includeIfNull: false)
  final String id;
  @JsonKey(includeIfNull: false)
  final String mac;
  @JsonKey(includeIfNull: false)
  final String name;
  @JsonKey(includeIfNull: false)
  final String nickname;
  @JsonKey(includeIfNull: false)
  final String type;
  @JsonKey(includeIfNull: false)
  final List<TimingModel> timing;

  Host({this.id, this.mac, this.name, this.nickname, this.type, this.timing});

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

  Map<String, dynamic> toJson() => _$HostToJson(this);
}

@JsonSerializable()
class TimingModel {
  @JsonKey(includeIfNull: false)
  final String status;
  @JsonKey(includeIfNull: false)
  final String id;
  @JsonKey(includeIfNull: false)
  final Repeat repeat;
  @JsonKey(includeIfNull: false)
  final String start;
  @JsonKey(includeIfNull: false)
  final String end;

  TimingModel({this.status, this.id, this.repeat, this.start, this.end});

  factory TimingModel.fromJson(Map<String, dynamic> json) =>
      _$TimingModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimingModelToJson(this);
}

@JsonSerializable()
class Repeat {
  @JsonKey(includeIfNull: false)
  final String type;
  @JsonKey(includeIfNull: false)
  final String weekdays;

  Repeat({this.type, this.weekdays});

  factory Repeat.fromJson(Map<String, dynamic> json) => _$RepeatFromJson(json);

  Map<String, dynamic> toJson() => _$RepeatToJson(this);
}
