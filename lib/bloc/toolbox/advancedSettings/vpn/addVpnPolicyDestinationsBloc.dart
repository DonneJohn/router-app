///
///Created by slkk on 2019/9/16/0016 16:11
///
import 'dart:convert';


import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/vpn/addVpnPolicyRequestModel.dart' as resModel;
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocProvider.dart';


class AddVpnPolicyDestinationsBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inAddVpnPolicy => _subject.sink;

  Stream<CommonResponseModel> get outAddVpnPolicy => _subject.stream;

  addVpnPolicy(List<resModel.Destinations> des) {
    _doAddVpnPolicy(_subject, des);
  }

  Future<int> _doAddVpnPolicy(BehaviorSubject<CommonResponseModel> subject,
      List<resModel.Destinations> des) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeAddVpnPolicy,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          resModel.AddVpnPolicyRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            resModel.Parameter(Constant.mqttCmdTypeAddVpnPolicy,
                DateTime.now().millisecondsSinceEpoch.toString(),
                data: resModel.Data(destinations: des)),
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
