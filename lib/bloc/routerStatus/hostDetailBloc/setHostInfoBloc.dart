///
///Created by slkk on 2019/9/29/0029 14:54
///
import 'dart:convert';

import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/routerStatus/hostDetail/setHostInfoModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import '../../blocProvider.dart';
import 'package:rxdart/rxdart.dart';

class SetHostInfoBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inSetHostInfo => _subject.sink;

  Stream<CommonResponseModel> get outSetHostInfo => _subject.stream;

  setHostInfo(String mac,
      {String nickname, String type, String vendor, String model}) {
    _doSetHostInfo(_subject, mac,
        nickname: nickname, type: type, vendor: vendor, model: model);
  }

  void _doSetHostInfo(BehaviorSubject<CommonResponseModel> subject, String mac,
      {String nickname, String type, String vendor, String model}) async {
    await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetHostInfo,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          SetHostInfoModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeSetHostInfo,
              DateTime.now().millisecondsSinceEpoch.toString(),
              Data(
                host: mac,
                info: Info(
                    nickname: nickname,
                    type: type,
                    vendor: vendor,
                    model: model),
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
}
