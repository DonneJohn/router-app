///
///Created by slkk on 2019/9/16/0016 15:47
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/vpn/getVpnPoliciesResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocProvider.dart';


class GetVpnPolicyDestinationsBloc implements BlocBase {
  final BehaviorSubject<GetVpnPoliciesResponseModel> _subject =
      BehaviorSubject<GetVpnPoliciesResponseModel>();

  Sink<GetVpnPoliciesResponseModel> get inGetVpnInfo => _subject.sink;

  Stream<GetVpnPoliciesResponseModel> get outGetVpnInfo => _subject.stream;

  getVpnPolicy() {
    _doGetVpnPolicy(_subject);
  }

  Future<int> _doGetVpnPolicy(
      BehaviorSubject<GetVpnPoliciesResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetVpnPolicy,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(
              Constant.mqttCmdTypeGetVpnPolicy,
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

  BehaviorSubject<GetVpnPoliciesResponseModel> get subject => _subject;
}
