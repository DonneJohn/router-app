///
///Created by slkk on 2019/9/20/0020 14:22
///
import 'dart:convert';

import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/routerStatus/hostDetail/updateHostDetailRequestModel.dart'
    as request;
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

class UpdateHostDetailBloc extends BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inUpdateDeviceDetail => _subject.sink;

  Stream<CommonResponseModel> get outUpdateDeviceDetail => _subject.stream;

  updateRateLimit(String host,
      {String status, String upstream, String downstream}) {
    _doUpdateRateLimit(
      _subject,
      host,
      limit: request.Ratelimit(
          status: status, upstream: upstream, downstream: downstream),
    );
  }

  Future<int> _doUpdateRateLimit(
    BehaviorSubject<CommonResponseModel> subject,
    String host, {
    request.Ratelimit limit,
  }) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeSetHostRateLimit,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          request.UpdateHostDetailRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            request.Parameter(
              Constant.mqttCmdTypeSetHostRateLimit,
              DateTime.now().millisecondsSinceEpoch.toString(),
              request.Data(host, ratelimit: limit),
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

  BehaviorSubject<CommonResponseModel> get subject => _subject;
}
