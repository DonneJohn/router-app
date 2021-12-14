import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import 'blocProvider.dart';

///
///Created by slkk on 2019/11/11/0011 18:03
///
class SpeedTestBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inBloc => _subject.sink;

  Stream<CommonResponseModel> get outBloc => _subject.stream;

  startSpeedTest() {
    _doStartSpeedTest(_subject);
  }

  Future<int> _doStartSpeedTest(
      BehaviorSubject<CommonResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeStartSpeedTest,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(Constant.mqttCmdTypeStartSpeedTest,
                DateTime.now().millisecondsSinceEpoch.toString()),
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
