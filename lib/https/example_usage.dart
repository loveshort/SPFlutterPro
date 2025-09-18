/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: HttpsEngine 使用示例
 */

import 'https_engine.dart';
import '../log_utils/log_utils.dart';

/// HttpsEngine 使用示例
class HttpsEngineExample {
  
  /// 初始化示例
  static Future<void> initExample() async {
    // 初始化网络请求引擎
    await HttpsEngine.init();
    
    // 设置基础URL
    HttpsEngine.setBaseUrl('https://api.example.com');
    
    // 设置请求头
    HttpsEngine.setHeader('Content-Type', 'application/json');
    HttpsEngine.setHeader('User-Agent', 'MyApp/1.0');
    
    // 设置超时时间
    HttpsEngine.setTimeout(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
    );
    
    LogUtils.i('HttpsEngine 初始化完成');
  }

  // ==================== 基础请求示例 ====================

  /// GET请求示例
  static Future<void> getExample() async {
    try {
      // 不带缓存的GET请求
      final response = await HttpsEngine.get<Map<String, dynamic>>(
        '/users',
        queryParameters: {
          'page': 1,
          'limit': 10,
        },
      );
      
      LogUtils.d('GET请求结果: ${response.data}');
    } catch (e) {
      LogUtils.e('GET请求失败: $e');
    }
  }

  /// POST请求示例
  static Future<void> postExample() async {
    try {
      // POST请求
      final response = await HttpsEngine.post<Map<String, dynamic>>(
        '/users',
        data: {
          'name': '张三',
          'email': 'zhangsan@example.com',
          'age': 25,
        },
      );
      
      LogUtils.d('POST请求结果: ${response.data}');
    } catch (e) {
      LogUtils.e('POST请求失败: $e');
    }
  }

  /// PUT请求示例
  static Future<void> putExample() async {
    try {
      // PUT请求
      final response = await HttpsEngine.put<Map<String, dynamic>>(
        '/users/123',
        data: {
          'name': '李四',
          'email': 'lisi@example.com',
        },
      );
      
      LogUtils.d('PUT请求结果: ${response.data}');
    } catch (e) {
      LogUtils.e('PUT请求失败: $e');
    }
  }

  /// DELETE请求示例
  static Future<void> deleteExample() async {
    try {
      // DELETE请求
      final response = await HttpsEngine.delete<Map<String, dynamic>>(
        '/users/123',
      );
      
      LogUtils.d('DELETE请求结果: ${response.data}');
    } catch (e) {
      LogUtils.e('DELETE请求失败: $e');
    }
  }

  // ==================== 带缓存的请求示例 ====================

  /// 带缓存的GET请求示例
  static Future<void> getWithCacheExample() async {
    try {
      // 带缓存的GET请求（默认5分钟过期）
      final response = await HttpsEngine.getWithCache<Map<String, dynamic>>(
        '/products',
        queryParameters: {
          'category': 'electronics',
          'page': 1,
        },
        cacheKey: 'products_electronics_page1', // 自定义缓存键
        cacheExpiry: const Duration(minutes: 10), // 自定义缓存过期时间
      );
      
      LogUtils.d('带缓存的GET请求结果: ${response.data}');
    } catch (e) {
      LogUtils.e('带缓存的GET请求失败: $e');
    }
  }

  /// 强制刷新缓存示例
  static Future<void> forceRefreshExample() async {
    try {
      // 强制刷新缓存
      final response = await HttpsEngine.getWithCache<Map<String, dynamic>>(
        '/products',
        queryParameters: {
          'category': 'electronics',
        },
        forceRefresh: true, // 强制刷新，忽略缓存
      );
      
      LogUtils.d('强制刷新请求结果: ${response.data}');
    } catch (e) {
      LogUtils.e('强制刷新请求失败: $e');
    }
  }

  // ==================== 文件上传下载示例 ====================

  /// 文件上传示例
  static Future<void> uploadFileExample() async {
    try {
      // 文件上传
      final response = await HttpsEngine.uploadFile<Map<String, dynamic>>(
        '/upload',
        '/path/to/local/file.jpg',
        fileName: 'avatar.jpg',
        data: {
          'userId': '123',
          'type': 'avatar',
        },
        onSendProgress: (sent, total) {
          final progress = (sent / total * 100).toStringAsFixed(1);
          LogUtils.d('上传进度: $progress%');
        },
      );
      
      LogUtils.d('文件上传结果: ${response.data}');
    } catch (e) {
      LogUtils.e('文件上传失败: $e');
    }
  }

  /// 文件下载示例
  static Future<void> downloadFileExample() async {
    try {
      // 文件下载
      final savePath = await HttpsEngine.downloadFile(
        'https://example.com/files/document.pdf',
        fileName: 'my_document.pdf',
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = (received / total * 100).toStringAsFixed(1);
            LogUtils.d('下载进度: $progress%');
          }
        },
      );
      
      LogUtils.d('文件下载完成，保存路径: $savePath');
    } catch (e) {
      LogUtils.e('文件下载失败: $e');
    }
  }

  // ==================== 缓存管理示例 ====================

  /// 清除缓存示例
  static Future<void> clearCacheExample() async {
    try {
      // 清除所有缓存
      await HttpsEngine.clearAllCache();
      LogUtils.d('所有缓存已清除');
      
      // 清除过期缓存
      await HttpsEngine.clearExpiredCache();
      LogUtils.d('过期缓存已清除');
    } catch (e) {
      LogUtils.e('清除缓存失败: $e');
    }
  }

  // ==================== 完整使用示例 ====================

  /// 完整的使用示例
  static Future<void> completeExample() async {
    try {
      // 1. 初始化
      await initExample();
      
      // 2. 基础请求
      await getExample();
      await postExample();
      await putExample();
      await deleteExample();
      
      // 3. 带缓存的请求
      await getWithCacheExample();
      await forceRefreshExample();
      
      // 4. 文件操作
      await uploadFileExample();
      await downloadFileExample();
      
      // 5. 缓存管理
      await clearCacheExample();
      
      LogUtils.i('所有示例执行完成');
    } catch (e) {
      LogUtils.e('示例执行失败: $e');
    }
  }
}
