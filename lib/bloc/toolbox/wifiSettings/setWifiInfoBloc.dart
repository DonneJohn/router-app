///
///Created by slkk on 2019/9/10/0010 09:41
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart' as commonResponse;
import 'package:hg_router/models/toolbox/wifiSettings/requestSetWifiInfoModel.dart' as setWifiModel;
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../../blocProvider.dart';
import 'package:rxdart/rxdart.dart';

class SetWifiInfoBloc implements BlocBase {
  final BehaviorSubject<commonResponse.CommonResponseModel>
      _setWifiInfoController =
      BehaviorSubject<commonResponse.CommonResponseModel>();

  Sink<commonResponse.CommonResponseModel> get inSetWifiInfo =>
      _setWifiInfoController.sink;

  Stream<commonResponse.CommonResponseModel> get outSetWifiInfo =>
      _setWifiInfoController.stream;

  SetWifiInfoBloc() {}

  setWifiInfo(
      {String type,
      String status,
      String ssid,
      String hidden,
      String channel,
      String bandwidth,
      String power,
      String signal,
      String security,
      String secret}) {
    _doSetWifiInfo(
        type: type,
        status: status,
        ssid: ssid,
        hidden: hidden,
        channel: channel,
        bandwidth: bandwidth,
        power: power,
        signal: signal,
        security: security,
        secret: secret);
  }

  void _doSetWifiInfo(
      {String type,
      String status,
      String ssid,
      String hidden,
      String channel,
      String bandwidth,
      String power,
      String signal,
      String security,
      String secret}) async {
    await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetWifiInfo,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          setWifiModel.RequestSetWifiInfoModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            setWifiModel.Parameter(
              Constant.mqttCmdTypeSetWifiInfo,
              DateTime.now().millisecondsSinceEpoch.toString(),
              setWifiModel.Data(
                type,
                status,
                ssid,
                hidden,
                channel,
                bandwidth,
                power,
                signal,
                security,
                secret,
              ),
            ),
          ),
        ),
        0,
        false,
        _setWifiInfoController));
  }

  @override
  void dispose() {
    _setWifiInfoController.close();
  }
}
