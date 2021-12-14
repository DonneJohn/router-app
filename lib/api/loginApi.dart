import 'package:hg_router/models/loginAndLogout/loginResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'api.dart';

///
///Created by slkk on 2019/9/5
///
class LoginApi {
  LoginApi() {}

  Future<LoginResponseModel> doEmailLogin(String email, String pwd) async {
    String url = Api.baseUrl + Api.emailLoginUrl;
    MyDioResponse myResponse = await RestfulUtils.getInstance()
        .post(false, url, data: {"email": email, "password": pwd});
    print(myResponse.response);
    if (myResponse.statusCode == 200) {
      ///请求成功返回200
      return LoginResponseModel.formJson(myResponse.response.data);
    } else {
      ///不成功返回错误码
      return LoginResponseModel(code: myResponse.statusCode);
    }
  }

  Future<LoginResponseModel> doPhoneLogin(String phone, String pwd) async {
    String url = Api.baseUrl + Api.phoneLoginUrl;
    MyDioResponse myResponse = await RestfulUtils.getInstance()
        .post(false, url, data: {"phone": phone, "password": pwd});
    print(myResponse.response);
    if (myResponse.statusCode == 200) {
      ///请求成功返回200
      return LoginResponseModel.formJson(myResponse.response.data);
    } else {
      ///不成功返回错误码
      return LoginResponseModel(code: myResponse.statusCode);
    }
  }
}
