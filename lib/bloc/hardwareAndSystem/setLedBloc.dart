///
///Created by slkk on 2019/9/17/0017 16:24
///

import 'dart:convert';


import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../blocProvider.dart';

class SetLedBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inSetLed => _subject.sink;

  Stream<CommonResponseModel> get outSetLed => _subject.stream;

  setLed(String status) {
    _doSetLed(_subject, status);
  }

  Future<int> _doSetLed(
      BehaviorSubject<CommonResponseModel> subject, String status) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetLed,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(Constant.mqttCmdTypeSetLed,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: requestModel.Data(status: status)),
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
