import 'package:hg_router/main.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'api.dart';

///
///Created by slkk on 2019/11/7/0007 13:07
///
class GetPhoneCodeApi {
  GetPhoneCodeApi() {}

  Future<MyDioResponse> getPhoneCode(String phoneNumber) async {
    String url = Api.baseUrl + Api.getPhoneCode;
    logger.d(url);
    MyDioResponse response = await RestfulUtils.getInstance()
        .get(false,url, queryParameters: {"phone": phoneNumber});
    logger.d(response.statusCode);
    return response;
  }
}
