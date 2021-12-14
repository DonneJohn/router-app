///
///Created by slkk on 2019/9/18/0018 09:12
///

import 'dart:convert';


import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocProvider.dart';

class RestoreDefaultBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inRestoreDefault => _subject.sink;

  Stream<CommonResponseModel> get outRestoreDefault => _subject.stream;

  restore() {
    _doRestore(_subject);
  }

  Future<int> _doRestore(BehaviorSubject<CommonResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeRestoreDefault,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(
              Constant.mqttCmdTypeRestoreDefault,
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

  BehaviorSubject<CommonResponseModel> get subject => _subject;
}
