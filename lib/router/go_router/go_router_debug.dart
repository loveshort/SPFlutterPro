/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/router/go_router_debug.dart
 * @Description: GoRouter 调试工具 - 路由测试和调试功能
 */

import 'package:flutter/material.dart';
import 'go_router_routes.dart';
import 'go_router_utils.dart';

/// GoRouter 调试工具
/// 提供路由测试和调试功能
class GoRouterDebug {
  // 私有构造函数，防止实例化
  GoRouterDebug._();

  // ==================== 调试开关 ====================

  /// 是否启用调试模式
  static bool _isDebugEnabled = false;

  /// 启用调试模式
  static void enableDebug() {
    _isDebugEnabled = true;
    debugPrint('GoRouter Debug: 调试模式已启用');
  }

  /// 禁用调试模式
  static void disableDebug() {
    _isDebugEnabled = false;
    debugPrint('GoRouter Debug: 调试模式已禁用');
  }

  /// 检查是否启用调试模式
  static bool get isDebugEnabled => _isDebugEnabled;

  // ==================== 调试日志 ====================

  /// 调试日志
  static void log(String message, {String? tag}) {
    if (_isDebugEnabled) {
      final timestamp = DateTime.now().toIso8601String();
      final tagStr = tag != null ? '[$tag]' : '';
      debugPrint('GoRouter Debug $tagStr [$timestamp]: $message');
    }
  }

  /// 路由导航日志
  static void logNavigation(String from, String to, {String? method}) {
    log('导航: $from -> $to${method != null ? ' (方法: $method)' : ''}',
        tag: 'Navigation');
  }

  /// 路由参数日志
  static void logParameters(Map<String, dynamic> parameters, {String? type}) {
    log('参数 ($type): $parameters', tag: 'Parameters');
  }

  /// 路由错误日志
  static void logError(String error, {StackTrace? stackTrace}) {
    log('错误: $error', tag: 'Error');
    if (stackTrace != null) {
      log('堆栈跟踪: $stackTrace', tag: 'Error');
    }
  }

  // ==================== 路由测试 ====================

  /// 测试所有路由
  static Future<void> testAllRoutes() async {
    log('开始测试所有路由...', tag: 'Test');

    final routes = GoRouterRoutes.allPaths;
    for (final route in routes) {
      await _testRoute(route);
    }

    log('所有路由测试完成', tag: 'Test');
  }

  /// 测试指定路由
  static Future<void> testRoute(String route) async {
    log('测试路由: $route', tag: 'Test');
    await _testRoute(route);
  }

  /// 内部路由测试方法
  static Future<void> _testRoute(String route) async {
    try {
      // 模拟导航到路由
      GoRouterUtils.go(route);
      log('路由测试成功: $route', tag: 'Test');

      // 等待一小段时间
      await Future.delayed(const Duration(milliseconds: 100));

      // 返回首页
      GoRouterUtils.goHome();
    } catch (e) {
      logError('路由测试失败: $route - $e');
    }
  }

  /// 测试路由参数
  static void testRouteParameters() {
    log('测试路由参数...', tag: 'Test');

    // 测试路径参数
    final todoId = 'test-todo-123';
    final productId = 'test-product-456';

    GoRouterUtils.goTodoDetail(todoId);
    GoRouterUtils.goProductDetail(productId);

    // 测试查询参数
    final queryParams = {
      GoRouterQueryParams.searchQuery: 'test query',
      GoRouterQueryParams.searchCategory: 'electronics',
      GoRouterQueryParams.page: '1',
    };

    final pathWithParams = GoRouterUtils.addQueryParameters(
      GoRouterRoutes.search,
      queryParams,
    );

    GoRouterUtils.go(pathWithParams);

    log('路由参数测试完成', tag: 'Test');
  }

  // ==================== 路由分析 ====================

  /// 分析路由使用情况
  static Map<String, int> analyzeRouteUsage() {
    log('分析路由使用情况...', tag: 'Analysis');

    // TODO: 实现路由使用情况分析
    // 可以从路由历史或分析数据中获取

    final usage = <String, int>{};
    for (final route in GoRouterRoutes.allPaths) {
      usage[route] = 0; // 模拟数据
    }

    log('路由使用情况分析完成', tag: 'Analysis');
    return usage;
  }

  /// 分析路由性能
  static Map<String, Duration> analyzeRoutePerformance() {
    log('分析路由性能...', tag: 'Analysis');

    // TODO: 实现路由性能分析
    // 可以测量路由切换的时间

    final performance = <String, Duration>{};
    for (final route in GoRouterRoutes.allPaths) {
      performance[route] = const Duration(milliseconds: 100); // 模拟数据
    }

    log('路由性能分析完成', tag: 'Analysis');
    return performance;
  }

  /// 生成路由报告
  static String generateRouteReport() {
    log('生成路由报告...', tag: 'Report');

    final usage = analyzeRouteUsage();
    final performance = analyzeRoutePerformance();

    final buffer = StringBuffer();
    buffer.writeln('=== GoRouter 路由报告 ===');
    buffer.writeln('生成时间: ${DateTime.now()}');
    buffer.writeln('总路由数: ${GoRouterRoutes.allPaths.length}');
    buffer.writeln('');

    buffer.writeln('=== 路由使用情况 ===');
    usage.forEach((route, count) {
      buffer.writeln('$route: $count 次');
    });
    buffer.writeln('');

    buffer.writeln('=== 路由性能 ===');
    performance.forEach((route, duration) {
      buffer.writeln('$route: ${duration.inMilliseconds}ms');
    });

    final report = buffer.toString();
    log('路由报告生成完成', tag: 'Report');
    return report;
  }

