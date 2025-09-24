/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-24 10:10:58
 * @FilePath: /SPFlutterPro/lib/router/middleware.dart
 * @Description: 路由中间件
 */

import 'package:common_flutter_network/common_flutter_network.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// 路由中间件基类
abstract class RouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    LogUtils.d('路由中间件检查: $route');
    return null;
  }

  @override
  GetPage? onPageCalled(GetPage? page) {
    LogUtils.d('页面调用: ${page?.name}');
    return page;
  }

  @override
  Widget onPageBuilt(Widget page) {
    LogUtils.d('页面构建完成: ${page.runtimeType}');
    return page;
  }

  @override
  void onPageDispose() {
    LogUtils.d('页面销毁');
  }
}

/// 登录检查中间件
class AuthMiddleware extends RouteMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // 这里可以添加登录状态检查逻辑
    // 如果未登录，可以重定向到登录页面
    LogUtils.d('登录状态检查: $route');

    // 示例：检查需要登录的页面
    final protectedRoutes = ['/profile', '/orderList', '/addressList'];
    if (protectedRoutes.contains(route)) {
      // 这里应该检查用户登录状态
      // 如果未登录，返回登录页面路由
      // return const RouteSettings(name: '/login');
    }

    return null;
  }
}

/// 权限检查中间件
class PermissionMiddleware extends RouteMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    LogUtils.d('权限检查: $route');

    // 这里可以添加权限检查逻辑
    // 根据用户角色检查是否有权限访问特定页面

    return null;
  }
}

/// 页面缓存中间件
class CacheMiddleware extends RouteMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    LogUtils.d('页面缓存检查: ${page?.name}');

    // 这里可以添加页面缓存逻辑
    // 例如：某些页面需要保持状态

    return page;
  }
}

/// 页面统计中间件
class AnalyticsMiddleware extends RouteMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    LogUtils.d('页面访问统计: ${page?.name}');

    // 这里可以添加页面访问统计逻辑
    // 例如：记录用户访问的页面，用于数据分析

    return page;
  }

  @override
  void onPageDispose() {
    LogUtils.d('页面停留时间统计');

    // 这里可以添加页面停留时间统计逻辑
  }
}

/// 网络状态检查中间件
class NetworkMiddleware extends RouteMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    LogUtils.d('网络状态检查: $route');

    // 这里可以添加网络状态检查逻辑
    // 如果网络不可用，可以重定向到网络错误页面

    return null;
  }
}

/// 版本检查中间件
class VersionMiddleware extends RouteMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    LogUtils.d('版本检查: $route');

    // 这里可以添加版本检查逻辑
    // 如果应用版本过低，可以重定向到更新页面

    return null;
  }
}

/// 路由中间件管理器
class MiddlewareManager {
  static final MiddlewareManager _instance = MiddlewareManager._internal();
  factory MiddlewareManager() => _instance;
  MiddlewareManager._internal();

  static MiddlewareManager get instance => _instance;

  /// 获取全局中间件列表
  static List<GetMiddleware> get globalMiddlewares => [
        AnalyticsMiddleware(),
        CacheMiddleware(),
        NetworkMiddleware(),
        VersionMiddleware(),
      ];

  /// 获取需要登录的页面中间件
  static List<GetMiddleware> get authMiddlewares => [
        AuthMiddleware(),
        PermissionMiddleware(),
      ];

  /// 获取所有中间件
  static List<GetMiddleware> get allMiddlewares => [
        ...globalMiddlewares,
        ...authMiddlewares,
      ];
}
