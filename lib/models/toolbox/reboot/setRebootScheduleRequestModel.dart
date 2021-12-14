///
///Created by slkk on 2019/11/5/0005 16:24
///
import 'package:json_annotation/json_annotation.dart';

part 'setRebootScheduleRequestModel.g.dart';

@JsonSerializable()
class SetRebootScheduleRequestModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter parameter;

  SetRebootScheduleRequestModel(
      this.version, this.sender, this.receiver, this.parameter);

  factory SetRebootScheduleRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SetRebootScheduleRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SetRebootScheduleRequestModelToJson(this);
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
  final List<Schedule> schedules;

  Data(this.schedules);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Schedule {
  String id;
  String status;
  @JsonKey(includeIfNull: false)
  Repeat repeat;
  String time;

  Schedule({
    this.id,
    this.status,
    this.repeat,
    this.time,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable()
class Repeat {
  @JsonKey(includeIfNull: false)
  final String type;
  final String weekdays;

  Repeat({this.type, this.weekdays});

  factory Repeat.fromJson(Map<String, dynamic> json) => _$RepeatFromJson(json);

  Map<String, dynamic> toJson() => _$RepeatToJson(this);
}
