import 'package:dio/dio.dart';
import 'package:hg_router/main.dart';
import 'package:hg_router/models/commonDioResponseModel.dart';
import 'package:hg_router/models/locationResponseModel.dart';
import 'package:hg_router/utils/restfulUtils.dart';

import 'api.dart';

///
///Created by slkk on 2019/9/18/0018 16:42
///
class RegionApi {
  RegionApi() {}

  Future<LocationResponseModel> getRegion(String mac) async {
    String url = Api.baseUrl + Api.getLocation;
    MyDioResponse response = await RestfulUtils.getInstance()
        .get(true,url, queryParameters: {"mac": mac});
//    print(response.data);
    if (response.statusCode == 200) {
      return LocationResponseModel.formJson(response.response.data);
    } else {
      return null;
    }
  }

  Future<CommonDioResponseModel> setRegion(
      String mac, String region) async {
    String url = Api.baseUrl + Api.getLocation;
    MyDioResponse response = await RestfulUtils.getInstance()
        .put(true,url, data: {"mac": mac, "region": region});
//    print(response.data);
    logger.i("LocationApi:" + mac);
    if (response.statusCode == 200) {
      return CommonDioResponseModel.fromJson(response.response.data);
    } else {
      return CommonDioResponseModel(code: response.statusCode);
    }
  }
}
