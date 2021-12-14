///
///Created by slkk on 2019/11/13/0013 10:55
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import '../../../blocProvider.dart';

class DeleteInternetConnectBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  deleteInternetConnect({String host, List<Timing> list}) {
    _doDeleteInternetConnect(_subject, host: host, list: list);
  }

  Future<int> _doDeleteInternetConnect(
      BehaviorSubject<CommonResponseModel> subject,
      {String host,
      List<Timing> list}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeDeleteInternetConnect,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(Constant.mqttCmdTypeDeleteInternetConnect,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: Data(host: host, timing: list)),
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
