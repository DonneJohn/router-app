import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/routerStatus/getHostsListResponse.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import '../blocProvider.dart';

///
///Created by slkk on 2019/9/4
///
class DeviceListBloc implements BlocBase {
  final BehaviorSubject<HostsListResponse> _subject =
      BehaviorSubject<HostsListResponse>();

  getDevice() {
    doGetDevice(_subject);
  }

  Future<int> doGetDevice(BehaviorSubject<HostsListResponse> subject) async {

    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeListHosts,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeListHosts,
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

  BehaviorSubject<HostsListResponse> get subject => _subject;
}
