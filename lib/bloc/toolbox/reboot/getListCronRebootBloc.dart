///
///Created by slkk on 2019/9/22/0022 13:09
///
import 'dart:convert';
import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/toolbox/reboot/getListCronRebootResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

class GetListCronRebootBloc extends BlocBase {
  final BehaviorSubject<GetListCronRebootResponseModel> _subject =
      BehaviorSubject<GetListCronRebootResponseModel>();

  Sink<GetListCronRebootResponseModel> get inGetRebootSchedule => _subject.sink;

  Stream<GetListCronRebootResponseModel> get outGetRebootSchedule =>
      _subject.stream;

  getRebootSchedule() {
    _doGetRebootSchedule(
      _subject,
    );
  }

  Future<int> _doGetRebootSchedule(
    BehaviorSubject<GetListCronRebootResponseModel> subject,
  ) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeListCronReboot,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeListCronReboot,
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

  BehaviorSubject<GetListCronRebootResponseModel> get subject => _subject;
}
