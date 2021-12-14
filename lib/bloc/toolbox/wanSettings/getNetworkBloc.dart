///
///Created by slkk on 2019/9/11/0011 10:01
///
import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/wanSettings/getNetworkResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../../blocProvider.dart';
import 'package:rxdart/rxdart.dart';


class GetNetworkBloc implements BlocBase {
  final BehaviorSubject<GetNetworkResponseModel> _subject =
      BehaviorSubject<GetNetworkResponseModel>();

  getNetwork() {
    doGetNetwork(_subject);
  }

  Future<int> doGetNetwork(
      BehaviorSubject<GetNetworkResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetNetwork,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetNetwork,
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

  BehaviorSubject<GetNetworkResponseModel> get subject => _subject;
}
