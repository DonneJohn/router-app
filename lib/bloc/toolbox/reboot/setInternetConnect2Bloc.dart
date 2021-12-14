///
///Created by slkk on 2019/9/22/0022 14:48
///
import 'dart:convert';

import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

class SetInternetConnect2Bloc extends BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inSetInternetConnect2 => _subject.sink;

  Stream<CommonResponseModel> get outSetInternetConnect2 => _subject.stream;

  setInternetConnect2(String id, List<Timing> timing) {
    _doSetInternetConnect2(_subject, timing);
  }

  Future<int> _doSetInternetConnect2(
      BehaviorSubject<CommonResponseModel> subject, List<Timing> timing) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetInternetConnect2,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(Constant.mqttCmdTypeSetInternetConnect2,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: requestModel.Data(timing: timing)),
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
