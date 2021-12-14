import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/routerStatus/hostDetail/hostDetailModel.dart';
import 'package:hg_router/utils/SpUtil.dart';

import 'package:hg_router/utils/capacitiesService.dart';
import '../../blocProvider.dart';
import 'package:rxdart/rxdart.dart';

///
///Created by slkk on 2019/9/5/0005 13:46
///

class GetHostDetailBloc implements BlocBase {
  BehaviorSubject<HostDetailModel> get subject => _subject;
  final BehaviorSubject<HostDetailModel> _subject =
      BehaviorSubject<HostDetailModel>();

  getDeviceDetail(String mac) {
    print(DateTime.now().millisecondsSinceEpoch);
    doGetDeviceDetail(_subject, mac);
  }

  void doGetDeviceDetail(
      BehaviorSubject<HostDetailModel> subject, String mac) async {
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
