///
///Created by slkk on 2019/9/18/0018 13:08
///

import 'package:json_annotation/json_annotation.dart';

part 'getTimeResponseModel.g.dart';

@JsonSerializable()
class GetTimeResponseModel {
  final String version;
  final String sender;
  final String receiver;
  final Parameter return_parameter;

  GetTimeResponseModel(
      this.version, this.sender, this.receiver, this.return_parameter);

  factory GetTimeResponseModel.formJson(Map<String, dynamic> json) =>
      _$GetTimeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetTimeResponseModelToJson(this);
}

@JsonSerializable()
class Parameter {
  final String type;
  final String sequence;
  final String status;
  final Result result;

  Parameter(this.type, this.sequence, this.status, this.result);

  factory Parameter.fromJson(Map<String, dynamic> json) =>
      _$ParameterFromJson(json);

  Map<String, dynamic> toJson() => _$ParameterToJson(this);
}

@JsonSerializable()
class Result {
  final String timezone;
  final Date date;
  final Time time;

  Result(this.timezone, this.date, this.time);

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable()
class Date {
  final String year;
  final String month;
  final String day;

  Date(this.year, this.month, this.day);

  factory Date.fromJson(Map<String, dynamic> json) => _$DateFromJson(json);

  Map<String, dynamic> toJson() => _$DateToJson(this);
}

@JsonSerializable()
class Time {
  final String hour;
  final String minute;

  Time(this.hour, this.minute);

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}
