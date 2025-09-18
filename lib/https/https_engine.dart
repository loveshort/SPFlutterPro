/*
 * @作者: 顾明次
 * @Date: 2025-09-18 14:01:24
 * @Email: gu271901088@gmail.com
 * @描述: 网络请求引擎 - 提供完整的HTTP请求封装，包括缓存功能
 */

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'auth_interceptor.dart';
import 'base_api.dart';
import '../log_utils/log_utils.dart';
import '../store_data/shared_preferences_manager.dart';

/// 网络请求引擎
/// 提供完整的HTTP请求封装，包括缓存、文件上传下载等功能
class HttpsEngine {
  /// 单例
  static final HttpsEngine _instance = HttpsEngine._internal();
  factory HttpsEngine() => _instance;
  HttpsEngine._internal();

  static Dio dio = Dio();
  
  /// 缓存目录
  static Directory? _cacheDir;
  
  /// 缓存过期时间（默认5分钟）
  static const Duration _defaultCacheExpiry = Duration(minutes: 5);

  /// 初始化
  static Future<void> init() async {
    // 设置基础配置
    dio.options.baseUrl = BaseApi.instance.baseUrl ?? '';
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.sendTimeout = const Duration(seconds: 30);
    
    // 添加拦截器
    dio.interceptors.add(LogInterceptor()); // 日志拦截器
    dio.interceptors.add(AuthInterceptor()); // 认证拦截器
    
    // 初始化缓存目录
    await _initCacheDir();
    
    LogUtils.i('HttpsEngine 初始化完成');
  }

