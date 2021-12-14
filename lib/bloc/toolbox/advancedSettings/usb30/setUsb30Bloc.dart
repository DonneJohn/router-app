///
///Created by slkk on 2019/11/2/0002 11:02
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocProvider.dart';

class SetUsb30Bloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  setUsb30(String status) {
    _doSetUsb30(_subject, status);
  }

  Future<int> _doSetUsb30(
      BehaviorSubject<CommonResponseModel> subject, String status) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetUsb30,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(Constant.mqttCmdTypeSetUsb30,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: Data(status: status)),
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
