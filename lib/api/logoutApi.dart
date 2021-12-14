
import 'package:hg_router/models/loginAndLogout/logoutResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'api.dart';

///
///Created by slkk on 2019/9/4/0004 13:47
///
class LogoutApi {
  LogoutApi() {}

  Future<LogoutResponseModel> doLogout(String email, String pwd) async {
    String url = Api.baseUrl + Api.logoutUrl;
    MyDioResponse myResponse= await RestfulUtils.getInstance().post(true,url, data:{"email": email});
    print(myResponse.response.data);
    return LogoutResponseModel.fromJson(myResponse.response.data);
  }
}
