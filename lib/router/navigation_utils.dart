/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/router/navigation_utils.dart
 * @Description: 导航工具类
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 导入路由常量
import 'routes.dart';
import 'app_router.dart';

/// 导航工具类
class NavigationUtils {
  // 私有构造函数，防止实例化
  NavigationUtils._();

  /// 跳转到首页
  static Future<T?> toHome<T>() {
    return AppRouter.toNamed<T>(Routes.home) ?? Future.value(null);
  }

  /// 跳转到分类页面
  static Future<T?> toCategory<T>() {
    return AppRouter.toNamed<T>(Routes.category) ?? Future.value(null);
  }

  /// 跳转到购物车页面
  static Future<T?> toCart<T>() {
    return AppRouter.toNamed<T>(Routes.cart) ?? Future.value(null);
  }

  /// 跳转到消息页面
  static Future<T?> toMessage<T>() {
    return AppRouter.toNamed<T>(Routes.message) ?? Future.value(null);
  }

  /// 跳转到个人中心页面
  static Future<T?> toProfile<T>() {
    return AppRouter.toNamed<T>(Routes.profile) ?? Future.value(null);
  }

  /// 跳转到商品详情页面
  static Future<T?> toProductDetail<T>({required String productId}) {
    return AppRouter.toNamed<T>(
          Routes.productDetail,
          arguments: {'productId': productId},
        ) ??
        Future.value(null);
  }

  /// 跳转到搜索页面
  static Future<T?> toSearch<T>({String? keyword}) {
    return AppRouter.toNamed<T>(
          Routes.search,
          arguments: {'keyword': keyword},
        ) ??
        Future.value(null);
  }

  /// 跳转到订单列表页面
  static Future<T?> toOrderList<T>({String? status}) {
    return AppRouter.toNamed<T>(
          Routes.orderList,
          arguments: {'status': status},
        ) ??
        Future.value(null);
  }

  /// 跳转到订单详情页面
  static Future<T?> toOrderDetail<T>({required String orderId}) {
    return AppRouter.toNamed<T>(
          Routes.orderDetail,
          arguments: {'orderId': orderId},
        ) ??
        Future.value(null);
  }

  /// 跳转到地址列表页面
  static Future<T?> toAddressList<T>() {
    return AppRouter.toNamed<T>(Routes.addressList) ?? Future.value(null);
  }

  /// 跳转到地址编辑页面
  static Future<T?> toAddressEdit<T>({Map<String, dynamic>? addressData}) {
    return AppRouter.toNamed<T>(
          Routes.addressEdit,
          arguments: {'addressData': addressData},
        ) ??
        Future.value(null);
  }

  /// 跳转到设置页面
  static Future<T?> toSettings<T>() {
    return AppRouter.toNamed<T>(Routes.settings) ?? Future.value(null);
  }

  /// 跳转到关于页面
  static Future<T?> toAbout<T>() {
    return AppRouter.toNamed<T>(Routes.about) ?? Future.value(null);
  }

  /// 跳转到登录页面
  static Future<T?> toLogin<T>() {
    return AppRouter.toNamed<T>(Routes.login) ?? Future.value(null);
  }

  /// 跳转到底部Tab示例页面
  static Future<T?> toBottomTabExample<T>() {
    return AppRouter.toNamed<T>(Routes.bottomTabExample) ?? Future.value(null);
  }

  /// 跳转到高级底部Tab示例页面
  static Future<T?> toAdvancedBottomTabExample<T>() {
    return AppRouter.toNamed<T>(Routes.advancedBottomTabExample) ??
        Future.value(null);
  }

  /// 跳转到颜色示例页面
  static Future<T?> toColorExample<T>() {
    return AppRouter.toNamed<T>(Routes.colorExample) ?? Future.value(null);
  }

  /// 跳转到底部弹窗示例页面
  static Future<T?> toBottomSheetExample<T>() {
    return AppRouter.toNamed<T>(Routes.bottomSheetExample) ??
        Future.value(null);
  }

  /// 跳转到中间弹窗示例页面
  static Future<T?> toCenterDialogExample<T>() {
    return AppRouter.toNamed<T>(Routes.centerDialogExample) ??
        Future.value(null);
  }

