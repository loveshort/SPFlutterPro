/*
 * @作者: 顾明次
 * @Date: 2025-09-18 14:01:24
 * @Email: gu271901088@gmail.com
 * @描述: 网络请求引擎
 */


import 'package:dio/dio.dart';
import 'auth_Interceptor.dart';
import 'base_api.dart';

/// 网络请求引擎
class HttpsEngine {
  /// 单例
  static final HttpsEngine _instance = HttpsEngine._internal();
  factory HttpsEngine() => _instance;
  HttpsEngine._internal();

  static Dio dio = Dio();

  /// 初始化
  static void init() {
    dio.options.baseUrl = BaseApi.instance.baseUrl ?? '';
    dio.interceptors.add(LogInterceptor()); //日志拦截器
    dio.interceptors.add(AuthInterceptor()); //认证拦截器
  }


 

  

}