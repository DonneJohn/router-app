///
///Created by slkk on 2019/9/22/0022 14:09
///
import 'dart:convert';

import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

class SetInternetConnectBloc extends BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inSetInternetConnect => _subject.sink;

  Stream<CommonResponseModel> get outSetInternetConnect => _subject.stream;

  setInternetConnect(String host, String type) {
    _doSetInternetConnect(_subject, host, type);
  }

  Future<int> _doSetInternetConnect(
      BehaviorSubject<CommonResponseModel> subject,
      String host,
      String type) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetInternetConnect,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(Constant.mqttCmdTypeSetInternetConnect,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: requestModel.Data(host: host, type: type)),
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
