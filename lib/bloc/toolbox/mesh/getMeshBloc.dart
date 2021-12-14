///
///Created by slkk on 2019/11/2/0002 10:56
///
import 'dart:convert';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonRequestModel.dart';
import 'package:hg_router/models/commonResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/capacitiesService.dart';
import 'package:rxdart/rxdart.dart';

import '../../blocProvider.dart';


class GetMeshBloc implements BlocBase {
  final BehaviorSubject<CommonResponseModel> _subject =
  BehaviorSubject<CommonResponseModel>();

  getMesh() {
    _doGetMesh(_subject);
  }

  Future<int> _doGetMesh(
      BehaviorSubject<CommonResponseModel> subject) async {
    return await Future.value(CapacitiesService.getInstance().sendMessage(
        Constant.mqttCmdTypeGetMesh,
        Constant.mqttTopicToRouterPrefix +
            SpUtil.getString(Constant.routerUUID, defValue: ''),
        jsonEncode(
          CommonRequestModel(
            "1.0",
            SpUtil.getString(Constant.appUUID),
            SpUtil.getString(Constant.routerUUID),
            Parameter(
              Constant.mqttCmdTypeGetMesh,
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

  BehaviorSubject<CommonResponseModel> get subject => _subject;
}