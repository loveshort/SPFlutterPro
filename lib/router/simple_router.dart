/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/router/simple_router.dart
 * @Description: 简化路由工具类
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 简化路由工具类
class SimpleRouter {
  // 私有构造函数，防止实例化
  SimpleRouter._();

  /// 跳转到指定页面
  static Future<T?> toNamed<T>(String routeName, {dynamic arguments}) {
    return Get.toNamed<T>(routeName, arguments: arguments) ??
        Future.value(null);
  }

  /// 跳转并替换当前页面
  static Future<T?> offNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offNamed<T>(routeName, arguments: arguments) ??
        Future.value(null);
  }

  /// 跳转并清除所有页面
  static Future<T?> offAllNamed<T>(String routeName, {dynamic arguments}) {
    return Get.offAllNamed<T>(routeName, arguments: arguments) ??
        Future.value(null);
  }

  /// 返回上一页
  static void back<T>({T? result}) {
    Get.back<T>(result: result);
  }

  /// 返回到指定页面
  static void backToNamed(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }

  /// 检查是否可以返回
  static bool get canPop => Get.key.currentState?.canPop() ?? false;

  /// 获取当前路由名称
  static String? get currentRoute => Get.currentRoute;

  /// 获取路由参数
  static dynamic get arguments => Get.arguments;

  /// 显示SnackBar
  static void showSnackBar(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
    Color? backgroundColor,
    Color? textColor,
  }) {
    Get.snackbar(
      title ?? '',
      message,
      duration: duration,
      snackPosition: position,
      backgroundColor: backgroundColor,
      colorText: textColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }

  /// 显示成功提示
  static void showSuccess(String message) {
    showSnackBar(
      message,
      title: '成功',
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  /// 显示错误提示
  static void showError(String message) {
    showSnackBar(
      message,
      title: '错误',
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  /// 显示警告提示
  static void showWarning(String message) {
    showSnackBar(
      message,
      title: '警告',
      backgroundColor: Colors.orange,
      textColor: Colors.white,
    );
  }

  /// 显示信息提示
  static void showInfo(String message) {
    showSnackBar(
      message,
      title: '提示',
      backgroundColor: Colors.blue,
      textColor: Colors.white,
    );
  }
}
