import 'package:hg_router/models/toolbox/getUpgradeResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import '../main.dart';
import 'api.dart';

///
///Created by slkk on 2019/11/18/0018 15:33
///
class GetUpgradeApi {
  GetUpgradeApi() {}

  Future<GetUpgradeResponseModel> getUpgrade(String mac) async {
    String url = Api.baseUrl + Api.getUpgrade;
    print(url);
    MyDioResponse response = await RestfulUtils.getInstance()
        .get(true, url, queryParameters: {"mac": mac});
    logger.d(response.statusCode);
    if (response.statusCode == 200) {
      ///请求成功返回200
      return GetUpgradeResponseModel.fromJson(response.response.data);
    } else {
      ///不成功返回错误码
      return GetUpgradeResponseModel(code: response.statusCode);
    }
  }
}
