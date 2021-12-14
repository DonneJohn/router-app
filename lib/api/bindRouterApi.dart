import 'package:dio/dio.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'api.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/routerStatus/bindRouterResponseModel.dart';

///
///Created by slkk on 2019/9/5/0005 13:46
///
class BindRouterApi {
  BaseOptions options;

  BindRouterApi() {
    var token = SpUtil.getString(Constant.keyAppToken);
    if (token.isNotEmpty) {
      logger.d('token: $token');
    }
    options = new BaseOptions(
        receiveTimeout: 5000,
        connectTimeout: 5000,
        headers: {'Authorization': 'Bearer ' + token ?? ''});
  }

  Future<BindRouterResponseModel> bindRouter(String macAddress) async {
    String url = Api.baseUrl + Api.bindRouterUrl;

    var account = SpUtil.getString(Constant.keyUserName);
    if (account.isEmpty) {
      return null;
    }
    print('account: $account');
    MyDioResponse response = await RestfulUtils.getInstance().put(true,url,
        data: {"mac": macAddress, "type": "owner"});
    if (response.statusCode == 200) {
      return BindRouterResponseModel.formJson(response.response.data);
    } else {
      return BindRouterResponseModel(code: response.statusCode);
    }
  }
}
