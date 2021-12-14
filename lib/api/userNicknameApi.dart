import 'package:hg_router/models/commonDioResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import '../main.dart';
import 'api.dart';

class UserNicknameApi {
  UserNicknameApi() {}

  Future<CommonDioResponseModel> getUserNickname() async {
    String url = Api.baseUrl + Api.userNickname;
    logger.d(url);
    MyDioResponse response = await RestfulUtils.getInstance().get(true, url);
    logger.d(response.statusCode);
    if (response.statusCode == 200) {
      ///请求成功返回200
      return CommonDioResponseModel.fromJson(response.response.data);
    } else {
      ///不成功返回错误码
      return CommonDioResponseModel(code: response.statusCode);
    }
  }

  Future<CommonDioResponseModel> updateUserNickname(String nickname) async {
    String url = Api.baseUrl + Api.userNickname;
    MyDioResponse myResponse = await RestfulUtils.getInstance()
        .put(true, url, data: {"nickname": nickname});
    if (myResponse.statusCode == 200) {
      ///请求成功返回200
      return CommonDioResponseModel.fromJson(myResponse.response.data);
    } else {
      ///不成功返回错误码
      return CommonDioResponseModel(code: myResponse.statusCode);
    }
  }
}
