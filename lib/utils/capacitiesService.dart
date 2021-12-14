import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gatewayip/gatewayip.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/deviceCapacityResponseModel.dart';
import 'package:hg_router/models/toolbox/advancedSettings/listInternetConnectResponseModel.dart';
import 'package:hg_router/models/toolbox/antiSteal/getAntiStealResponse.dart';
import 'package:hg_router/models/toolbox/antiSteal/listAntiStealResponse.dart';
import 'package:hg_router/models/toolbox/deviceDetect/deviceDetectResponseModel.dart';
import 'package:hg_router/models/toolbox/getDeviceInfoResponseModel.dart';
import 'package:hg_router/models/hardwareAndSystem/getLedResponseModel.dart';
import 'package:hg_router/models/hardwareAndSystem/getTimeResponseModel.dart';
import 'package:hg_router/models/routerStatus/deviceRunningStatusModel.dart';
import 'package:hg_router/models/routerStatus/deviceStatusResponse.dart';
import 'package:hg_router/models/routerStatus/getHostsListResponse.dart';
import 'package:hg_router/models/routerStatus/hostDetail/getInternetAccessResponseModel.dart';
import 'package:hg_router/models/routerStatus/hostDetail/hostDetailModel.dart';
import 'package:hg_router/models/toolbox/getDeviceVersionResponseModel.dart';
import 'package:hg_router/models/toolbox/guestWifi/getGuestWifiResponseModel.dart';
import 'package:hg_router/models/toolbox/reboot/getListCronRebootResponseModel.dart';
import 'package:hg_router/models/toolbox/smartRateLimit/getSmartRateLimitResponse.dart';
import 'package:hg_router/models/toolbox/wanSettings/getNetworkResponseModel.dart';
import 'package:hg_router/models/vpn/getVpnPoliciesResponseModel.dart';
import 'package:hg_router/models/vpn/getVpnsResponse.dart';
import 'package:hg_router/models/toolbox/wifiSettings/getWIFiInfoModel.dart';
import 'package:hg_router/models/vpn/vpnInfoResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'package:hg_router/utils/utils.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:synchronized/synchronized.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:collection';
import 'dart:convert';
import 'SpUtil.dart';

///
///Created by slkk on 2019/8/31/0031 10:33
///

class CapacitiesService {
  static Lock _lock = Lock();
  static CapacitiesService _singleton;
  static mqtt.MqttClient client;
  static bool isError = false;

  ///TODO 真是broker 需要从平台更新
  static String broker = 'androidframework.site';
  static bool isInit = false;
  static StreamSubscription subscription;
  static LinkedHashMap<String, Subject> _objectMap =
      LinkedHashMap<String, Subject>();