  // ==================== 调试UI ====================

  /// 创建调试浮动按钮
  static Widget createDebugFloatingButton(BuildContext context) {
    if (!_isDebugEnabled) return const SizedBox.shrink();

    return FloatingActionButton(
      onPressed: () => _showDebugDialog(context),
      backgroundColor: Colors.red,
      child: const Icon(Icons.bug_report, color: Colors.white),
    );
  }

  /// 显示调试对话框
  static void _showDebugDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('GoRouter 调试工具'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDebugInfo(),
              const SizedBox(height: 16),
              _buildDebugActions(context),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  /// 构建调试信息
  static Widget _buildDebugInfo() {
    final currentPath = GoRouterUtils.getCurrentPath();
    final currentName = GoRouterUtils.getCurrentRouteName();
    final historyLength = GoRouterUtils.getHistoryLength();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('当前路径: $currentPath'),
        Text('当前名称: $currentName ?? "无"'),
        Text('历史长度: $historyLength'),
        Text('调试模式: ${_isDebugEnabled ? "启用" : "禁用"}'),
      ],
    );
  }

  /// 构建调试操作
  static Widget _buildDebugActions(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            GoRouterUtils.printCurrentRoute();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('当前路由信息已打印到控制台')),
            );
          },
          child: const Text('打印当前路由'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            GoRouterUtils.printRouteHistory();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('路由历史已打印到控制台')),
            );
          },
          child: const Text('打印路由历史'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            await GoRouterDebug.testAllRoutes();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('路由测试完成')),
              );
            }
          },
          child: const Text('测试所有路由'),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            final report = GoRouterDebug.generateRouteReport();
            debugPrint(report);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('路由报告已生成')),
            );
          },
          child: const Text('生成路由报告'),
        ),
      ],
    );
  }

  // ==================== 路由监控 ====================

  /// 路由监控器
  static final List<RouteMonitor> _monitors = [];

  /// 添加路由监控器
  static void addMonitor(RouteMonitor monitor) {
    _monitors.add(monitor);
    log('添加路由监控器: ${monitor.runtimeType}', tag: 'Monitor');
  }

  /// 移除路由监控器
  static void removeMonitor(RouteMonitor monitor) {
    _monitors.remove(monitor);
    log('移除路由监控器: ${monitor.runtimeType}', tag: 'Monitor');
  }

  /// 通知所有监控器
  static void notifyMonitors(String event, Map<String, dynamic> data) {
    for (final monitor in _monitors) {
      try {
        monitor.onRouteEvent(event, data);
      } catch (e) {
        logError('监控器通知失败: $e');
      }
    }
  }
}

/// 路由监控器接口
abstract class RouteMonitor {
  /// 路由事件回调
  void onRouteEvent(String event, Map<String, dynamic> data);
}

/// 性能监控器
class PerformanceMonitor implements RouteMonitor {
  final Map<String, DateTime> _startTimes = {};
  final Map<String, Duration> _durations = {};

  @override
  void onRouteEvent(String event, Map<String, dynamic> data) {
    switch (event) {
      case 'route_start':
        _startTimes[data['route']] = DateTime.now();
        break;
      case 'route_end':
        final route = data['route'];
        final startTime = _startTimes[route];
        if (startTime != null) {
          final duration = DateTime.now().difference(startTime);
          _durations[route] = duration;
          GoRouterDebug.log('路由 $route 耗时: ${duration.inMilliseconds}ms',
              tag: 'Performance');
        }
        break;
    }
  }

  /// 获取性能数据
  Map<String, Duration> getPerformanceData() => Map.from(_durations);
}

/// 使用情况监控器
class UsageMonitor implements RouteMonitor {
  final Map<String, int> _usageCount = {};

  @override
  void onRouteEvent(String event, Map<String, dynamic> data) {
    if (event == 'route_navigate') {
      final route = data['route'];
      _usageCount[route] = (_usageCount[route] ?? 0) + 1;
      GoRouterDebug.log('路由 $route 使用次数: ${_usageCount[route]}', tag: 'Usage');
    }
  }

  /// 获取使用情况数据
  Map<String, int> getUsageData() => Map.from(_usageCount);
}

/// 错误监控器
class ErrorMonitor implements RouteMonitor {
  final List<RouteError> _errors = [];

  @override
  void onRouteEvent(String event, Map<String, dynamic> data) {
    if (event == 'route_error') {
      final error = RouteError(
        route: data['route'],
        error: data['error'],
        timestamp: DateTime.now(),
        stackTrace: data['stackTrace'],
      );
      _errors.add(error);
      GoRouterDebug.logError('路由错误: ${error.route} - ${error.error}');
    }
  }

  /// 获取错误列表
  List<RouteError> getErrors() => List.from(_errors);

  /// 清除错误记录
  void clearErrors() => _errors.clear();
}

/// 路由错误类
class RouteError {
  final String route;
  final String error;
  final DateTime timestamp;
  final StackTrace? stackTrace;

  const RouteError({
    required this.route,
    required this.error,
    required this.timestamp,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'RouteError(route: $route, error: $error, timestamp: $timestamp)';
  }
}
