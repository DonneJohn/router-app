import 'package:hg_router/main.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'api.dart';
import 'package:hg_router/models/loginAndLogout/identifyingCodeModel.dart';
import 'package:hg_router/models/loginAndLogout/registerResponseModel.dart';

///
///Created by slkk on 2019/9/4
///
class EmailRegisterApi {
  EmailRegisterApi() {}

  Future<IdentifyingCodeModel> getIdentifyingCode() async {
    String url = Api.baseUrl + Api.identifyingCodeUrl;
    print(url);
    MyDioResponse response = await RestfulUtils.getInstance().get(false,url);
    logger.d(response.statusCode);
    if (response.statusCode == 200) {
      ///请求成功返回200
      return IdentifyingCodeModel.formJson(response.response.data);
    } else {
      ///不成功返回错误码
      return IdentifyingCodeModel(code: response.statusCode);
    }
  }

  Future<RegisterResponseModel> doEmailRegister(
      String email, String pwd, String identifyCode) async {
    String url = Api.baseUrl + Api.registerUrl;
    MyDioResponse myResponse = await RestfulUtils.getInstance()
        .post(false,url, data:{"email": email, "password": pwd, "code": identifyCode});
    if (myResponse.statusCode == 200) {
      ///请求成功返回200
      return RegisterResponseModel.formJson(myResponse.response.data);
    } else {
      ///不成功返回错误码
      return RegisterResponseModel(code: myResponse.statusCode);
    }
  }
}