  static CapacitiesService getInstance() {
    if (_singleton == null) {
      _lock.synchronized(() {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = CapacitiesService._();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  CapacitiesService._();

  Future<bool> init() async {
    //初始化mqtt
    return Future.value(_connect());
  }

  Future<bool> _connect() async {
    /// First create a client, the client is constructed with a broker name, client identifier
    /// and port if needed. The client identifier (short ClientId) is an identifier of each MQTT
    /// client connecting to a MQTT broker. As the word identifier already suggests, it should be unique per broker.
    /// The broker uses it for identifying the client and the current state of the client. If you don’t need a state
    /// to be hold by the broker, in MQTT 3.1.1 you can set an empty ClientId, which results in a connection without any state.
    /// A condition is that clean session connect flag is true, otherwise the connection will be rejected.
    /// The client identifier can be a maximum length of 23 characters. If a port is not specified the standard port
    /// of 1883 is used.
    /// If you want to use websockets rather than TCP see below.
    ///TODO 域名和端口 要改成下发
    String agent_host = SpUtil.getString(Constant.agent_host);
    int agent_port = SpUtil.getInt(Constant.agent_port);

    client = mqtt.MqttClient(broker, '');
    client.port = 8883;

    /// A websocket URL must start with ws:// or wss:// or Dart will throw an exception, consult your websocket MQTT broker
    /// for details.
    /// To use websockets add the following lines -:
    // client.useWebSocket = true;

    /// This flag causes the mqtt client to use an alternate method to perform the WebSocket handshake. This is needed for certain
    /// matt clients (Particularly Amazon Web Services IOT) that will not tolerate additional message headers in their get request
    // client.useAlternateWebSocketImplementation = true;
    // client.port = 443; // ( or whatever your WS port is)
    /// Note do not set the secure flag if you are using wss, the secure flags is for TCP sockets only.

    /// Set logging on if needed, defaults to off
    client.logging(on: false);

    /// If you intend to use a keep alive value in your connect message that is not the default(60s)
    /// you must set it here
    client.keepAlivePeriod = 30;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = _onDisconnected;

    client.secure = true;

//    ByteData data = await rootBundle.load('assets/pem/cert.pem');
//
//    final SecurityContext context = SecurityContext.defaultContext;
//    context.setTrustedCertificatesBytes(data.buffer.asUint8List());
//    client.securityContext = context;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier(
            SpUtil.getString(Constant.appUUID, defValue: 'appDefaultUUID'))
        .authenticateAs('hg_app', 'fky123456')
        // Must agree with the keep alive set above or not set
        .startClean() // Non persistent session for testing
        .keepAliveFor(30)
        // If you set this you must set a will message
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .withWillQos(mqtt.MqttQos.atLeastOnce);
    logger.i('MQTT client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    try {
      var connectResult = await client.connect();
      if (client.connectionState == mqtt.MqttConnectionState.connected) {
        logger.i('MQTT client connected');
        //如果登录成功且已绑定
        if (!isInit) {
          subscription = client.updates.listen(_onMessage);
          logger.d('subscribe topic');
          return initMqttTopic();
        }
      } else {
        logger.e('ERROR: MQTT client connection failed - '
            'disconnecting, state is ${client.connectionState}');
        _disconnect();
        return false;
      }
    } catch (e) {
      logger.i(e);
      _disconnect();
      return false;
    }
  }

  ///绑定设备成功后初始化订阅和路由器通信的topic
  Future<bool> initMqttTopic() {
    ///订阅 设备端回复给移动端的topic /request/to-router/app/<app-uuid>
    subscribeToTopic(Constant.mqttTopicFromRouterPrefix +
        SpUtil.getString(Constant.appUUID));
//    subscribeToTopic(Constant.mqttTopicFromRouterPrefix);

    ///订阅 平台推送消息给所有移动端topic
    subscribeToTopic(Constant.mqttTopicPushFromPlatform);

    ///订阅 平台推送给单个移动端的topic
    subscribeToTopic(Constant.mqttTopicPushFromPlatformPrefix +
        SpUtil.getString(Constant.appUUID));

    ///订阅 设备端推送给移动端的topic
    subscribeToTopic(Constant.mqttTopicPushFromRouterPrefix +
        SpUtil.getString(Constant.routerUUID));

    //获取路由器的能力集 TODO Version sender receiver
//    commonRequestModel.CommonRequestModel myCommonRequestModel =
//        commonRequestModel.CommonRequestModel(
//            '1.0',
//            SpUtil.getString(Constant.appUUID),
//            SpUtil.getString(Constant.routerUUID),
//            commonRequestModel.Parameter(
//                Constant.mqttCmdTypeDevicesCapabilities,
//                DateTime.now().millisecondsSinceEpoch.toString()));
//    logger.i("appUUID${SpUtil.getString(Constant.appUUID)}");
//    logger.i("routerUUID${SpUtil.getString(Constant.routerUUID)}");

//    String sendTopic = Constant.mqttTopicToRouterPrefix +
//        SpUtil.getString(Constant.routerUUID);
//    logger.i(myCommonRequestModel.toJson().toString());
//    sendMessage(Constant.mqttCmdTypeDevicesCapabilities, sendTopic,
//        jsonEncode(myCommonRequestModel), 0, false, null);
    isInit = true;
    return Future.value(true);
  }

  void _disconnect() {
    client.disconnect();
    _onDisconnected();
  }

  void _onDisconnected() {
    if (subscription != null) {
      subscription.cancel();
    }
    subscription = null;
    logger.i('MQTT client disconnected');
  }

  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    logger.i(event.length);
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    /// The above may seem a little convoluted for users only interested in the
    /// payload, some users however may be interested in the received publish message,
    /// lets not constrain ourselves yet until the package has been in the wild
    /// for a while.
    /// The payload is a byte buffer, this will be specific to the topic
    logger.i('MQTT Response: topic is <${event[0].topic}>, '
        'payload is <-- ${message} -->');
    logger.i(client.connectionState);
    Map map = jsonDecode(message);
    if (event[0].topic ==
        Constant.mqttTopicFromRouterPrefix +
            SpUtil.getString(Constant.appUUID)) {
      String cmdType = map['return_parameter']['type'];
      isError = false;
      _handleMessage(cmdType, map);
      logger.i("cmdType: $cmdType");
    } else if (event[0].topic ==
        Constant.mqttTopicPushFromRouterPrefix + Constant.routerUUID) {
      String cmdType = map['parameter']['type'];
      _handMessagePushFromRouter(cmdType, map);
      logger.i("cmdType: $cmdType");
    }
  }

  void _handleMessage(String cmdType, Map map) {
    var blocSubscriber = _objectMap[cmdType];
    if (blocSubscriber == null) {
      return;
    }
    if (blocSubscriber.isClosed) {
      _objectMap.remove(blocSubscriber);
      return;
    }
    if (cmdType == Constant.mqttCmdTypeDevicesCapabilities) {
      DeviceCapacityResponseModel deviceCapacityResponseModel =
          DeviceCapacityResponseModel.formJson(map);
      logger.i("capacity version: " +
          deviceCapacityResponseModel.return_parameter.result.version);
    } else if (cmdType == Constant.mqttCmdTypeDevicesHosts) {
      var deviceResponse = HostsListResponse.fromJson(map);
      _objectMap[Constant.mqttCmdTypeDevicesHosts].sink.add(deviceResponse);
    } else if (cmdType == Constant.mqttCmdTypeRunningStatus) {
      var deviceRunningStatusModel = DeviceRunningStatusModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeRunningStatus]
          .sink
          .add(deviceRunningStatusModel);
    } else if (cmdType == Constant.mqttCmdTypGetHostInfo2) {
      if (_objectMap[Constant.mqttCmdTypGetHostInfo2] == null) {
        return;
      }
      var deviceDetailModel = HostDetailModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypGetHostInfo2].sink.add(deviceDetailModel);
    } else if (cmdType == Constant.mqttCmdTypeGetHostInfo) {
      var deviceInfoModel = HostDetailModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetHostInfo].sink.add(deviceInfoModel);
    } else if (cmdType == Constant.mqttCmdTypeUpdateInternetConnect3) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeUpdateInternetConnect3]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetWifiInfo) {
      var responseModel = GetWIFiInfoResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetWifiInfo].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetWifiInfo) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetWifiInfo].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetNetwork) {
      var responseModel = GetNetworkResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetNetwork].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetNetwork) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetNetwork].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetVpns) {
      var responseModel = GetVpnsResponse.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetVpns].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeUpdateVpn) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeUpdateVpn].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeAddVpn) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeAddVpn].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetVpnInfo) {
      var responseModel = VpnInfoResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetVpnInfo].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetVpnPolicy) {
      var responseModel = GetVpnPoliciesResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetVpnPolicy].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeAddVpnPolicy) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeAddVpnPolicy]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeDeleteVpnPolicy) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeDeleteVpnPolicy]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeUpdateVpnPolicy) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeUpdateVpnPolicy]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeReboot) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeReboot].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetLed) {
      var responseModel = GetLedResponseModel.formJson(map);
      _objectMap[Constant.mqttCmdTypeGetLed].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetLed) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetLed].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeRestoreDefault) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeRestoreDefault]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetTime) {
      var responseModel = GetTimeResponseModel.formJson(map);
      _objectMap[Constant.mqttCmdTypeGetTime].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetTime) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetTime].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeReSetpwd) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeReSetpwd].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeDeviceStatus) {
      var responseModel = DeviceStatusResponse.fromJson(map);
      _objectMap[Constant.mqttCmdTypeDeviceStatus].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetHostRateLimit) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetHostRateLimit]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeListCronReboot) {
      var getInternetConnectResponseModel =
          GetListCronRebootResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeListCronReboot]
          .sink
          .add(getInternetConnectResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetInternetConnect) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetInternetConnect]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetInternetConnect2) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetInternetConnect2]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetInternetAccess) {
      var getInternetAccessResponseModel =
          GetInternetAccessResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetInternetAccess]
          .sink
          .add(getInternetAccessResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetInternetAccess) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetInternetAccess]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeAddInternetAccess) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeAddInternetAccess]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeDeleteInternetAccess) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeDeleteInternetAccess]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeUpdateInternetAccess) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeUpdateInternetAccess]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeAddInternetConnect) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeAddInternetConnect]
          .sink
          .add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetHostInfo) {
      var commonResponseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetHostInfo].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeListHosts) {
      var commonResponseModel = HostsListResponse.fromJson(map);
      if (_objectMap[Constant.mqttCmdTypeListHosts].isClosed) {
        return;
      }
      _objectMap[Constant.mqttCmdTypeListHosts].sink.add(commonResponseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetAntiSteal) {
      var responseModel = GetAntiStealResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetAntiSteal].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetAntiSteal) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetAntiSteal].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetGuestWiFi) {
      var responseModel = GetGuestWifiResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetGuestWiFi].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetGuestWiFi) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetGuestWiFi].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetSmartRateLimit) {
      var responseModel = GetSmartRateLimitResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetSmartRateLimit].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetSmartRateLimit) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetSmartRateLimit].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetMesh) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetMesh].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetMesh) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetMesh].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeChangePassword) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeChangePassword].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetUsb30) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetUsb30].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetUsb30) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetUsb30].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeUpdateCronReboot) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeUpdateCronReboot].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeDeviceDetect) {
      ///TODO 正式版本去掉等待
      Future.delayed(Duration(seconds: 2), () {
        var responseModel = DeviceDetectResponseModel.fromJson(map);
        _objectMap[Constant.mqttCmdTypeDeviceDetect].sink.add(responseModel);
      });
    } else if (cmdType == Constant.mqttCmdTypeDeviceInfo) {
      var responseModel = GetDeviceInfoResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeDeviceInfo].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeDevicesBasic) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeDevicesBasic].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeStartSpeedTest) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeStartSpeedTest].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeListAntiSteal) {
      var responseModel = ListAntiStealResponse.fromJson(map);
      _objectMap[Constant.mqttCmdTypeListAntiSteal].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeAddAntiSteal) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeAddAntiSteal].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeDeleteAntiSteal) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeDeleteAntiSteal].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeListInternetConnect) {
      var responseModel = ListInternetConnectResponse.fromJson(map);
      _objectMap[Constant.mqttCmdTypeListInternetConnect]
          .sink
          .add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeDeleteInternetConnect) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeDeleteInternetConnect]
          .sink
          .add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeGetUpgrade) {
      var responseModel = GetDeviceVersionResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeGetUpgrade].sink.add(responseModel);
    } else if (cmdType == Constant.mqttCmdTypeSetUpgrade) {
      var responseModel = CommonResponseModel.fromJson(map);
      _objectMap[Constant.mqttCmdTypeSetUpgrade].sink.add(responseModel);
    }
  }

  void subscribeToTopic(String topic) {
    logger.i('subscribeToTopic' + topic);
    if (client.connectionState == mqtt.MqttConnectionState.connected) {
      logger.i('Subscribing to ${topic.trim()}');
      client.subscribe(topic, mqtt.MqttQos.exactlyOnce);
    }
  }

  void unsubscribeFromTopic(String topic) {
    if (client.connectionState == mqtt.MqttConnectionState.connected) {
      logger.i('Unsubscribing from ${topic.trim()}');
      client.unsubscribe(topic);
    }
  }

  void _handMessagePushFromRouter(String cmdType, Map map) {
    if (cmdType == Constant.mqttCmdTypeChangeURL) {
      ///TODO 处理设备推送的地址更新
    } else if (cmdType == Constant.mqttCmdTypeHostSignin) {
      ///TODO 处理新设备接入
    } else if (cmdType == Constant.mqttCmdTypeHostSteal) {
      ///TODO 处理终端拦截通知
    } else if (cmdType == Constant.mqttCmdTypeOffline) {
      ///TODO 处理设备状态通知
    }
  }

  Future<int> sendByMqtt(
      {@required String cmdType,
      String topic,
      int qosValue,
      bool isRetain,
      String message,
      Subject subject}) async {
    try {
      if (!isInit) {
        await init();
      }
      logger.i('MQTT sendMessage:$topic $message');

      final mqtt.MqttClientPayloadBuilder builder =
          mqtt.MqttClientPayloadBuilder();

      builder.addString(message);

      return client.publishMessage(
        topic,
        mqtt.MqttQos.values[qosValue],
        builder.payload,
        retain: isRetain,
      );
    } catch (e) {
      logger.e(e.toString());
      return 0;
    }
  }

  Future<int> sendMessage(String cmdType, String topic, String message,
      int qosValue, bool isRetain, Subject subject) async {
    if (subject != null) {
      _objectMap[cmdType] = subject;
    }

    ///优先从本地路由器去获取，获取不到在再通过mqtt 获取
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      /// 连接方式为数据流量，走mqtt
      return sendByMqtt(
          subject: subject,
          cmdType: cmdType,
          topic: topic,
          message: message,
          qosValue: qosValue,
          isRetain: isRetain);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      /// 连接方式为wifi 先本地获取，获取不到走mqtt
      try {
        await Gatewayip.gatewayIp.then((onValue) {
          logger.d("get gateway ip from plugin" + onValue);
          String url = "https://$onValue:" +
              Constant.routerLocalHttpsPort +
              "/" +
              cmdType;
          RestfulUtils.getInstance()
              .post(false, url, data: message)
              .then((onValue) {
            logger.d("http code: ${onValue.statusCode}");
            if (onValue.statusCode == 200) {
              _handleMessage(cmdType, jsonDecode(onValue.response.data));
              return 200;
            } else if (onValue.statusCode == 900) {
              isError = true;
              Future.delayed(Duration(seconds: 5), () {
                if (isError) {
                  _handleMessage(cmdType, jsonDecode('{"errorCode": 900}'));
                }
              });
              if (cmdType == Constant.mqttCmdTypeDevicesBasic) {
                return 0;
              }
              return sendByMqtt(
                  subject: subject,
                  cmdType: cmdType,
                  topic: topic,
                  message: message,
                  qosValue: qosValue,
                  isRetain: isRetain);
            } else {
              return sendByMqtt(
                  subject: subject,
                  cmdType: cmdType,
                  topic: topic,
                  message: message,
                  qosValue: qosValue,
                  isRetain: isRetain);
            }
          });
        });
      } on PlatformException {
        logger.e("get gateway ip from ios or android error");
      }
    }

    void dispose() {
      subscription?.cancel();
    }
  }
}
