// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceDetectResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceDetectResponseModel _$DeviceDetectResponseModelFromJson(
    Map<String, dynamic> json) {
  return DeviceDetectResponseModel(
    json['errorCode'] as int,
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['return_parameter'] == null
        ? null
        : ReturnParameter.fromJson(
            json['return_parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DeviceDetectResponseModelToJson(
        DeviceDetectResponseModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'return_parameter': instance.return_parameter,
    };

ReturnParameter _$ReturnParameterFromJson(Map<String, dynamic> json) {
  return ReturnParameter(
    json['type'] as String,
    json['sequence'] as String,
    json['status'] as String,
    json['result'] == null
        ? null
        : Result.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ReturnParameterToJson(ReturnParameter instance) =>
    <String, dynamic>{
      'type': instance.type,
      'sequence': instance.sequence,
      'status': instance.status,
      'result': instance.result,
    };

Result _$ResultFromJson(Map<String, dynamic> json) {
  return Result(
    json['phase'] as String,
    json['wanState'] as String,
    json['internetState'] == null
        ? null
        : InternetState.fromJson(json['internetState'] as Map<String, dynamic>),
    json['wifiState'] == null
        ? null
        : WifiState.fromJson(json['wifiState'] as Map<String, dynamic>),
    json['wifi5GState'] == null
        ? null
        : Wifi5GState.fromJson(json['wifi5GState'] as Map<String, dynamic>),
    json['password'] == null
        ? null
        : Password.fromJson(json['password'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{
    'phase': instance.phase,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('wanState', instance.wanState);
  writeNotNull('internetState', instance.internetState);
  writeNotNull('wifiState', instance.wifiState);
  writeNotNull('wifi5GState', instance.wifi5GState);
  writeNotNull('password', instance.password);
  return val;
}

InternetState _$InternetStateFromJson(Map<String, dynamic> json) {
  return InternetState(
    json['status'] as String,
    json['reason'] as String,
  );
}

Map<String, dynamic> _$InternetStateToJson(InternetState instance) =>
    <String, dynamic>{
      'status': instance.status,
      'reason': instance.reason,
    };

WifiState _$WifiStateFromJson(Map<String, dynamic> json) {
  return WifiState(
    json['status'] as String,
  );
}

Map<String, dynamic> _$WifiStateToJson(WifiState instance) => <String, dynamic>{
      'status': instance.status,
    };

Wifi5GState _$Wifi5GStateFromJson(Map<String, dynamic> json) {
  return Wifi5GState(
    json['status'] as String,
  );
}

Map<String, dynamic> _$Wifi5GStateToJson(Wifi5GState instance) =>
    <String, dynamic>{
      'status': instance.status,
    };

Password _$PasswordFromJson(Map<String, dynamic> json) {
  return Password(
    json['wifiPassword'] as String,
    json['wifi5GPassword'] as String,
    json['adminPassword'] as String,
  );
}

Map<String, dynamic> _$PasswordToJson(Password instance) => <String, dynamic>{
      'wifiPassword': instance.wifiPassword,
      'wifi5GPassword': instance.wifi5GPassword,
      'adminPassword': instance.adminPassword,
    };
