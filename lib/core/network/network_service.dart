import 'package:coolmall_flutter/core/network/http_constants.dart';
import 'package:dio/dio.dart';

/// 网络服务类
class NetworkService {
  final _dio = Dio();

  NetworkService() {
    _dio.options
      ..baseUrl = GlobalConstans.BASE_URL
      ..connectTimeout = Duration(seconds: GlobalConstans.TIME_OUT)
      ..receiveTimeout = Duration(seconds: GlobalConstans.TIME_OUT);
    // 注意：在Web平台上，sendTimeout不能用于没有请求体的请求
    // 所以只设置connectTimeout和receiveTimeout，避免Web平台警告
    _addInterceptors();
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // 从本地存储获取token
          // if(tokenManager.getToken().isNotEmpty){
          //   options.headers={
          //     "Authorization":"Bearer ${tokenManager.getToken()}"
          //   };
          // }
          // 在请求被发送之前做一些事情
          return handler.next(options); // 继续处理请求
        },
        onResponse: (response, handler) {
          // 在响应被返回之前做一些事情
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            return handler.next(response); // 继续处理响应
          }
          return handler.reject(
            DioException(requestOptions: response.requestOptions),
          );
        },
        onError: (error, handler) {
          // 在 Dio 发生错误时做一些事情
          return handler.reject(error); // 继续处理错误
        },
      ),
    );
  }

  /// 通用请求方法
  Future<dynamic> _request(
    String method,
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    try {
      Response response = await _dio.request(
        url,
        options: Options(method: method),
        queryParameters: queryParameters,
        data: data,
      );
      final responseData = response.data as Map<String, dynamic>;
      // print(responseData);
      if (responseData["code"] == GlobalConstans.SUCCESS_CODE) {
        return responseData["data"];
      }
      throw DioException(
        requestOptions: response.requestOptions,
        message: responseData["message"] ?? "请求失败",
        response: response,
        type: DioExceptionType.badResponse,
      );
    } on DioException catch (e) {
      // 重新抛出包含更详细信息的异常
      throw DioException(
        requestOptions: e.requestOptions,
        message: e.message,
        response: e.response,
        type: e.type,
        error: e.error,
      );
    }
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _request('GET', url, queryParameters: queryParameters);
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
    return _request('POST', url, data: data);
  }
}

final networkService = NetworkService(); // 单例模式
