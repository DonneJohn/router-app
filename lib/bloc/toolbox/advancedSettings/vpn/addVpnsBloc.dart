///
///Created by slkk on 2019/9/16/0016 13:47
///
import 'dart:convert';


import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';

import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocProvider.dart';


class AddVpnBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inAddVpnInfo => _subject.sink;

  Stream<CommonResponseModel> get outAddVpnInfo => _subject.stream;

  addVpn(
      {String name,
      String protocol,
      String server,
      String username,
      String password,
      String status}) {
    _doAddVpn(_subject,
        protocol: protocol,
        server: server,
        username: username,
        password: password,
        status: status);
  }

  Future<int> _doAddVpn(BehaviorSubject<CommonResponseModel> subject,
      {String name,
      String protocol,
      String server,
      String username,
      String password,
      String status}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeAddVpn,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(
              Constant.mqttCmdTypeAddVpn,
              DateTime.now().millisecondsSinceEpoch.toString(),
              data: requestModel.Data(
                  name: name,
                  protocol: protocol,
                  server: server,
                  username: username,
                  password: password,
                  status: status),
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

  BehaviorSubject<CommonResponseModel> get subject => _subject;
}
