///
///Created by slkk on 2019/11/9/0009 13:52
///
import 'package:json_annotation/json_annotation.dart';

part 'requestUnbindDeviceModel.g.dart';

///路由器能力集
@JsonSerializable()
class RequestUnbindDeviceModel {
  final List<Device> devices;

  RequestUnbindDeviceModel(this.devices);

  factory RequestUnbindDeviceModel.formJson(Map<String, dynamic> json) =>
      _$RequestUnbindDeviceModelFromJson(json);

  Map<String, dynamic> toJson() => _$RequestUnbindDeviceModelToJson(this);
}

@JsonSerializable()
class Device {
  final String mac;

  Device(this.mac);

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
