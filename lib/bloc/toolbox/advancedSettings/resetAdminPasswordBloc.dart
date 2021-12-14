///
///Created by slkk on 2019/9/18/0018 14:34
///
import 'dart:convert';


import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocProvider.dart';

class ResetAdminPasswordBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inResetPassword => _subject.sink;

  Stream<CommonResponseModel> get outResetPassword => _subject.stream;

  resetPassword(String password) {
    _doResetPassword(_subject, password);
  }

  Future<int> _doResetPassword(
      BehaviorSubject<CommonResponseModel> subject, String password) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeReSetpwd,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(Constant.mqttCmdTypeReSetpwd,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: requestModel.Data(password: password)),
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
