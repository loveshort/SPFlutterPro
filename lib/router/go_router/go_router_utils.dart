/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/router/go_router_utils.dart
 * @Description: GoRouter 工具类 - 便捷的路由操作和扩展
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'go_router_routes.dart';
import 'go_router_config.dart';

/// GoRouter 工具类
/// 提供便捷的路由操作方法
class GoRouterUtils {
  // 私有构造函数，防止实例化
  GoRouterUtils._();

  // ==================== 基础导航方法 ====================

  /// 导航到指定路径
  static void go(String path, {Object? extra}) {
    GoRouterConfig.instance.router.go(path, extra: extra);
  }

  /// 导航到指定路径（替换当前路由）
  static void goReplacement(String path, {Object? extra}) {
    GoRouterConfig.instance.router.go(path, extra: extra);
  }

  /// 推入新路由
  static void push(String path, {Object? extra}) {
    GoRouterConfig.instance.router.push(path, extra: extra);
  }

  /// 推入命名路由
  static void pushNamed(String name,
      {Object? extra,
      Map<String, String>? pathParameters,
      Map<String, dynamic>? queryParameters}) {
    GoRouterConfig.instance.router.pushNamed(name,
        extra: extra,
        pathParameters: pathParameters ?? {},
        queryParameters: queryParameters ?? {});
  }

  /// 弹出当前路由
  static void pop([Object? result]) {
    GoRouterConfig.instance.router.pop(result);
  }

  /// 弹出到指定路径
  static void popTo(String path) {
    GoRouterConfig.instance.router.go(path);
  }

  /// 弹出到根路由
  static void popToRoot() {
    GoRouterConfig.instance.router.go(GoRouterRoutes.home);
  }

  // ==================== 便捷导航方法 ====================

  /// 导航到首页
  static void goHome() {
    go(GoRouterRoutes.home);
  }

  /// 导航到登录页
  static void goLogin({String? returnTo}) {
    final path = returnTo != null
        ? '${GoRouterRoutes.login}?${GoRouterQueryParams.returnTo}=$returnTo'
        : GoRouterRoutes.login;
    go(path);
  }

  /// 导航到主Tab页
  static void goMainTab() {
    go(GoRouterRoutes.mainTab);
  }

  /// 导航到指定Tab
  static void goTab(String tabName) {
    go(GoRouterRoutes.tabPath(tabName));
  }

  /// 导航到GetX示例
  static void goGetXExample() {
    go(GoRouterRoutes.getxExample);
  }

  /// 导航到Riverpod示例
  static void goRiverpodExample() {
    go(GoRouterRoutes.riverpodExample);
  }

  /// 导航到Todo列表
  static void goTodoList() {
    go(GoRouterRoutes.todoList);
  }

  /// 导航到Todo详情
  static void goTodoDetail(String todoId) {
    go(GoRouterRoutes.todoDetailPath(todoId));
  }

  /// 导航到Todo表单
  static void goTodoForm({dynamic todo}) {
    push(GoRouterRoutes.todoForm, extra: todo);
  }

  /// 导航到产品列表
  static void goProductList() {
    go(GoRouterRoutes.riverpodProductList);
  }

  /// 导航到产品详情
  static void goProductDetail(String productId) {
    go(GoRouterRoutes.productDetailPath(productId));
  }

  /// 导航到购物车
  static void goCart() {
    go(GoRouterRoutes.riverpodCart);
  }

  /// 导航到搜索页
  static void goSearch({String? query}) {
    final path = query != null
        ? '${GoRouterRoutes.search}?${GoRouterQueryParams.searchQuery}=$query'
        : GoRouterRoutes.search;
    go(path);
  }

  /// 导航到设置页
  static void goSettings() {
    go(GoRouterRoutes.settings);
  }

  /// 导航到关于页
  static void goAbout() {
    go(GoRouterRoutes.about);
  }

  // ==================== 查询参数方法 ====================

  /// 构建查询参数字符串
  static String buildQueryString(Map<String, dynamic> parameters) {
    if (parameters.isEmpty) return '';

    final queryParams = parameters.entries
        .where((entry) => entry.value != null)
        .map((entry) =>
            '${entry.key}=${Uri.encodeComponent(entry.value.toString())}')
        .join('&');

    return queryParams.isNotEmpty ? '?$queryParams' : '';
  }