  /// 初始化缓存目录
  static Future<void> _initCacheDir() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      _cacheDir = Directory('${appDir.path}/http_cache');
      if (!await _cacheDir!.exists()) {
        await _cacheDir!.create(recursive: true);
      }
      LogUtils.d('缓存目录初始化完成: ${_cacheDir!.path}');
    } catch (e) {
      LogUtils.e('缓存目录初始化失败: $e');
    }
  }

  // ==================== 基础请求方法（不带缓存） ====================

  /// GET请求
  /// [path] 请求路径
  /// [queryParameters] 查询参数
  /// [options] 请求选项
  static Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      LogUtils.d('发起GET请求: $path');
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      LogUtils.d('GET请求成功: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      LogUtils.e('GET请求失败: ${e.message}');
      rethrow;
    }
  }

  /// POST请求
  /// [path] 请求路径
  /// [data] 请求数据
  /// [queryParameters] 查询参数
  /// [options] 请求选项
  static Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      LogUtils.d('发起POST请求: $path');
      final response = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      LogUtils.d('POST请求成功: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      LogUtils.e('POST请求失败: ${e.message}');
      rethrow;
    }
  }

  /// PUT请求
  /// [path] 请求路径
  /// [data] 请求数据
  /// [queryParameters] 查询参数
  /// [options] 请求选项
  static Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      LogUtils.d('发起PUT请求: $path');
      final response = await dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      LogUtils.d('PUT请求成功: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      LogUtils.e('PUT请求失败: ${e.message}');
      rethrow;
    }
  }

  /// DELETE请求
  /// [path] 请求路径
  /// [data] 请求数据
  /// [queryParameters] 查询参数
  /// [options] 请求选项
  static Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      LogUtils.d('发起DELETE请求: $path');
      final response = await dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      LogUtils.d('DELETE请求成功: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      LogUtils.e('DELETE请求失败: ${e.message}');
      rethrow;
    }
  }

  // ==================== 带缓存的请求方法 ====================

  /// 带缓存的GET请求
  /// [path] 请求路径
  /// [queryParameters] 查询参数
  /// [cacheKey] 缓存键（可选，默认使用path+参数生成）
  /// [cacheExpiry] 缓存过期时间（默认5分钟）
  /// [forceRefresh] 是否强制刷新缓存
  static Future<Response<T>> getWithCache<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? cacheKey,
    Duration? cacheExpiry,
    bool forceRefresh = false,
  }) async {
    try {
      // 生成缓存键
      final key = cacheKey ?? _generateCacheKey(path, queryParameters);
      final expiry = cacheExpiry ?? _defaultCacheExpiry;
      
      // 如果不是强制刷新，先尝试从缓存获取
      if (!forceRefresh) {
        final cachedData = await _getCachedData<T>(key);
        if (cachedData != null) {
          LogUtils.d('从缓存获取数据: $key');
          return cachedData;
        }
      }
      
      // 发起网络请求
      LogUtils.d('发起带缓存的GET请求: $path');
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
      );
      
      // 缓存响应数据
      if (response.statusCode == 200) {
        await _cacheData(key, response, expiry);
        LogUtils.d('数据已缓存: $key');
      }
      
      LogUtils.d('带缓存的GET请求成功: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      LogUtils.e('带缓存的GET请求失败: ${e.message}');
      
      // 网络请求失败时，尝试返回缓存数据
      final key = cacheKey ?? _generateCacheKey(path, queryParameters);
      final cachedData = await _getCachedData<T>(key);
      if (cachedData != null) {
        LogUtils.w('网络请求失败，返回缓存数据: $key');
        return cachedData;
      }
      
      rethrow;
    }
  }

  /// 带缓存的POST请求
  /// [path] 请求路径
  /// [data] 请求数据
  /// [queryParameters] 查询参数
  /// [cacheKey] 缓存键（可选，默认使用path+参数生成）
  /// [cacheExpiry] 缓存过期时间（默认5分钟）
  /// [forceRefresh] 是否强制刷新缓存
  static Future<Response<T>> postWithCache<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    String? cacheKey,
    Duration? cacheExpiry,
    bool forceRefresh = false,
  }) async {
    try {
      // 生成缓存键
      final key = cacheKey ?? _generateCacheKey(path, queryParameters, data);
      final expiry = cacheExpiry ?? _defaultCacheExpiry;
      
      // 如果不是强制刷新，先尝试从缓存获取
      if (!forceRefresh) {
        final cachedData = await _getCachedData<T>(key);
        if (cachedData != null) {
          LogUtils.d('从缓存获取数据: $key');
          return cachedData;
        }
      }
      
      // 发起网络请求
      LogUtils.d('发起带缓存的POST请求: $path');
      final response = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      
      // 缓存响应数据
      if (response.statusCode == 200) {
        await _cacheData(key, response, expiry);
        LogUtils.d('数据已缓存: $key');
      }
      
      LogUtils.d('带缓存的POST请求成功: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      LogUtils.e('带缓存的POST请求失败: ${e.message}');
      
      // 网络请求失败时，尝试返回缓存数据
      final key = cacheKey ?? _generateCacheKey(path, queryParameters, data);
      final cachedData = await _getCachedData<T>(key);
      if (cachedData != null) {
        LogUtils.w('网络请求失败，返回缓存数据: $key');
        return cachedData;
      }
      
      rethrow;
    }
  }

  // ==================== 文件上传下载 ====================

  /// 文件上传
  /// [path] 上传路径
  /// [filePath] 本地文件路径
  /// [fileName] 文件名（可选）
  /// [data] 额外数据
  /// [onSendProgress] 上传进度回调
  static Future<Response<T>> uploadFile<T>(
    String path,
    String filePath, {
    String? fileName,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      LogUtils.d('开始上传文件: $filePath');
      
      final file = File(filePath);
      if (!await file.exists()) {
        throw Exception('文件不存在: $filePath');
      }
      
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          filePath,
          filename: fileName ?? file.path.split('/').last,
        ),
        ...?data,
      });
      
      final response = await dio.post<T>(
        path,
        data: formData,
        onSendProgress: onSendProgress,
      );
      
      LogUtils.d('文件上传成功: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      LogUtils.e('文件上传失败: ${e.message}');
      rethrow;
    }
  }

  /// 文件下载
  /// [url] 下载URL
  /// [savePath] 保存路径（可选）
  /// [fileName] 文件名（可选）
  /// [onReceiveProgress] 下载进度回调
  static Future<String> downloadFile(
    String url, {
    String? savePath,
    String? fileName,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      LogUtils.d('开始下载文件: $url');
      
      // 确定保存路径
      String finalSavePath;
      if (savePath != null) {
        finalSavePath = savePath;
      } else {
        final appDir = await getApplicationDocumentsDirectory();
        final downloadDir = Directory('${appDir.path}/downloads');
        if (!await downloadDir.exists()) {
          await downloadDir.create(recursive: true);
        }
        finalSavePath = '${downloadDir.path}/${fileName ?? url.split('/').last}';
      }
      
      await dio.download(
        url,
        finalSavePath,
        onReceiveProgress: onReceiveProgress,
      );
      
      LogUtils.d('文件下载成功: $finalSavePath');
      return finalSavePath;
    } on DioException catch (e) {
      LogUtils.e('文件下载失败: ${e.message}');
      rethrow;
    }
  }

  // ==================== 缓存管理 ====================

  /// 生成缓存键
  static String _generateCacheKey(String path, Map<String, dynamic>? queryParameters, [dynamic data]) {
    final buffer = StringBuffer(path);
    
    if (queryParameters != null && queryParameters.isNotEmpty) {
      buffer.write('?');
      buffer.write(queryParameters.entries
          .map((e) => '${e.key}=${e.value}')
          .join('&'));
    }
    
    if (data != null) {
      buffer.write('|data:${data.toString()}');
    }
    
    return buffer.toString();
  }

  /// 获取缓存数据
  static Future<Response<T>?> _getCachedData<T>(String key) async {
    try {
      final cacheData = SharedPreferencesManager.instance.getString('cache_$key');
      if (cacheData == null) return null;
      
      final cacheInfo = jsonDecode(cacheData) as Map<String, dynamic>;
      final expiryTime = DateTime.parse(cacheInfo['expiryTime'] as String);
      
      // 检查是否过期
      if (DateTime.now().isAfter(expiryTime)) {
        await _removeCachedData(key);
        return null;
      }
      
      // 构造响应对象
      final responseData = cacheInfo['data'];
      final statusCode = cacheInfo['statusCode'] as int;
      final headersMap = Map<String, dynamic>.from(cacheInfo['headers'] as Map);
      final headers = Headers.fromMap(headersMap.map((key, value) => MapEntry(key, [value.toString()])));
      
      return Response<T>(
        data: responseData,
        statusCode: statusCode,
        headers: headers,
        requestOptions: RequestOptions(path: key),
      );
    } catch (e) {
      LogUtils.e('获取缓存数据失败: $e');
      return null;
    }
  }

  /// 缓存数据
  static Future<void> _cacheData<T>(String key, Response<T> response, Duration expiry) async {
    try {
      final expiryTime = DateTime.now().add(expiry);
      final cacheInfo = {
        'data': response.data,
        'statusCode': response.statusCode,
        'headers': response.headers.map,
        'expiryTime': expiryTime.toIso8601String(),
      };
      
      await SharedPreferencesManager.instance.setString(
        'cache_$key',
        jsonEncode(cacheInfo),
      );
    } catch (e) {
      LogUtils.e('缓存数据失败: $e');
    }
  }

  /// 移除缓存数据
  static Future<void> _removeCachedData(String key) async {
    try {
      await SharedPreferencesManager.instance.remove('cache_$key');
    } catch (e) {
      LogUtils.e('移除缓存数据失败: $e');
    }
  }

  /// 清除所有缓存
  static Future<void> clearAllCache() async {
    try {
      final keys = SharedPreferencesManager.instance.getKeys();
      final cacheKeys = keys.where((key) => key.startsWith('cache_'));
      
      for (final key in cacheKeys) {
        await SharedPreferencesManager.instance.remove(key);
      }
      
      LogUtils.d('清除所有缓存完成');
    } catch (e) {
      LogUtils.e('清除所有缓存失败: $e');
    }
  }

  /// 清除过期缓存
  static Future<void> clearExpiredCache() async {
    try {
      final keys = SharedPreferencesManager.instance.getKeys();
      final cacheKeys = keys.where((key) => key.startsWith('cache_'));
      
      for (final key in cacheKeys) {
        final cacheData = SharedPreferencesManager.instance.getString(key);
        if (cacheData != null) {
          try {
            final cacheInfo = jsonDecode(cacheData) as Map<String, dynamic>;
            final expiryTime = DateTime.parse(cacheInfo['expiryTime'] as String);
            
            if (DateTime.now().isAfter(expiryTime)) {
              await SharedPreferencesManager.instance.remove(key);
            }
          } catch (e) {
            // 解析失败，删除该缓存
            await SharedPreferencesManager.instance.remove(key);
          }
        }
      }
      
      LogUtils.d('清除过期缓存完成');
    } catch (e) {
      LogUtils.e('清除过期缓存失败: $e');
    }
  }

  // ==================== 工具方法 ====================

  /// 设置请求头
  static void setHeader(String key, String value) {
    dio.options.headers[key] = value;
    LogUtils.d('设置请求头: $key = $value');
  }

  /// 移除请求头
  static void removeHeader(String key) {
    dio.options.headers.remove(key);
    LogUtils.d('移除请求头: $key');
  }

  /// 设置基础URL
  static void setBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    LogUtils.d('设置基础URL: $baseUrl');
  }

  /// 设置超时时间
  static void setTimeout({
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    if (connectTimeout != null) {
      dio.options.connectTimeout = connectTimeout;
    }
    if (receiveTimeout != null) {
      dio.options.receiveTimeout = receiveTimeout;
    }
    if (sendTimeout != null) {
      dio.options.sendTimeout = sendTimeout;
    }
    LogUtils.d('设置超时时间完成');
  }

  /// 取消所有请求
  static void cancelAllRequests() {
    dio.close();
    LogUtils.d('取消所有请求');
  }
}
