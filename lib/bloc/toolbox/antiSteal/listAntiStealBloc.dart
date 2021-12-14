///
///Created by slkk on 2019/11/12/0012 13:08
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/antiSteal/getAntiStealResponse.dart';
import 'package:hg_router/models/toolbox/antiSteal/listAntiStealResponse.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocProvider.dart';


class ListAntiStealBloc implements BlocBase {
  final BehaviorSubject<ListAntiStealResponse> _subject =
  BehaviorSubject<ListAntiStealResponse>();

  getAntiStealList() {
    doGetAntiStealList(_subject);
  }

  Future<int> doGetAntiStealList(
      BehaviorSubject<ListAntiStealResponse> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeListAntiSteal,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeListAntiSteal,
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

  BehaviorSubject<ListAntiStealResponse> get subject => _subject;
}