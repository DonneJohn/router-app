// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setNetworkModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetNetworkModel _$SetNetworkModelFromJson(Map<String, dynamic> json) {
  return SetNetworkModel(
    json['version'] as String,
    json['sender'] as String,
    json['receiver'] as String,
    json['parameter'] == null
        ? null
        : Parameter.fromJson(json['parameter'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$SetNetworkModelToJson(SetNetworkModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'parameter': instance.parameter,
    };

Parameter _$ParameterFromJson(Map<String, dynamic> json) {
  return Parameter(
    json['type'] as String,
    json['sequence'] as String,
    json['data'] == null
        ? null
        : Data.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ParameterToJson(Parameter instance) => <String, dynamic>{
      'type': instance.type,
      'sequence': instance.sequence,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) {
  return Data(
    json['mode'] as String,
    PPPoE: json['PPPoE'] == null
        ? null
        : Pppoe.fromJson(json['PPPoE'] as Map<String, dynamic>),
    DHCP: json['DHCP'] == null
        ? null
        : Dhcp.fromJson(json['DHCP'] as Map<String, dynamic>),
    Static: json['Static'] == null
        ? null
        : Statics.fromJson(json['Static'] as Map<String, dynamic>),
    Repeater: json['Repeater'] == null
        ? null
        : Repeaters.fromJson(json['Repeater'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{
    'mode': instance.mode,
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

Pppoe _$PppoeFromJson(Map<String, dynamic> json) {
  return Pppoe(
    json['username'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$PppoeToJson(Pppoe instance) => <String, dynamic>{
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

Statics _$StaticsFromJson(Map<String, dynamic> json) {
  return Statics(
    json['ip'] as String,
    json['netmask'] as String,
    json['gateway'] as String,
    json['dns'] as String,
    dns2: json['dns2'] as String,
  );
}

Map<String, dynamic> _$StaticsToJson(Statics instance) => <String, dynamic>{
      'ip': instance.ip,
      'netmask': instance.netmask,
      'gateway': instance.gateway,
      'dns': instance.dns,
      'dns2': instance.dns2,
    };

Repeaters _$RepeatersFromJson(Map<String, dynamic> json) {
  return Repeaters(
    json['ssid'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$RepeatersToJson(Repeaters instance) => <String, dynamic>{
      'ssid': instance.ssid,
      'password': instance.password,
    };
