///
///Created by slkk on 2019/11/11/0011 13:48
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart' as requestModel;
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';
import 'blocProvider.dart';

class GetDevicesBasicBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inBloc => _subject.sink;

  Stream<CommonResponseModel> get outBloc => _subject.stream;

  getDevicesBasic() {
    _doGetDevicesBasic(_subject);
  }

  Future<int> _doGetDevicesBasic(
      BehaviorSubject<CommonResponseModel> subject) async {
    return await CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeDevicesBasic,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          requestModel.CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            requestModel.Parameter(Constant.mqttCmdTypeDevicesBasic,
                DateTime.now().millisecondsSinceEpoch.toString()),
          ),
        ),
        0,
        false,
        subject);
  }

  @override
  void dispose() {
    _subject.close();
  }

  BehaviorSubject<CommonResponseModel> get subject => _subject;
}
