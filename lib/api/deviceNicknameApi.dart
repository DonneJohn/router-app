import 'package:hg_router/common/common.dart';
import 'package:hg_router/models/commonDioResponseModel.dart';
import 'package:hg_router/utils/SpUtil.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import '../main.dart';
import 'api.dart';

class DeviceNicknameApi {
  DeviceNicknameApi() {}

  Future<CommonDioResponseModel> getDeviceNickname(String mac) async {
    String url = Api.baseUrl + Api.deviceNickname;
    logger.d(url);
    MyDioResponse response = await RestfulUtils.getInstance()
        .get(true,url, queryParameters: {"mac": mac});
    logger.d(response.statusCode);
    if (response.statusCode == 200) {
      ///请求成功返回200
      return CommonDioResponseModel.fromJson(response.response.data);
    } else {
      ///不成功返回错误码
      return CommonDioResponseModel(code: response.statusCode);
    }
  }

  Future<CommonDioResponseModel> updateDeviceNickname(String nickname) async {
    String url = Api.baseUrl + Api.deviceNickname;
    MyDioResponse myResponse = await RestfulUtils.getInstance().put(true,url,
        data: {
          "mac": SpUtil.getString(Constant.routerMac),
          "nickname": nickname
        });
    if (myResponse.statusCode == 200) {
      ///请求成功返回200
      return CommonDioResponseModel.fromJson(myResponse.response.data);
    } else {
      ///不成功返回错误码
      return CommonDioResponseModel(code: myResponse.statusCode);
    }
  }
}
