///
///Created by slkk on 2019/9/20/0020 10:20
///
import 'dart:convert';

import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/routerStatus/deviceStatusResponse.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

class DeviceStatusBloc extends BlocBase {
  final BehaviorSubject<DeviceStatusResponse> _subject =
      BehaviorSubject<DeviceStatusResponse>();

  Sink<DeviceStatusResponse> get inDeviceStatus => _subject.sink;

  Stream<DeviceStatusResponse> get outDeviceStatus => _subject.stream;

  getDeviceStatus() {
    _doGetDeviceStatus(_subject);
  }

  Future<int> _doGetDeviceStatus(
      BehaviorSubject<DeviceStatusResponse> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeDeviceStatus,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeDeviceStatus,
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

  BehaviorSubject<DeviceStatusResponse> get subject => _subject;
}
