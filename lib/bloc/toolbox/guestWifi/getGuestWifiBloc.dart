///
///Created by slkk on 2019/10/31/0031 16:31
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/guestWifi/getGuestWifiResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocProvider.dart';

class GetGuestWifiBloc implements BlocBase {
  final BehaviorSubject<GetGuestWifiResponseModel> _subject =
      BehaviorSubject<GetGuestWifiResponseModel>();

  getGuestWifi() {
    _doGetGuestWifi(_subject);
  }

  Future<int> _doGetGuestWifi(
      BehaviorSubject<GetGuestWifiResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetGuestWiFi,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetGuestWiFi,
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

  BehaviorSubject<GetGuestWifiResponseModel> get subject => _subject;
}
