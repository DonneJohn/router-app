import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/vpn/getVpnsResponse.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocProvider.dart';

///
///Created by slkk on 2019/9/12/0012 14:05
///
class GetVpnsBloc implements BlocBase {
  final BehaviorSubject<GetVpnsResponse> _subject =
      BehaviorSubject<GetVpnsResponse>();

  getVpns() {
    _getVpns(_subject);
  }

  Future<int> _getVpns(BehaviorSubject<GetVpnsResponse> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetVpns,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetVpns,
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

  BehaviorSubject<GetVpnsResponse> get subject => _subject;
}
