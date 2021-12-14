///
///Created by slkk on 2019/11/1/0001 16:17
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/toolbox/smartRateLimit/setSmartRateLimitRequestModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocProvider.dart';

class SetSmartRateLimitBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  setSmartRateLimit(
      {String status, String policy, String upstream, String downstream}) {
    _doSetSmartRateLimit(_subject,
        status: status,
        policy: policy,
        upstream: upstream,
        downstream: downstream);
  }

  Future<int> _doSetSmartRateLimit(BehaviorSubject<CommonResponseModel> subject,
      {String status,
      String policy,
      String upstream,
      String downstream}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetSmartRateLimit,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          SetSmartRateLimitRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
                Constant.mqttCmdTypeSetSmartRateLimit,
                DateTime.now().millisecondsSinceEpoch.toString(),
                Data(status, policy, Bandwidth(upstream, downstream))),
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

  BehaviorSubject<CommonResponseModel> get subject => _subject;
}
