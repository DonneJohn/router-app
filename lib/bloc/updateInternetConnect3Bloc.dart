///
///Created by slkk on 2019/9/9/0009 14:19
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/requestUpdateInternetConnect3Model.dart'
    as requestModel;
import 'package:hg_router/utils/SpUtil.dart';

import 'package:hg_router/utils/capacitiesService.dart';
import 'blocProvider.dart';
import 'package:rxdart/rxdart.dart';

class UpdateInternetConnect3Bloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  updateInternetConnect3() async {
    doUpdateInternetConnect3(_subject);
  }

  Future<int> doUpdateInternetConnect3(
      BehaviorSubject<CommonResponseModel> subject) async {
    return CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeUpdateInternetConnect3,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.RequestUpdateInternetConnect3Model(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(
              Constant.mqttCmdTypeUpdateInternetConnect3,
              DateTime.now().millisecondsSinceEpoch.toString(),
              requestModel.Data("00:11:22:33:44:55", [
                requestModel.Timing(
                    id: "0",
                    status: 'on',
                    repeat: requestModel.Repeat(type: 'once', weekdays: ''),
                    start: '00',
                    end: '')
              ]),
            ),
          ),
        ),
        0,
        false,
        subject);
  }

  @override
  void dispose() {
    _subject.close();
  }

  BehaviorSubject<CommonResponseModel> get subject => _subject;
}
