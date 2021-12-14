///
///Created by slkk on 2019/11/1/0001 15:10
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/smartRateLimit/getSmartRateLimitResponse.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocProvider.dart';


class GetSmartRateLimitBloc implements BlocBase {
  final BehaviorSubject<GetSmartRateLimitResponseModel> _subject =
      BehaviorSubject<GetSmartRateLimitResponseModel>();

  getSmartRateLimit() {
    doGetSmartRateLimit(_subject);
  }

  Future<int> doGetSmartRateLimit(
      BehaviorSubject<GetSmartRateLimitResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetSmartRateLimit,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetSmartRateLimit,
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

  BehaviorSubject<GetSmartRateLimitResponseModel> get subject => _subject;
}
