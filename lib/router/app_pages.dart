/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-24 10:29:09
 * @FilePath: /SPFlutterPro/lib/router/app_pages.dart
 * @Description: 页面路由配置
 */

import 'package:common_flutter_network/common_flutter_network.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:common_widgets_utils/src/bottom_sheet/bottom_sheet_example.dart';
import 'package:common_widgets_utils/src/center_dialog/center_dialog_example.dart';

// 导入页面
import '../module/home/home_page.dart';
import '../module/category/category_page.dart';
import '../module/cart/cart_page.dart';
import '../module/message/message_page.dart';
import '../module/my/profile_page.dart';
import '../module/tabbar/bottom_tab_example.dart';

// 导入路由常量
import 'routes.dart';

/// 页面路由配置
class AppPages {
  // 私有构造函数，防止实例化
  AppPages._();

  /// 初始路由
  static const String initial = Routes.home;

  /// 获取所有页面路由
  static List<GetPage> get pages => [
        // 主页面
        GetPage(
          name: Routes.home,
          page: () => const HomePage(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 300),
        ),

        // Tab页面
        GetPage(
          name: Routes.category,
          page: () => const CategoryPage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: Routes.cart,
          page: () => const CartPage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: Routes.message,
          page: () => const MessagePage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: Routes.profile,
          page: () => const ProfilePage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),

        // 示例页面
        GetPage(
          name: Routes.bottomTabExample,
          page: () => const BottomTabExample(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: Routes.advancedBottomTabExample,
          page: () => const AdvancedBottomTabExample(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: Routes.bottomSheetExample,
          page: () => const BottomSheetExample(),
          transition: Transition.downToUp,
          transitionDuration: const Duration(milliseconds: 300),
        ),
        GetPage(
          name: Routes.centerDialogExample,
          page: () => const CenterDialogExample(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 300),
        ),

        // 颜色示例页面（临时页面）
        GetPage(
          name: Routes.colorExample,
          page: () => _buildColorExamplePage(),
          transition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 300),
        ),
      ];

  /// 构建颜色示例页面
  static Widget _buildColorExamplePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('颜色工具示例'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '主题颜色示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.primary,
              ),
            ),
            const SizedBox(height: 16),
            _buildColorItem('主色调', ColorManager.primary),
            _buildColorItem('成功色', ColorManager.success),
            _buildColorItem('警告色', ColorManager.warning),
            _buildColorItem('错误色', ColorManager.error),
            _buildColorItem('信息色', ColorManager.info),
            const SizedBox(height: 20),
            Text(
              '文本颜色示例',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.primary,
              ),
            ),
            const SizedBox(height: 16),
            _buildTextColorItem('主要文本', ColorManager.textPrimary),
            _buildTextColorItem('次要文本', ColorManager.textSecondary),
            _buildTextColorItem('禁用文本', ColorManager.textDisabled),
          ],
        ),
      ),
    );
  }

  /// 构建颜色项
  static Widget _buildColorItem(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建文本颜色项
  static Widget _buildTextColorItem(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Center(
              child: Text(
                'A',
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
