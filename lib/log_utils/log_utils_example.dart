/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: 日志工具使用示例
 */

import 'package:logger/logger.dart';
import 'log_utils.dart';

/// 日志工具使用示例
class LogUtilsExample {
  
  /// 基本日志使用示例
  static void basicLoggingExample() {
    // 初始化日志工具
    LogUtils.init(
      enabled: true,
      minLevel: Level.debug,
    );

    // 不同级别的日志
    LogUtils.d('这是一条Debug日志');
    LogUtils.i('这是一条Info日志');
    LogUtils.w('这是一条Warning日志');
    LogUtils.e('这是一条Error日志');

    // 带错误和堆栈跟踪的日志
    try {
      throw Exception('测试异常');
    } catch (e, stackTrace) {
      LogUtils.e('捕获到异常', e, stackTrace);
    }
  }

  /// 网络请求日志示例
  static void networkLoggingExample() {
    // 模拟网络请求日志
    LogUtils.network(
      'GET',
      'https://api.example.com/users',
      headers: {'Authorization': 'Bearer token123'},
      data: {'page': 1, 'limit': 10},
      statusCode: 200,
      response: '{"users": []}',
    );

    // 模拟网络错误日志
    LogUtils.network(
      'POST',
      'https://api.example.com/login',
      headers: {'Content-Type': 'application/json'},
      data: {'username': 'test', 'password': '123456'},
      statusCode: 401,
      response: '{"error": "Unauthorized"}',
    );
  }

  /// API响应日志示例
  static void apiResponseLoggingExample() {
    // 成功的API响应
    LogUtils.apiResponse(
      '/api/users',
      statusCode: 200,
      data: {'id': 1, 'name': '张三', 'email': 'zhangsan@example.com'},
    );

    // 失败的API响应
    LogUtils.apiResponse(
      '/api/users',
      statusCode: 404,
      error: '用户不存在',
    );
  }

  /// 用户行为日志示例
  static void userActionLoggingExample() {
    // 用户登录
    LogUtils.userAction('用户登录', params: {
      'username': 'testuser',
      'loginTime': DateTime.now().toIso8601String(),
    });

    // 用户点击按钮
    LogUtils.userAction('点击购买按钮', params: {
      'productId': '12345',
      'price': 99.99,
      'category': '电子产品',
    });

    // 用户搜索
    LogUtils.userAction('搜索商品', params: {
      'keyword': '手机',
      'filters': {'brand': 'Apple', 'priceRange': '5000-10000'},
    });
  }

  /// 性能监控日志示例
  static void performanceLoggingExample() {
    // 模拟性能监控
    final stopwatch = Stopwatch()..start();
    
    // 模拟一些耗时操作
    Future.delayed(Duration(milliseconds: 150), () {
      stopwatch.stop();
      LogUtils.performance('数据库查询', stopwatch.elapsed);
    });

    // 模拟网络请求性能
    final networkStopwatch = Stopwatch()..start();
    Future.delayed(Duration(milliseconds: 300), () {
      networkStopwatch.stop();
      LogUtils.performance('API请求', networkStopwatch.elapsed);
    });
  }

  /// 动态控制日志示例
  static void dynamicControlExample() {
    // 运行时禁用日志
    LogUtils.setEnabled(false);
    LogUtils.d('这条日志不会显示'); // 不会输出

    // 重新启用日志
    LogUtils.setEnabled(true);
    LogUtils.d('这条日志会显示'); // 会输出

    // 设置最小日志级别
    LogUtils.setMinLevel(Level.warning);
    LogUtils.d('Debug日志不会显示'); // 不会输出
    LogUtils.i('Info日志不会显示'); // 不会输出
    LogUtils.w('Warning日志会显示'); // 会输出
    LogUtils.e('Error日志会显示'); // 会输出
  }

  /// 运行所有示例
  static void runAllExamples() {
    print('=== 基本日志示例 ===');
    basicLoggingExample();
    
    print('\n=== 网络请求日志示例 ===');
    networkLoggingExample();
    
    print('\n=== API响应日志示例 ===');
    apiResponseLoggingExample();
    
    print('\n=== 用户行为日志示例 ===');
    userActionLoggingExample();
    
    print('\n=== 性能监控日志示例 ===');
    performanceLoggingExample();
    
    print('\n=== 动态控制日志示例 ===');
    dynamicControlExample();
  }
}
