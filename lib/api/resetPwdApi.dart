import 'package:dio/dio.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'api.dart';
import 'package:hg_router/models/loginAndLogout/registerResponseModel.dart';

///
///Created by slkk on 2019/9/29/0029 18:21
///
class ResetPwdApi {
  ResetPwdApi() {}

  Future<RegisterResponseModel> resetPwd(
      String email, String identifyCode) async {
    String url = Api.baseUrl + Api.userResetUrl;
    MyDioResponse myResponse = await RestfulUtils.getInstance()
        .post(false,url, data:{"email": email, "code": identifyCode});
    print(myResponse.response.data);
    return RegisterResponseModel.formJson(myResponse.response.data);
  }
}
