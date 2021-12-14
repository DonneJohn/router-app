///
///Created by slkk on 2019/9/18/0018 13:06
///

import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/hardwareAndSystem/getTimeResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocProvider.dart';

class GetTimeBloc implements BlocBase {
  final BehaviorSubject<GetTimeResponseModel> _subject =
      BehaviorSubject<GetTimeResponseModel>();

  Sink<GetTimeResponseModel> get inGetTime => _subject.sink;

  Stream<GetTimeResponseModel> get outGetTime => _subject.stream;

  getTime() {
    _doGetTime(_subject);
  }

  Future<int> _doGetTime(BehaviorSubject<GetTimeResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetTime,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(
              Constant.mqttCmdTypeGetTime,
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

  BehaviorSubject<GetTimeResponseModel> get subject => _subject;
}
