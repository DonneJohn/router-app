///
///Created by slkk on 2019/11/12/0012 13:09
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/toolbox/antiSteal/addAntiStealRequest.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import '../../blocProvider.dart';

class AddAntiStealBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  addAntiSteal(String type, List<AntiStealItem> list) {
    _doAddAntiSteal(_subject, type, list);
  }

  Future<int> _doAddAntiSteal(BehaviorSubject<CommonResponseModel> subject,
      String type, List<AntiStealItem> list) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeAddAntiSteal,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          AddAntiStealRequest(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
                Constant.mqttCmdTypeAddAntiSteal,
                DateTime.now().millisecondsSinceEpoch.toString(),
                type == "whitelist"
                    ? Data(whitelists: list)
                    : Data(blacklists: list)),
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