  /// 返回到首页
  static void backToHome() {
    AppRouter.backToNamed(Routes.home);
  }

  /// 返回到上一页
  static void back<T>({T? result}) {
    AppRouter.back<T>(result: result);
  }

  /// 检查是否可以返回
  static bool get canPop => AppRouter.canPop;

  /// 获取当前路由名称
  static String? get currentRoute => AppRouter.currentRoute;

  /// 获取路由参数
  static dynamic get arguments => AppRouter.arguments;

  /// 获取路由参数
  static T? getArguments<T>() => AppRouter.getArguments<T>();

  /// 显示加载对话框
  static void showLoading({String? message}) {
    AppRouter.showLoading(message: message);
  }

  /// 隐藏加载对话框
  static void hideLoading() {
    AppRouter.hideLoading();
  }

  /// 显示确认对话框
  static Future<bool?> showConfirmDialog({
    String? title,
    String? content,
    String confirmText = '确认',
    String cancelText = '取消',
  }) {
    return AppRouter.showConfirmDialog(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
    );
  }

  /// 显示提示对话框
  static Future<void> showAlertDialog({
    String? title,
    String? content,
    String confirmText = '确定',
  }) {
    return AppRouter.showAlertDialog(
      title: title,
      content: content,
      confirmText: confirmText,
    );
  }

  /// 显示底部弹窗
  static Future<T?> showBottomSheet<T>(
    Widget child, {
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return AppRouter.showBottomSheet<T>(
      child,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  /// 显示成功提示
  static void showSuccess(String message) {
    AppRouter.showSuccess(message);
  }

  /// 显示错误提示
  static void showError(String message) {
    AppRouter.showError(message);
  }

  /// 显示警告提示
  static void showWarning(String message) {
    AppRouter.showWarning(message);
  }

  /// 显示信息提示
  static void showInfo(String message) {
    AppRouter.showInfo(message);
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
    AppRouter.showSnackBar(
      message,
      title: title,
      duration: duration,
      position: position,
      backgroundColor: backgroundColor,
      textColor: textColor,
    );
  }

  /// 页面跳转动画类型
  static final Map<String, Transition> transitionTypes = {
    'fadeIn': Transition.fadeIn,
    'rightToLeft': Transition.rightToLeft,
    'leftToRight': Transition.leftToRight,
    'upToDown': Transition.upToDown,
    'downToUp': Transition.downToUp,
    'size': Transition.size,
    'rightToLeftWithFade': Transition.rightToLeftWithFade,
    'leftToRightWithFade': Transition.leftToRightWithFade,
    'cupertino': Transition.cupertino,
    'cupertinoDialog': Transition.cupertinoDialog,
    'noTransition': Transition.noTransition,
  };

  /// 获取转场动画
  static Transition getTransition(String type) {
    return transitionTypes[type] ?? Transition.rightToLeft;
  }

  /// 带转场动画的页面跳转
  static Future<T?> toNamedWithTransition<T>(
    String routeName, {
    dynamic arguments,
    String transitionType = 'rightToLeft',
    Duration? duration,
  }) {
    return AppRouter.toNamed<T>(
          routeName,
          arguments: arguments,
          transition: getTransition(transitionType),
          duration: duration,
        ) ??
        Future.value(null);
  }

  /// 页面跳转并替换当前页面
  static Future<T?> offNamed<T>(
    String routeName, {
    dynamic arguments,
    Transition? transition,
    Duration? duration,
  }) {
    return AppRouter.offNamed<T>(
          routeName,
          arguments: arguments,
          transition: transition,
          duration: duration,
        ) ??
        Future.value(null);
  }

  /// 页面跳转并清除所有页面
  static Future<T?> offAllNamed<T>(
    String routeName, {
    dynamic arguments,
    Transition? transition,
    Duration? duration,
  }) {
    return AppRouter.offAllNamed<T>(
          routeName,
          arguments: arguments,
          transition: transition,
          duration: duration,
        ) ??
        Future.value(null);
  }

  /// 返回到指定页面
  static void backToNamed(String routeName, {dynamic arguments}) {
    AppRouter.backToNamed(routeName, arguments: arguments);
  }
}
