///
///Created by slkk on 2019/9/18/0018 14:04
///
import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocProvider.dart';

class SetTimeBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inSetTime => _subject.sink;

  Stream<CommonResponseModel> get outSetTime => _subject.stream;

  setTime(String timezone) {
    _doSetTime(_subject, timezone);
  }

  Future<int> _doSetTime(
      BehaviorSubject<CommonResponseModel> subject, String timezone) async {
    logger.i('SetTimeBloc'+timezone);
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetTime,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(Constant.mqttCmdTypeSetTime,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: requestModel.Data(timezone: timezone)),
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
