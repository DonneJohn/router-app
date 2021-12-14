// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getNetworkResponseModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNetworkResponseModel _$GetNetworkResponseModelFromJson(
    Map<String, dynamic> json) {
  return GetNetworkResponseModel(
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

Map<String, dynamic> _$GetNetworkResponseModelToJson(
        GetNetworkResponseModel instance) =>
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
    json['mode'] as String,
    json['status'] as String,
    json['ip'] as String,
    json['gateway'] as String,
    json['dnsMode'] as String,
    json['dns'] as String,
    json['dns2'] as String,
    PPPoE: json['PPPoE'] == null
        ? null
        : PPPOE.fromJson(json['PPPoE'] as Map<String, dynamic>),
    DHCP: json['DHCP'] == null
        ? null
        : Dhcp.fromJson(json['DHCP'] as Map<String, dynamic>),
    Static: json['Static'] == null
        ? null
        : STATIC.fromJson(json['Static'] as Map<String, dynamic>),
    Repeater: json['Repeater'] == null
        ? null
        : REPEATER.fromJson(json['Repeater'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{
    'mode': instance.mode,
    'status': instance.status,
    'ip': instance.ip,
    'gateway': instance.gateway,
    'dnsMode': instance.dnsMode,
    'dns': instance.dns,
    'dns2': instance.dns2,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('PPPoE', instance.PPPoE);
  writeNotNull('DHCP', instance.DHCP);
  writeNotNull('Static', instance.Static);
  writeNotNull('Repeater', instance.Repeater);
  return val;
}

PPPOE _$PPPOEFromJson(Map<String, dynamic> json) {
  return PPPOE(
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$PPPOEToJson(PPPOE instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

Dhcp _$DhcpFromJson(Map<String, dynamic> json) {
  return Dhcp(
    json['dns'] as String,
    json['dns2'] as String,
  );
}

Map<String, dynamic> _$DhcpToJson(Dhcp instance) => <String, dynamic>{
      'dns': instance.dns,
      'dns2': instance.dns2,
    };

STATIC _$STATICFromJson(Map<String, dynamic> json) {
  return STATIC(
    json['ip'] as String,
    json['network'] as String,
    json['gateway'] as String,
    json['dns'] as String,
    json['dns2'] as String,
  );
}

Map<String, dynamic> _$STATICToJson(STATIC instance) => <String, dynamic>{
      'ip': instance.ip,
      'network': instance.network,
      'gateway': instance.gateway,
      'dns': instance.dns,
      'dns2': instance.dns2,
    };

REPEATER _$REPEATERFromJson(Map<String, dynamic> json) {
  return REPEATER(
    json['ssid'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$REPEATERToJson(REPEATER instance) => <String, dynamic>{
      'ssid': instance.ssid,
      'password': instance.password,
    };
