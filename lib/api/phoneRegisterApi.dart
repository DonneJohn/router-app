import 'package:hg_router/models/loginAndLogout/registerResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import 'api.dart';

///
///Created by slkk on 2019/11/7/0007 13:50
///
class PhoneRegisterApi {
  PhoneRegisterApi() {}

  Future<RegisterResponseModel> doPhoneRegister(
      String phone, String pwd, String code) async {
    String url = Api.baseUrl + Api.phoneRegisterUrl;
    MyDioResponse myResponse = await RestfulUtils.getInstance()
        .post(false,url, data:{"phone": phone, "password": pwd, "code": code});
    if (myResponse.statusCode == 200) {
      ///请求成功返回200
      return RegisterResponseModel.formJson(myResponse.response.data);
    } else {
      ///不成功返回错误码
      return RegisterResponseModel(code: myResponse.statusCode);
    }
  }
}