  /// 解析查询参数
  static Map<String, String> parseQueryParameters(String queryString) {
    if (queryString.isEmpty) return {};

    final params = <String, String>{};
    final pairs = queryString.startsWith('?')
        ? queryString.substring(1).split('&')
        : queryString.split('&');

    for (final pair in pairs) {
      if (pair.isNotEmpty) {
        final parts = pair.split('=');
        if (parts.length == 2) {
          params[parts[0]] = Uri.decodeComponent(parts[1]);
        }
      }
    }

    return params;
  }

  /// 添加查询参数到路径
  static String addQueryParameters(
      String path, Map<String, dynamic> parameters) {
    final queryString = buildQueryString(parameters);
    return queryString.isNotEmpty ? '$path$queryString' : path;
  }

  // ==================== 路径参数方法 ====================

  /// 构建带路径参数的URL
  static String buildPathWithParams(
      String template, Map<String, String> parameters) {
    String path = template;
    parameters.forEach((key, value) {
      path = path.replaceAll(':$key', value);
    });
    return path;
  }

  /// 提取路径参数
  static Map<String, String> extractPathParameters(
      String template, String actualPath) {
    final params = <String, String>{};
    final templateParts = template.split('/');
    final actualParts = actualPath.split('/');

    if (templateParts.length != actualParts.length) return params;

    for (int i = 0; i < templateParts.length; i++) {
      final templatePart = templateParts[i];
      final actualPart = actualParts[i];

      if (templatePart.startsWith(':')) {
        final paramName = templatePart.substring(1);
        params[paramName] = actualPart;
      }
    }

    return params;
  }

  // ==================== 路由状态方法 ====================

  /// 获取当前路由状态
  static GoRouterState? getCurrentState() {
    // 简化实现，返回null
    return null;
  }

  /// 获取当前路径
  static String getCurrentPath() {
    // 简化实现，返回默认路径
    return '/';
  }

  /// 获取当前路由名称
  static String? getCurrentRouteName() {
    // 简化实现，返回null
    return null;
  }

  /// 检查是否在指定路径
  static bool isCurrentPath(String path) {
    return getCurrentPath() == path;
  }

  /// 检查是否在指定路由组
  static bool isInRouteGroup(String groupPath) {
    return getCurrentPath().startsWith(groupPath);
  }

  // ==================== 路由历史方法 ====================

  /// 检查是否可以返回
  static bool canPop() {
    return GoRouterConfig.instance.router.canPop();
  }

  /// 获取路由历史长度
  static int getHistoryLength() {
    // 简化实现，返回0
    return 0;
  }

  /// 清空路由历史
  static void clearHistory() {
    // GoRouter没有直接清空历史的方法，但可以通过导航到根路由实现
    goHome();
  }

  // ==================== 路由验证方法 ====================

  /// 验证路径是否有效
  static bool isValidPath(String path) {
    return GoRouterRoutes.isValidPath(path);
  }

  /// 验证路由名称是否有效
  static bool isValidRouteName(String name) {
    return GoRouterRoutes.isValidName(name);
  }

  /// 获取路径对应的路由名称
  static String? getRouteNameForPath(String path) {
    return GoRouterRoutes.getRouteName(path);
  }

  // ==================== 调试方法 ====================

  /// 打印当前路由信息
  static void printCurrentRoute() {
    debugPrint('当前路由信息:');
    debugPrint('  路径: ${getCurrentPath()}');
    debugPrint('  名称: ${getCurrentRouteName() ?? "无"}');
  }

  /// 打印路由历史
  static void printRouteHistory() {
    debugPrint('路由历史: 简化实现');
  }
}

/// BuildContext 路由扩展
/// 为BuildContext添加便捷的路由方法
extension GoRouterContextExtension on BuildContext {
  // ==================== 基础导航扩展 ====================

  /// 导航到指定路径
  void goTo(String path, {Object? extra}) {
    GoRouterUtils.go(path, extra: extra);
  }

