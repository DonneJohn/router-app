///
///Created by slkk on 2019/9/16/0016 14:49
///
import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/vpn/vpnInfoResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';

import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocProvider.dart';

class GetVpnInfoBloc implements BlocBase {
  final BehaviorSubject<VpnInfoResponseModel> _subject =
      BehaviorSubject<VpnInfoResponseModel>();

  Sink<VpnInfoResponseModel> get inGetVpnInfo => _subject.sink;

  Stream<VpnInfoResponseModel> get outGetVpnInfo => _subject.stream;

  getVpnInfo(String id) {
    _doGetVpnInfo(_subject, id);
  }

  Future<int> _doGetVpnInfo(
      BehaviorSubject<VpnInfoResponseModel> subject, String id) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetVpnInfo,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(
              Constant.mqttCmdTypeGetVpnInfo,
              DateTime.now().millisecondsSinceEpoch.toString(),
              data: requestModel.Data(
                id: id,
              ),
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

  BehaviorSubject<VpnInfoResponseModel> get subject => _subject;
}
