import 'dart:convert';

import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/routerStatus/deviceRunningStatusModel.dart';
import 'package:hg_router/utils/SpUtil.dart';

import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

///
///Created by slkk on 2019/9/4/0004 10:38
///
class DeviceRunningStatusBloc extends BlocBase {
  final BehaviorSubject<DeviceRunningStatusModel> _subject =
      BehaviorSubject<DeviceRunningStatusModel>();

  getDeviceRunningStatus() {
    _doGetDeviceRunningStatus(_subject);
  }

  Future<int> _doGetDeviceRunningStatus(
      BehaviorSubject<DeviceRunningStatusModel> subject) async {
    return Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeRunningStatus,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeRunningStatus,
              DateTime.now().millisecondsSinceEpoch.toString(),
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

  BehaviorSubject<DeviceRunningStatusModel> get subject => _subject;
}
