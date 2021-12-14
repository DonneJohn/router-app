///
///Created by slkk on 2019/11/18/0018 14:51
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/getDeviceVersionResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../blocProvider.dart';
import 'package:rxdart/rxdart.dart';

class GetDeviceVersionBloc implements BlocBase {
  final BehaviorSubject<GetDeviceVersionResponseModel> _subject =
      BehaviorSubject<GetDeviceVersionResponseModel>();

  getCurrentVersion() {
    _doGetCurrentVersion(_subject);
  }

  Future<int> _doGetCurrentVersion(
      BehaviorSubject<GetDeviceVersionResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetUpgrade,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetUpgrade,
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

  BehaviorSubject<GetDeviceVersionResponseModel> get subject => _subject;
}
