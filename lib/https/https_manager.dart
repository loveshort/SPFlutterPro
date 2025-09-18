/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: HTTP请求管理器 - 基于HttpsEngine和HttpsResult的高级封装
 */

import 'package:dio/dio.dart';
import 'https_engine.dart';
import 'https_result.dart';
import '../log_utils/log_utils.dart';

/// HTTP请求管理器
/// 提供更高级的API管理功能，包括统一响应处理、错误处理、重试机制等
class HttpsManager {
  /// 单例
  static final HttpsManager _instance = HttpsManager._internal();
  factory HttpsManager() => _instance;
  HttpsManager._internal();

  /// 最大重试次数
  static const int _maxRetryCount = 3;
  
  /// 重试延迟时间
  static const Duration _retryDelay = Duration(seconds: 1);

  // ==================== 基础请求方法封装 ====================

  /// GET请求
  /// [path] 请求路径
  /// [queryParameters] 查询参数
  /// [options] 请求选项
  /// [retryCount] 重试次数
  /// [enableCache] 是否启用缓存
  /// [cacheExpiry] 缓存过期时间
  static Future<HttpsResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 0,
    bool enableCache = false,
    Duration? cacheExpiry,
  }) async {
    try {
      LogUtils.d('HttpsManager GET请求: $path');
      
      Response<T> response;
      if (enableCache) {
        response = await HttpsEngine.getWithCache<T>(
          path,
          queryParameters: queryParameters,
          cacheExpiry: cacheExpiry,
        );
      } else {
        response = await HttpsEngine.get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
        );
      }

      return _handleResponse<T>(response, path, queryParameters);
    } on DioException catch (e) {
      return _handleDioException<T>(e, path, queryParameters, retryCount, () {
        return get<T>(
          path,
          queryParameters: queryParameters,
          options: options,
          retryCount: retryCount + 1,
          enableCache: enableCache,
          cacheExpiry: cacheExpiry,
        );
      });
    } catch (e) {
      LogUtils.e('HttpsManager GET请求异常: $e');
      return HttpsResult.error(
        message: '请求异常: $e',
        path: path,
        params: queryParameters,
      );
    }
  }

  /// POST请求
  /// [path] 请求路径
  /// [data] 请求数据
  /// [queryParameters] 查询参数
  /// [options] 请求选项
  /// [retryCount] 重试次数
  /// [enableCache] 是否启用缓存
  /// [cacheExpiry] 缓存过期时间
  static Future<HttpsResult<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 0,
    bool enableCache = false,
    Duration? cacheExpiry,
  }) async {
    try {
      LogUtils.d('HttpsManager POST请求: $path');
      
      Response<T> response;
      if (enableCache) {
        response = await HttpsEngine.postWithCache<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          cacheExpiry: cacheExpiry,
        );
      } else {
        response = await HttpsEngine.post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      }

      return _handleResponse<T>(response, path, queryParameters);
    } on DioException catch (e) {
      return _handleDioException<T>(e, path, queryParameters, retryCount, () {
        return post<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          retryCount: retryCount + 1,
          enableCache: enableCache,
          cacheExpiry: cacheExpiry,
        );
      });
    } catch (e) {
      LogUtils.e('HttpsManager POST请求异常: $e');
      return HttpsResult.error(
        message: '请求异常: $e',
        path: path,
        params: queryParameters,
      );
    }
  }

  /// PUT请求
  /// [path] 请求路径
  /// [data] 请求数据
  /// [queryParameters] 查询参数
  /// [options] 请求选项
  /// [retryCount] 重试次数
  static Future<HttpsResult<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 0,
  }) async {
    try {
      LogUtils.d('HttpsManager PUT请求: $path');
      
      final response = await HttpsEngine.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse<T>(response, path, queryParameters);
    } on DioException catch (e) {
      return _handleDioException<T>(e, path, queryParameters, retryCount, () {
        return put<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          retryCount: retryCount + 1,
        );
      });
    } catch (e) {
      LogUtils.e('HttpsManager PUT请求异常: $e');
      return HttpsResult.error(
        message: '请求异常: $e',
        path: path,
        params: queryParameters,
      );
    }
  }

  /// DELETE请求
  /// [path] 请求路径
  /// [data] 请求数据
  /// [queryParameters] 查询参数
  /// [options] 请求选项
  /// [retryCount] 重试次数
  static Future<HttpsResult<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    int retryCount = 0,
  }) async {
    try {
      LogUtils.d('HttpsManager DELETE请求: $path');
      
      final response = await HttpsEngine.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return _handleResponse<T>(response, path, queryParameters);
    } on DioException catch (e) {
      return _handleDioException<T>(e, path, queryParameters, retryCount, () {
        return delete<T>(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          retryCount: retryCount + 1,
        );
      });
    } catch (e) {
      LogUtils.e('HttpsManager DELETE请求异常: $e');
      return HttpsResult.error(
        message: '请求异常: $e',
        path: path,
        params: queryParameters,
      );
    }
  }

  // ==================== 文件操作封装 ====================

  /// 文件上传
  /// [path] 上传路径
  /// [filePath] 本地文件路径
  /// [fileName] 文件名
  /// [data] 额外数据
  /// [onSendProgress] 上传进度回调
  /// [retryCount] 重试次数
  static Future<HttpsResult<T>> uploadFile<T>(
    String path,
    String filePath, {
    String? fileName,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    int retryCount = 0,
  }) async {
    try {
      LogUtils.d('HttpsManager 文件上传: $filePath');
      
      final response = await HttpsEngine.uploadFile<T>(
        path,
        filePath,
        fileName: fileName,
        data: data,
        onSendProgress: onSendProgress,
      );

      return _handleResponse<T>(response, path, data);
    } on DioException catch (e) {
      return _handleDioException<T>(e, path, data, retryCount, () {
        return uploadFile<T>(
          path,
          filePath,
          fileName: fileName,
          data: data,
          onSendProgress: onSendProgress,
          retryCount: retryCount + 1,
        );
      });
    } catch (e) {
      LogUtils.e('HttpsManager 文件上传异常: $e');
      return HttpsResult.error(
        message: '文件上传异常: $e',
        path: path,
        params: data,
      );
    }
  }

  /// 文件下载
  /// [url] 下载URL
  /// [savePath] 保存路径
  /// [fileName] 文件名
  /// [onReceiveProgress] 下载进度回调
  /// [retryCount] 重试次数
  static Future<HttpsResult<String>> downloadFile(
    String url, {
    String? savePath,
    String? fileName,
    ProgressCallback? onReceiveProgress,
    int retryCount = 0,
  }) async {
    try {
      LogUtils.d('HttpsManager 文件下载: $url');
      
      final savePathResult = await HttpsEngine.downloadFile(
        url,
        savePath: savePath,
        fileName: fileName,
        onReceiveProgress: onReceiveProgress,
      );

      return HttpsResult.success(
        data: savePathResult,
        message: '文件下载成功',
        path: url,
      );
    } on DioException catch (e) {
      return _handleDioException<String>(e, url, null, retryCount, () {
        return downloadFile(
          url,
          savePath: savePath,
          fileName: fileName,
          onReceiveProgress: onReceiveProgress,
          retryCount: retryCount + 1,
        );
      });
    } catch (e) {
      LogUtils.e('HttpsManager 文件下载异常: $e');
      return HttpsResult.error(
        message: '文件下载异常: $e',
        path: url,
      );
    }
  }

  // ==================== 批量请求 ====================

  /// 批量GET请求
  /// [requests] 请求列表
  /// [concurrent] 是否并发执行
  static Future<List<HttpsResult<T>>> batchGet<T>(
    List<BatchRequest> requests, {
    bool concurrent = true,
  }) async {
    try {
      LogUtils.d('HttpsManager 批量GET请求: ${requests.length}个');
      
      if (concurrent) {
        // 并发执行
        final futures = requests.map((request) => get<T>(
          request.path,
          queryParameters: request.queryParameters,
          options: request.options,
          enableCache: request.enableCache,
          cacheExpiry: request.cacheExpiry,
        ));
        
        return await Future.wait(futures);
      } else {
        // 顺序执行
        final results = <HttpsResult<T>>[];
        for (final request in requests) {
          final result = await get<T>(
            request.path,
            queryParameters: request.queryParameters,
            options: request.options,
            enableCache: request.enableCache,
            cacheExpiry: request.cacheExpiry,
          );
          results.add(result);
        }
        return results;
      }
    } catch (e) {
      LogUtils.e('HttpsManager 批量GET请求异常: $e');
      return requests.map<HttpsResult<T>>((request) => HttpsResult.error(
        message: '批量请求异常: $e',
        path: request.path,
        params: request.queryParameters,
      )).toList();
    }
  }

  /// 批量POST请求
  /// [requests] 请求列表
  /// [concurrent] 是否并发执行
  static Future<List<HttpsResult<T>>> batchPost<T>(
    List<BatchPostRequest> requests, {
    bool concurrent = true,
  }) async {
    try {
      LogUtils.d('HttpsManager 批量POST请求: ${requests.length}个');
      
      if (concurrent) {
        // 并发执行
        final futures = requests.map((request) => post<T>(
          request.path,
          data: request.data,
          queryParameters: request.queryParameters,
          options: request.options,
          enableCache: request.enableCache,
          cacheExpiry: request.cacheExpiry,
        ));
        
        return await Future.wait(futures);
      } else {
        // 顺序执行
        final results = <HttpsResult<T>>[];
        for (final request in requests) {
          final result = await post<T>(
            request.path,
            data: request.data,
            queryParameters: request.queryParameters,
            options: request.options,
            enableCache: request.enableCache,
            cacheExpiry: request.cacheExpiry,
          );
          results.add(result);
        }
        return results;
      }
    } catch (e) {
      LogUtils.e('HttpsManager 批量POST请求异常: $e');
      return requests.map<HttpsResult<T>>((request) => HttpsResult.error(
        message: '批量请求异常: $e',
        path: request.path,
        params: request.queryParameters,
      )).toList();
    }
  }

  // ==================== 分页请求 ====================

  /// 分页GET请求
  /// [path] 请求路径
  /// [page] 页码
  /// [pageSize] 每页数量
  /// [queryParameters] 其他查询参数
  /// [enableCache] 是否启用缓存
  /// [cacheExpiry] 缓存过期时间
  static Future<HttpsResult<PageResult<T>>> getPage<T>(
    String path, {
    int page = 1,
    int pageSize = 10,
    Map<String, dynamic>? queryParameters,
    bool enableCache = true,
    Duration? cacheExpiry,
    T Function(dynamic)? fromJsonT,
  }) async {
    try {
      final params = <String, dynamic>{
        'page': page,
        'pageSize': pageSize,
        ...?queryParameters,
      };

      final result = await get<Map<String, dynamic>>(
        path,
        queryParameters: params,
        enableCache: enableCache,
        cacheExpiry: cacheExpiry,
      );

      if (result.isSuccess && result.data != null) {
        final pageResult = PageResult<T>.fromJson(
          result.data!,
          fromJsonT ?? (item) => item as T,
        );
        
        return HttpsResult.success(
          data: pageResult,
          message: '分页数据获取成功',
          path: path,
          params: params,
        );
      } else {
        return HttpsResult.error(
          message: result.message ?? '分页数据获取失败',
          path: path,
          params: params,
        );
      }
    } catch (e) {
      LogUtils.e('HttpsManager 分页GET请求异常: $e');
      return HttpsResult.error(
        message: '分页请求异常: $e',
        path: path,
      );
    }
  }

  // ==================== 工具方法 ====================

  /// 处理响应
  static HttpsResult<T> _handleResponse<T>(
    Response<T> response,
    String path,
    Map<String, dynamic>? params,
  ) {
    if (response.statusCode == 200) {
      return HttpsResult.success(
        data: response.data as T,
        message: '请求成功',
        path: path,
        params: params,
      );
    } else {
      return HttpsResult.error(
        message: '请求失败: ${response.statusCode}',
        code: response.statusCode,
        path: path,
        params: params,
      );
    }
  }

  /// 处理Dio异常
  static Future<HttpsResult<T>> _handleDioException<T>(
    DioException e,
    String path,
    Map<String, dynamic>? params,
    int retryCount,
    Future<HttpsResult<T>> Function() retryFunction,
  ) async {
    LogUtils.e('HttpsManager Dio异常: ${e.message}');
    
    // 判断是否需要重试
    if (retryCount < _maxRetryCount && _shouldRetry(e)) {
      LogUtils.d('HttpsManager 重试请求: ${retryCount + 1}/$_maxRetryCount');
      await Future.delayed(_retryDelay);
      return await retryFunction();
    }

    // 根据异常类型返回不同的错误响应
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return HttpsResult.timeout(
          message: '请求超时: ${e.message}',
          path: path,
          params: params,
        );
      case DioExceptionType.connectionError:
        return HttpsResult.networkError(
          message: '网络连接失败: ${e.message}',
          path: path,
          params: params,
        );
      case DioExceptionType.badResponse:
        return HttpsResult.error(
          message: '服务器响应错误: ${e.response?.statusCode}',
          code: e.response?.statusCode,
          path: path,
          params: params,
        );
      default:
        return HttpsResult.error(
          message: '请求失败: ${e.message}',
          code: e.response?.statusCode,
          path: path,
          params: params,
        );
    }
  }

  /// 判断是否应该重试
  static bool _shouldRetry(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        // 5xx 服务器错误可以重试
        final statusCode = e.response?.statusCode;
        return statusCode != null && statusCode >= 500;
      default:
        return false;
    }
  }

  /// 清除所有缓存
  static Future<void> clearCache() async {
    await HttpsEngine.clearAllCache();
    LogUtils.d('HttpsManager 缓存已清除');
  }

  /// 清除过期缓存
  static Future<void> clearExpiredCache() async {
    await HttpsEngine.clearExpiredCache();
    LogUtils.d('HttpsManager 过期缓存已清除');
  }
}

// ==================== 批量请求数据模型 ====================

/// 批量GET请求数据模型
class BatchRequest {
  final String path;
  final Map<String, dynamic>? queryParameters;
  final Options? options;
  final bool enableCache;
  final Duration? cacheExpiry;

  const BatchRequest({
    required this.path,
    this.queryParameters,
    this.options,
    this.enableCache = false,
    this.cacheExpiry,
  });
}

/// 批量POST请求数据模型
class BatchPostRequest {
  final String path;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;
  final Options? options;
  final bool enableCache;
  final Duration? cacheExpiry;

  const BatchPostRequest({
    required this.path,
    this.data,
    this.queryParameters,
    this.options,
    this.enableCache = false,
    this.cacheExpiry,
  });
}
