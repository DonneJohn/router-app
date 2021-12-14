///
///Created by slkk on 2019/11/12/0012 18:05
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/advancedSettings/listInternetConnectResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import '../../../blocProvider.dart';

class ListInternetConnectBloc implements BlocBase {
  final BehaviorSubject<ListInternetConnectResponse> _subject =
      BehaviorSubject<ListInternetConnectResponse>();

  getInternetConnectList() {
    _doGetInternetConnectList(_subject);
  }

  Future<int> _doGetInternetConnectList(
      BehaviorSubject<ListInternetConnectResponse> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeListInternetConnect,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeListInternetConnect,
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

  BehaviorSubject<ListInternetConnectResponse> get subject => _subject;
}
