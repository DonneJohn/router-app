///
///Created by slkk on 2019/11/13/0013 10:07
///
import 'package:json_annotation/json_annotation.dart';

part 'addInternetConnectRequestModel.g.dart';

@JsonSerializable()
class AddInternetConnectRequestModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  AddInternetConnectRequestModel(
      this.version, this.sender, this.receiver, this.parameter);

  factory AddInternetConnectRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddInternetConnectRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddInternetConnectRequestModelToJson(this);
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
  List<TimingRequestModel> timing;

  Data({this.host, this.timing});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class TimingRequestModel {
  @JsonKey(includeIfNull: false)
  final String status;
  @JsonKey(includeIfNull: false)
  final RequestRepeat repeat;
  @JsonKey(includeIfNull: false)
  final String start;
  @JsonKey(includeIfNull: false)
  final String end;

  TimingRequestModel({this.status,this.repeat, this.start, this.end});

  factory TimingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TimingRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimingRequestModelToJson(this);
}

@JsonSerializable()
class RequestRepeat {
  @JsonKey(includeIfNull: false)
  final String type;
  @JsonKey(includeIfNull: false)
  final String weekdays;

  RequestRepeat({this.type, this.weekdays});

  factory RequestRepeat.fromJson(Map<String, dynamic> json) => _$RequestRepeatFromJson(json);

  Map<String, dynamic> toJson() => _$RequestRepeatToJson(this);
}
