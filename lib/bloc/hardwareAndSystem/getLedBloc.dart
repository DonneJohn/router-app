///
///Created by slkk on 2019/9/17/0017 16:23
///
import 'dart:convert';


import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/hardwareAndSystem/getLedResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';

import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../blocProvider.dart';

class GetLedBloc implements BlocBase {
  final BehaviorSubject<GetLedResponseModel> _subject =
      BehaviorSubject<GetLedResponseModel>();

  Sink<GetLedResponseModel> get inGetLed => _subject.sink;

  Stream<GetLedResponseModel> get outGetLed => _subject.stream;

  getLed() {
    _doGetLed(_subject);
  }

  Future<int> _doGetLed(BehaviorSubject<GetLedResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetLed,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(Constant.mqttCmdTypeGetLed,
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

  BehaviorSubject<GetLedResponseModel> get subject => _subject;
}
