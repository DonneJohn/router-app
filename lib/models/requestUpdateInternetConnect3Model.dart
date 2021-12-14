import 'package:flutter/cupertino.dart';

///
///Created by slkk on 2019/9/9/0009 14:11
///
import 'package:json_annotation/json_annotation.dart';

part 'requestUpdateInternetConnect3Model.g.dart';

@JsonSerializable()
class RequestUpdateInternetConnect3Model {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  RequestUpdateInternetConnect3Model(
      this.version, this.sender, this.receiver, this.parameter);

  factory RequestUpdateInternetConnect3Model.formJson(
          Map<String, dynamic> json) =>
      _$RequestUpdateInternetConnect3ModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RequestUpdateInternetConnect3ModelToJson(this);
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
  final List<Timing> timing;

  Data(this.host, this.timing);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Timing {
  final String id;
  final String status;
  final Repeat repeat;
  final String start;
  final String end;

  Timing(
      {@required this.id,
      @required this.status,
      @required this.repeat,
      @required this.start,
      @required this.end});

  factory Timing.fromJson(Map<String, dynamic> json) => _$TimingFromJson(json);

  Map<String, dynamic> toJson() => _$TimingToJson(this);
}

@JsonSerializable()
class Repeat {
  final String type;
  final String weekdays;

  Repeat({@required this.type, @required this.weekdays});

  factory Repeat.fromJson(Map<String, dynamic> json) => _$RepeatFromJson(json);

  Map<String, dynamic> toJson() => _$RepeatToJson(this);
}
