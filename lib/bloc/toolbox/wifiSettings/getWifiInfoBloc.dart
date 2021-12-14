///
///Created by slkk on 2019/9/9/0009 17:19
///

import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/wifiSettings/getWIFiInfoModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../../blocProvider.dart';
import 'package:rxdart/rxdart.dart';

class GetWifiInfoBloc implements BlocBase {
  BehaviorSubject<GetWIFiInfoResponseModel> get subject => _subject;
  final BehaviorSubject<GetWIFiInfoResponseModel> _subject =
      BehaviorSubject<GetWIFiInfoResponseModel>();

  getWifiInfo(String type) {
    _doGetWifiInfo(_subject, type);
  }

  void _doGetWifiInfo(
      BehaviorSubject<GetWIFiInfoResponseModel> subject, String type) async {
    await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetWifiInfo,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetWifiInfo,
              DateTime.now().millisecondsSinceEpoch.toString(),
              data: Data(type: type),
            ),
          ),
        ),
        0,
        false,
        subject));
  }

  @override
  void dispose() {
    _subject.close();
  }
}
