///
///Created by slkk on 2019/11/13/0013 10:04
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/toolbox/advancedSettings/addInternetConnectRequestModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import '../../../blocProvider.dart';

class AddInternetConnectBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  addInternetConnect({String host, List<TimingRequestModel> list}) {
    _doAddInternetConnect(_subject, host: host, list: list);
  }

  Future<int> _doAddInternetConnect(
      BehaviorSubject<CommonResponseModel> subject,
      {String host,
      List<TimingRequestModel> list}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeAddInternetConnect,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          AddInternetConnectRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
                Constant.mqttCmdTypeAddInternetConnect,
                DateTime.now().millisecondsSinceEpoch.toString(),
                Data(host: host, timing: list)),
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
