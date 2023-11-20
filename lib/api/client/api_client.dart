import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:question_app/core/api_endpoints.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class ApiClient extends GetxService {
  late Dio _dio;

  //this is for header
  static header() => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<ApiClient> init() async {
    _dio = Dio(BaseOptions(
      baseUrl: Api.API_BASE_URL,
      headers: header(),
      connectTimeout: const Duration(seconds: 5000),
      receiveTimeout: const Duration(seconds: 6000),
    ));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response);
    }, onError: (err, handler) {
      return handler.next(err);
    }));
  }

  Future<dynamic> request(String url, Method method,
      {Map<String, dynamic>? params, Map<String, dynamic>? body}) async {
    Response response;

    try {
      if (method == Method.POST) {
        response = await _dio.post(url, queryParameters: params, data: body);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
        );
      }
      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Internal Server Error");
      } else {
        throw Exception("Something Went Wrong");
      }
    } on SocketException catch (e) {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception("Connection  Timeout Exception");
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception("$e");
    }
  }
}