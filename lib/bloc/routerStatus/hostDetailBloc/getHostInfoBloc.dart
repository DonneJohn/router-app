import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/routerStatus/hostDetail/getHostInfoModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../../blocProvider.dart';
import 'package:rxdart/rxdart.dart';

///
///Created by slkk on 2019/9/6/0006 13:20
///

class GetHostInfoBloc implements BlocBase{
  BehaviorSubject<HostInfoModel> get subject => _subject;
  final BehaviorSubject<HostInfoModel> _subject =
      BehaviorSubject<HostInfoModel>();

  getDeviceInfo(String mac) {
    doGetDeviceInfo(_subject, mac);
  }

  void doGetDeviceInfo(
      BehaviorSubject<HostInfoModel> subject, String mac) async {
    await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetHostInfo,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetHostInfo,
              DateTime.now().millisecondsSinceEpoch.toString(),
              data: Data(host: mac),
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
