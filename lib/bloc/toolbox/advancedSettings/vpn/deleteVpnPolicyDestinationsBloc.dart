///
///Created by slkk on 2019/9/16/0016 17:07
///
import 'dart:convert';


import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/vpn/addVpnPolicyRequestModel.dart' as resModel;
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocProvider.dart';


class DeleteVpnPolicyDestinationsBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inDeleteVpnPolicy => _subject.sink;

  Stream<CommonResponseModel> get outDeleteVpnPolicy => _subject.stream;

  deleteVpnPolicy(String id) {
    _doDeleteVpnPolicy(_subject, id);
  }

  Future<int> _doDeleteVpnPolicy(
      BehaviorSubject<CommonResponseModel> subject, String id) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeDeleteVpnPolicy,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          resModel.AddVpnPolicyRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            resModel.Parameter(Constant.mqttCmdTypeDeleteVpnPolicy,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: resModel.Data(
                    destinations: [resModel.Destinations(id: id)])),
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
