///
///Created by slkk on 2019/9/23/0023 14:03
///
import 'dart:convert';

import 'package:hg_router/bloc/blocProvider.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/models/routerStatus/hostDetail/modifyInternetAccessRequestModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

class AddInternetAccessBloc extends BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
      BehaviorSubject<CommonResponseModel>();

  Sink<CommonResponseModel> get inAddInternetAccess => _subject.sink;

  Stream<CommonResponseModel> get outAddInternetAccess => _subject.stream;

  addInternetAccess(String host,
      {List<BlockList> whitelist, List<BlockList> blacklist}) {
    _doAddInternetAccess(_subject, host,
        whitelist: whitelist, blacklist: blacklist);
  }

  Future<int> _doAddInternetAccess(
      BehaviorSubject<CommonResponseModel> subject, String host,
      {List<BlockList> whitelist, List<BlockList> blacklist}) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeAddInternetAccess,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          ModifyInternetAccessRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
                Constant.mqttCmdTypeAddInternetAccess,
                DateTime.now().millisecondsSinceEpoch.toString(),
                Data(host, whitelist: whitelist, blacklist: blacklist)),
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
