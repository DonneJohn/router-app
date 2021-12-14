///
///Created by slkk on 2019/9/16/0016 10:58
///
import 'dart:convert' show jsonEncode;
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocProvider.dart';


class UpdateVpnsBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inSetVpnInfo => _subject.sink;

  Stream<CommonResponseModel> get outSetVpnInfo => _subject.stream;

  setVpns(String id,
      {String protocol,
      String server,
      String username,
      String password,
      String status}) {
    _doSetVpns(_subject, id,
        protocol: protocol,
        server: server,
        username: username,
        password: password,
        status: status);
  }

  Future<int> _doSetVpns(
      BehaviorSubject<CommonResponseModel> subject, String id,
      {String protocol,
      String server,
      String username,
      String password,
      String status}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeUpdateVpn,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(
              Constant.mqttCmdTypeUpdateVpn,
              DateTime.now().millisecondsSinceEpoch.toString(),
              data: requestModel.Data(
                  id: id,
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
