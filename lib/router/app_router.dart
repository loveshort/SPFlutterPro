/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-24 10:10:55
 * @FilePath: /SPFlutterPro/lib/router/app_router.dart
 * @Description: 路由管理类
 */

import 'package:common_flutter_network/common_flutter_network.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

// 导入路由配置
import 'app_pages.dart';

/// 路由管理类
class AppRouter {
  // 单例模式
  static final AppRouter _instance = AppRouter._internal();
  factory AppRouter() => _instance;
  AppRouter._internal();

  static AppRouter get instance => _instance;

  /// 初始化路由
  static void init() {
    LogUtils.i('初始化路由系统');
  }

  /// 获取所有路由
  static List<GetPage> get routes => AppPages.pages;

  /// 获取初始路由
  static String get initialRoute => AppPages.initial;

  /// 路由跳转方法
  /// [routeName] 路由名称
  /// [arguments] 传递的参数
  /// [transition] 转场动画
  /// [duration] 动画时长
  static Future<T?>? toNamed<T>(
    String routeName, {
    dynamic arguments,
    Transition? transition,
    Duration? duration,
  }) {
    LogUtils.d('路由跳转: $routeName');
    return Get.toNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// 路由跳转并清除当前页面
  /// [routeName] 路由名称
  /// [arguments] 传递的参数
  /// [transition] 转场动画
  /// [duration] 动画时长
  static Future<T?>? offNamed<T>(
    String routeName, {
    dynamic arguments,
    Transition? transition,
    Duration? duration,
  }) {
    LogUtils.d('路由跳转(替换): $routeName');
    return Get.offNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// 路由跳转并清除所有页面
  /// [routeName] 路由名称
  /// [arguments] 传递的参数
  /// [transition] 转场动画
  /// [duration] 动画时长
  static Future<T?>? offAllNamed<T>(
    String routeName, {
    dynamic arguments,
    Transition? transition,
    Duration? duration,
  }) {
    LogUtils.d('路由跳转(清除所有): $routeName');
    return Get.offAllNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// 返回上一页
  /// [result] 返回结果
  static void back<T>({T? result}) {
    LogUtils.d('返回上一页');
    Get.back<T>(result: result);
  }

  /// 返回到指定页面
  /// [routeName] 路由名称
  /// [arguments] 传递的参数
  static void backToNamed(String routeName, {dynamic arguments}) {
    LogUtils.d('返回到指定页面: $routeName');
    Get.until((route) => route.settings.name == routeName);
  }

  /// 检查是否可以返回
  static bool get canPop => Get.key.currentState?.canPop() ?? false;

  /// 获取当前路由名称
  static String? get currentRoute => Get.currentRoute;

  /// 获取路由参数
  static dynamic get arguments => Get.arguments;

  /// 获取路由参数
  static T? getArguments<T>() => Get.arguments as T?;

  /// 显示加载对话框
  static void showLoading({String? message}) {
    LogUtils.d('显示加载对话框');
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(message),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// 隐藏加载对话框
  static void hideLoading() {
    LogUtils.d('隐藏加载对话框');
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }

  /// 显示确认对话框
  static Future<bool?> showConfirmDialog({
    String? title,
    String? content,
    String confirmText = '确认',
    String cancelText = '取消',
  }) {
    LogUtils.d('显示确认对话框');
    return Get.dialog<bool>(
      AlertDialog(
        title: title != null ? Text(title) : null,
        content: content != null ? Text(content) : null,
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// 显示提示对话框
  static Future<void> showAlertDialog({
    String? title,
    String? content,
    String confirmText = '确定',
  }) {
    LogUtils.d('显示提示对话框');
    return Get.dialog(
      AlertDialog(
        title: title != null ? Text(title) : null,
        content: content != null ? Text(content) : null,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// 显示底部弹窗
  static Future<T?> showBottomSheet<T>(
    Widget child, {
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    LogUtils.d('显示底部弹窗');
    return Get.bottomSheet<T>(
      child,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  /// 显示SnackBar
  static void showSnackBar(
    String message, {
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
    Color? backgroundColor,
    Color? textColor,
  }) {
    LogUtils.d('显示SnackBar: $message');
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
      backgroundColor: ColorManager.success,
      textColor: Colors.white,
    );
  }

  /// 显示错误提示
  static void showError(String message) {
    showSnackBar(
      message,
      title: '错误',
      backgroundColor: ColorManager.error,
      textColor: Colors.white,
    );
  }

  /// 显示警告提示
  static void showWarning(String message) {
    showSnackBar(
      message,
      title: '警告',
      backgroundColor: ColorManager.warning,
      textColor: Colors.white,
    );
  }

  /// 显示信息提示
  static void showInfo(String message) {
    showSnackBar(
      message,
      title: '提示',
      backgroundColor: ColorManager.info,
      textColor: Colors.white,
    );
  }
}
