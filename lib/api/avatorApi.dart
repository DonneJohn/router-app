import 'package:dio/dio.dart';
import 'package:hg_router/models/commonDioResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import '../main.dart';
import 'api.dart';

///
///Created by slkk on 2019/11/9/0009 14:53
///
class AvatorApi {
  AvatorApi() {}

  Future<CommonDioResponseModel> getAvator() async {
    String url = Api.baseUrl + Api.avatorApiUrl;
    print(url);
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

  Future<CommonDioResponseModel> updateAvator(FormData data) async {
    String url = Api.baseUrl + Api.avatorApiUrl;
    MyDioResponse myResponse =
        await RestfulUtils.getInstance().post(true, url, data: data);
    if (myResponse.statusCode == 200) {
      ///请求成功返回200
      return CommonDioResponseModel.fromJson(myResponse.response.data);
    } else {
      ///不成功返回错误码
      return CommonDioResponseModel(code: myResponse.statusCode);
    }
  }
}
