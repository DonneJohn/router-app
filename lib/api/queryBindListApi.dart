import 'package:dio/dio.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/loginAndLogout/getBindListResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import 'api.dart';

///
///Created by slkk on 2019/11/6/0006 16:24
///
class QueryBindListApi {
  BaseOptions options;

  QueryBindListApi() {
    var token = SpUtil.getString(Constant.keyAppToken);
    if (token.isNotEmpty) {
      logger.d('keyAppToken token: $token');
    }
    options = new BaseOptions(
        receiveTimeout: 5000,
        connectTimeout: 5000,
        headers: {'Authorization': 'Bearer ' + token ?? ''});
  }

  Future<GetBindListResponseModel> getBindList() async {
    String url = Api.baseUrl + Api.getBindList;
    MyDioResponse myResponse = await RestfulUtils.getInstance().get(true, url);
    if (myResponse.statusCode == 200) {
      return GetBindListResponseModel.fromJson(myResponse?.response?.data);
    } else {
      return GetBindListResponseModel(code: 900);
    }
  }
}
