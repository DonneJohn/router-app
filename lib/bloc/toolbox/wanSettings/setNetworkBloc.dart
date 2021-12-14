///
///Created by slkk on 2019/9/11/0011 10:54
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/toolbox/wanSettings/setNetworkModel.dart' as setNetworkModel;
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../../blocProvider.dart';
import 'package:rxdart/rxdart.dart';

class SetNetworkBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  setNetwork(String mode,
      {setNetworkModel.Pppoe pppoe,
      setNetworkModel.Dhcp dhcp,
      setNetworkModel.Statics static,
      setNetworkModel.Repeaters repeaters}) {
    _doSetNetwork(_subject, mode,
        pppoe: pppoe, dhcp: dhcp, static: static, repeaters: repeaters);
  }

  Future<int> _doSetNetwork(
      BehaviorSubject<CommonResponseModel> subject, String mode,
      {setNetworkModel.Pppoe pppoe,
      setNetworkModel.Dhcp dhcp,
      setNetworkModel.Statics static,
      setNetworkModel.Repeaters repeaters}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetNetwork,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          setNetworkModel.SetNetworkModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            setNetworkModel.Parameter(
                Constant.mqttCmdTypeSetNetwork,
                DateTime.now().millisecondsSinceEpoch.toString(),
                setNetworkModel.Data(mode,
                    PPPoE: pppoe,
                    DHCP: dhcp,
                    Static: static,
                    Repeater: repeaters)),
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
