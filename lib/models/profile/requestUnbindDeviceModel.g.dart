// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestUnbindDeviceModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestUnbindDeviceModel _$RequestUnbindDeviceModelFromJson(
    Map<String, dynamic> json) {
  return RequestUnbindDeviceModel(
    (json['devices'] as List)
        ?.map((e) =>
            e == null ? null : Device.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RequestUnbindDeviceModelToJson(
        RequestUnbindDeviceModel instance) =>
    <String, dynamic>{
      'devices': instance.devices,
    };

Device _$DeviceFromJson(Map<String, dynamic> json) {
  return Device(
    json['mac'] as String,
  );
}

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
      'mac': instance.mac,
    };
