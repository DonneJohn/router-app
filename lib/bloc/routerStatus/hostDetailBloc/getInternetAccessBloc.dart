///
///Created by slkk on 2019/9/23/0023 10:54
///
import 'dart:convert';

import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/routerStatus/hostDetail/getInternetAccessResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

class GetInternetAccessBloc extends BlocBase {
  final BehaviorSubject<GetInternetAccessResponseModel> _subject =
      BehaviorSubject<GetInternetAccessResponseModel>();

  Sink<GetInternetAccessResponseModel> get inGetInternetAccess => _subject.sink;

  Stream<GetInternetAccessResponseModel> get outGetInternetAccess =>
      _subject.stream;

  getInternetAccess(String host) {
    _doGetInternetAccess(
      _subject,
      host,
    );
  }

  Future<int> _doGetInternetAccess(
      BehaviorSubject<GetInternetAccessResponseModel> subject,
      String host) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetInternetAccess,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(Constant.mqttCmdTypeGetInternetAccess,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: Data(host: host)),
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

  BehaviorSubject<GetInternetAccessResponseModel> get subject => _subject;
}
