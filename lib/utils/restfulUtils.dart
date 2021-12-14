///
///Created by slkk on 2019/9/4/0004 13:57
///
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:hg_router/common/common.dart';
import 'package:hg_router/main.dart';
import 'package:synchronized/synchronized.dart' as sync;
import 'SpUtil.dart';

class RestfulUtils {
  static RestfulUtils _singleton;

  static Dio _dio;
  static sync.Lock _lock = sync.Lock();

  static RestfulUtils getInstance() {
    if (_singleton == null) {
      _lock.synchronized(() {
        if (_singleton == null) {
          _singleton = RestfulUtils();
        }
      });
    }
    return _singleton;
  }

  RestfulUtils() {
    logger.d("RestfulUtils init");
    BaseOptions options = new BaseOptions(
      sendTimeout: 20000,
      receiveTimeout: 20000,
      connectTimeout: 20000,
    );
    _dio = Dio(options);

    ///忽略https 证书
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    _setupLoggingInterceptor();
  }

  Future<MyDioResponse> get(bool takeOptions, String url,
      {Map<String, dynamic> queryParameters}) async {
    var token;
    Response response;
    try {
      if (takeOptions) {
        token = SpUtil.getString(Constant.keyAppToken);
        response = await _dio.get(url,
            queryParameters: queryParameters,
            options: takeOptions
                ? Options(headers: {'Authorization': 'Bearer ' + token ?? ''})
                : null);
      } else {
        response = await _dio.get(
          url,
          queryParameters: queryParameters,
        );
      }
      return MyDioResponse(response: response, statusCode: 200);
    } on DioError catch (error) {
      logger.e(_handleError(error));
      if (error.response != null) {
        return MyDioResponse(statusCode: error?.response?.statusCode);
      }
      return MyDioResponse(statusCode: 900);
    }
  }

  Future<MyDioResponse> post(bool takeOptions, String url,
      {dynamic data}) async {
    var token;
    Response response;
    try {
      if (takeOptions) {
        token = SpUtil.getString(Constant.keyAppToken);
        response = await _dio.post(url,
            data: data,
            options: takeOptions
                ? Options(headers: {'Authorization': 'Bearer ' + token ?? ''})
                : null);
      } else {
        response = await _dio.post(
          url,
          data: data,
        );
      }
      return MyDioResponse(response: response, statusCode: 200);
    } on DioError catch (error) {
      if (error.response != null) {
        logger.e(_handleError(error));
        return MyDioResponse(statusCode: error?.response?.statusCode);
      }
      return MyDioResponse(statusCode: 900);
    }
  }

  Future<MyDioResponse> put(bool takeOptions, String url,
      {dynamic data}) async {
    var token;
    Response response;
    try {
      if (takeOptions) {
        token = SpUtil.getString(Constant.keyAppToken);
        response = await _dio.put(url,
            data: data,
            options: takeOptions
                ? Options(headers: {'Authorization': 'Bearer ' + token ?? ''})
                : null);
      } else {
        response = await _dio.put(
          url,
          data: data,
        );
      }
      return MyDioResponse(response: response, statusCode: 200);
    } on DioError catch (error) {
      if (error.response != null) {
        logger.e(_handleError(error));
        return MyDioResponse(statusCode: error?.response?.statusCode);
      }
      return MyDioResponse(statusCode: 900);
    }
  }

  Future<MyDioResponse> download(bool takeOptions, String url,
      {String saveUrl}) async {
    var token;
    Response response;
    try {
      if (takeOptions) {
        token = SpUtil.getString(Constant.keyAppToken);

        response = await _dio.download(url, saveUrl,
            options: takeOptions
                ? Options(headers: {'Authorization': 'Bearer ' + token ?? ''})
                : null);
      } else {
        response = await _dio.download(
          url,
          saveUrl,
        );
      }
      return MyDioResponse(response: response, statusCode: 200);
    } on DioError catch (error) {
      if (error.response != null) {
        logger.e(_handleError(error));
        return MyDioResponse(statusCode: error?.response?.statusCode);
      }
      return MyDioResponse(statusCode: 900);
    }
  }

  void _setupLoggingInterceptor() {
    int maxCharactersPerLine = 200;

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          print("--> ${options.method} ${options.path}");
          print("Content type: ${options.contentType}");
          print("Content Body: ${options.data}");
          print("<-- END HTTP");
          return options;
        },
        onResponse: (Response response) {
          print(
              "<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
          String responseAsString = response.data.toString();
          if (responseAsString.length > maxCharactersPerLine) {
            int iterations =
                (responseAsString.length / maxCharactersPerLine).floor();
            for (int i = 0; i <= iterations; i++) {
              int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
              if (endingIndex > responseAsString.length) {
                endingIndex = responseAsString.length;
              }
              print(responseAsString.substring(
                  i * maxCharactersPerLine, endingIndex));
            }
          } else {
            print(response.data);
          }
          print("<-- END HTTP");
        },
      ),
    );
    _dio.interceptors.add(LogInterceptor());
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    logger.d(error.response.toString());
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "send timeout with API server";
          break;
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }
}

class MyDioResponse {
  final Response response;
  final int statusCode;

  MyDioResponse({this.response, this.statusCode});
}
