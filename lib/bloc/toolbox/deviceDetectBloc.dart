///
///Created by slkk on 2019/11/7/0007 14:40
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/deviceDetect/deviceDetectResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../blocProvider.dart';
import 'package:rxdart/rxdart.dart';


class DeviceDetectBloc implements BlocBase {
  final BehaviorSubject<DeviceDetectResponseModel> _subject =
  BehaviorSubject<DeviceDetectResponseModel>();

  deviceDetect() {
    doDeviceDetect(_subject);
  }

  Future<int> doDeviceDetect(
      BehaviorSubject<DeviceDetectResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeDeviceDetect,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeDeviceDetect,
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

  BehaviorSubject<DeviceDetectResponseModel> get subject => _subject;
}