///
///Created by slkk on 2019/9/9/0009 16:14
///
import 'package:json_annotation/json_annotation.dart';

part 'getListCronRebootResponseModel.g.dart';

@JsonSerializable()
class GetListCronRebootResponseModel {
  final int errorCode;
  final String version;
  final String sender;
  final String receiver;
  final ReturnParameter return_parameter;

  GetListCronRebootResponseModel(this.errorCode, this.version, this.sender,
      this.receiver, this.return_parameter);

  factory GetListCronRebootResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetListCronRebootResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetListCronRebootResponseModelToJson(this);
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
  final List<Schedule> schedules;

  Result(this.schedules);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Schedule {
  String id;
  String status;
  Repeat repeat;
  String time;

  Schedule(
    this.id,
    this.status,
    this.repeat,
    this.time,
  );

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}

@JsonSerializable()
class Repeat {
  final String type;
  final String weekdays;

  Repeat(this.type, this.weekdays);

  factory Repeat.fromJson(Map<String, dynamic> json) => _$RepeatFromJson(json);

  Map<String, dynamic> toJson() => _$RepeatToJson(this);
}
