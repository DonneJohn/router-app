///
///Created by slkk on 2019/11/1/0001 14:29
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/toolbox/guestWifi/setGuestWifiRequestModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocProvider.dart';

class SetGuestWifiBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  setGuestWifi({String status, String ssid, String password}) {
    _doSetGuestWifi(_subject, status: status, ssid: ssid, password: password);
  }

  Future<int> _doSetGuestWifi(BehaviorSubject<CommonResponseModel> subject,
      {String status, String ssid, String password}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetGuestWiFi,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          SetGuestWifiRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
                Constant.mqttCmdTypeSetGuestWiFi,
                DateTime.now().millisecondsSinceEpoch.toString(),
                Data(status, ssid, password)),
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
