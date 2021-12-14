import 'package:dio/dio.dart';
import 'package:hg_router/models/commonDioResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';
import 'api.dart';

///
///Created by slkk on 2019/9/18/0018 15:22
///
class UserFeedbackApi {
  UserFeedbackApi() {}

  Future<CommonDioResponseModel> doFeedback(FormData data) async {
    String url = Api.baseUrl + Api.userFeedback;
    MyDioResponse myResponse = await RestfulUtils.getInstance().post(true,url,data: data);
//    print(response.data);
    return CommonDioResponseModel.fromJson(myResponse.response.data);
  }
}