  /// 推入新路由
  void pushTo(String path, {Object? extra}) {
    GoRouterUtils.push(path, extra: extra);
  }

  /// 弹出当前路由
  void popRoute([Object? result]) {
    GoRouterUtils.pop(result);
  }

  /// 弹出到指定路径
  void popTo(String path) {
    GoRouterUtils.popTo(path);
  }

  /// 弹出到根路由
  void popToRoot() {
    GoRouterUtils.popToRoot();
  }

  // ==================== 便捷导航扩展 ====================

  /// 导航到首页
  void goHome() {
    GoRouterUtils.goHome();
  }

  /// 导航到登录页
  void goLogin({String? returnTo}) {
    GoRouterUtils.goLogin(returnTo: returnTo);
  }

  /// 导航到主Tab页
  void goMainTab() {
    GoRouterUtils.goMainTab();
  }

  /// 导航到指定Tab
  void goTab(String tabName) {
    GoRouterUtils.goTab(tabName);
  }

  /// 导航到GetX示例
  void goGetXExample() {
    GoRouterUtils.goGetXExample();
  }

  /// 导航到Riverpod示例
  void goRiverpodExample() {
    GoRouterUtils.goRiverpodExample();
  }

  /// 导航到Todo列表
  void goTodoList() {
    GoRouterUtils.goTodoList();
  }

  /// 导航到Todo详情
  void goTodoDetail(String todoId) {
    GoRouterUtils.goTodoDetail(todoId);
  }

  /// 导航到Todo表单
  void goTodoForm({dynamic todo}) {
    GoRouterUtils.goTodoForm(todo: todo);
  }

  /// 导航到产品列表
  void goProductList() {
    GoRouterUtils.goProductList();
  }

  /// 导航到产品详情
  void goProductDetail(String productId) {
    GoRouterUtils.goProductDetail(productId);
  }

  /// 导航到购物车
  void goCart() {
    GoRouterUtils.goCart();
  }

  /// 导航到搜索页
  void goSearch({String? query}) {
    GoRouterUtils.goSearch(query: query);
  }

  /// 导航到设置页
  void goSettings() {
    GoRouterUtils.goSettings();
  }

  /// 导航到关于页
  void goAbout() {
    GoRouterUtils.goAbout();
  }

  // ==================== 路由状态扩展 ====================

  /// 获取当前路径
  String get currentPath => GoRouterUtils.getCurrentPath();

  /// 获取当前路由名称
  String? get currentRouteName => GoRouterUtils.getCurrentRouteName();

  /// 检查是否在指定路径
  bool isCurrentPath(String path) => GoRouterUtils.isCurrentPath(path);

  /// 检查是否在指定路由组
  bool isInRouteGroup(String groupPath) =>
      GoRouterUtils.isInRouteGroup(groupPath);

  /// 检查是否可以返回
  bool get canPop => GoRouterUtils.canPop();
}

/// 路由结果类
/// 用于传递路由结果数据
class RouteResult<T> {
  final T? data;
  final bool success;
  final String? error;

  const RouteResult({
    this.data,
    this.success = true,
    this.error,
  });

  /// 成功结果
  factory RouteResult.success(T data) {
    return RouteResult(data: data, success: true);
  }

  /// 失败结果
  factory RouteResult.failure(String error) {
    return RouteResult(success: false, error: error);
  }

  /// 取消结果
  factory RouteResult.cancelled() {
    return const RouteResult(success: false, error: 'Cancelled');
  }
}

/// 路由参数类
/// 用于类型安全的参数传递
class RouteParams {
  final Map<String, String> pathParameters;
  final Map<String, dynamic> queryParameters;
  final Object? extra;

  const RouteParams({
    this.pathParameters = const {},
    this.queryParameters = const {},
    this.extra,
  });

  /// 获取路径参数
  String? getPathParam(String key) => pathParameters[key];

  /// 获取查询参数
  T? getQueryParam<T>(String key) {
    final value = queryParameters[key];
    if (value is T) return value;
    return null;
  }

  /// 获取额外数据
  T? getExtra<T>() {
    if (extra is T) return extra as T;
    return null;
  }
}
