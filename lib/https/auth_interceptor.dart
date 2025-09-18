// ignore_for_file: unnecessary_overrides

/*
 * @作者: 顾明次
 * @Date: 2025-09-18 14:02:43
 * @Email: gu271901088@gmail.com
 * @描述: 认证拦截器
 */

import 'package:dio/dio.dart';

 class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  } 


}
