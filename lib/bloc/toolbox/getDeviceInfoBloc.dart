///
///Created by slkk on 2019/11/7/0007 18:49
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/deviceDetect/deviceDetectResponseModel.dart';
import 'package:hg_router/models/toolbox/getDeviceInfoResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../blocProvider.dart';
import 'package:rxdart/rxdart.dart';

class GetDeviceInfoBloc implements BlocBase {
  final BehaviorSubject<GetDeviceInfoResponseModel> _subject =
      BehaviorSubject<GetDeviceInfoResponseModel>();

  getDeviceInfo() {
    _doGetDeviceInfo(_subject);
  }

  Future<int> _doGetDeviceInfo(
      BehaviorSubject<GetDeviceInfoResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeDeviceInfo,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeDeviceInfo,
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

  BehaviorSubject<GetDeviceInfoResponseModel> get subject => _subject;
}
