///
///Created by slkk on 2019/11/5/0005 16:29
///
import 'dart:convert';
import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/toolbox/reboot/setRebootScheduleRequestModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

class SetRebootScheduleBloc extends BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inSetRebootSchedule => _subject.sink;

  Stream<CommonResponseModel> get outSetRebootSchedule => _subject.stream;

  setRebootSchedule({String status, String weekdays, String time}) {
    _doSetRebootSchedule(_subject,
        status: status, weekdays: weekdays, time: time);
  }

  Future<int> _doSetRebootSchedule(BehaviorSubject<CommonResponseModel> subject,
      {String status, String weekdays, String time}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeUpdateCronReboot,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          SetRebootScheduleRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
                Constant.mqttCmdTypeUpdateCronReboot,
                DateTime.now().millisecondsSinceEpoch.toString(),
                Data([
                  Schedule(
                      id: "0",
                      status: status,
                      repeat: Repeat(weekdays: weekdays),
                      time: time)
                ])),
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
