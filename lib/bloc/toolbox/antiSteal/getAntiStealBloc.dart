///
///Created by slkk on 2019/10/31/0031 14:21
///
import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/antiSteal/getAntiStealResponse.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';

import 'package:rxdart/rxdart.dart';

import '../../blocProvider.dart';


class GetAntiStealBloc implements BlocBase {
  final BehaviorSubject<GetAntiStealResponseModel> _subject =
  BehaviorSubject<GetAntiStealResponseModel>();

  getAntiSteal() {
    doGetAntiSteal(_subject);
  }

  Future<int> doGetAntiSteal(
      BehaviorSubject<GetAntiStealResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetAntiSteal,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetAntiSteal,
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

  BehaviorSubject<GetAntiStealResponseModel> get subject => _subject;
}