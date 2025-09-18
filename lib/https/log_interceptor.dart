/*
 * @作者: 顾明次
 * @Date: 2025-09-18 14:07:39
 * @Email: gu271901088@gmail.com
 * @描述: 
 */
/*
 * @作者: 顾明次
 * @Date: 2025-09-18 14:07:39
 * @Email: gu271901088@gmail.com
 * @描述: 日志拦截器 - 使用LogUtils进行统一日志管理
 */
 
import 'package:dio/dio.dart';
import '../log_utils/log_utils.dart';

class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 使用LogUtils记录网络请求
    LogUtils.network(
      options.method,
      options.uri.toString(),
      headers: options.headers,
      data: options.data,
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 使用LogUtils记录API响应
    LogUtils.apiResponse(
      response.requestOptions.path,
      statusCode: response.statusCode ?? 0,
      data: response.data,
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 使用LogUtils记录错误响应
    LogUtils.apiResponse(
      err.requestOptions.path,
      statusCode: err.response?.statusCode ?? 0,
      error: err.message,
    );
    super.onError(err, handler);
  }
}