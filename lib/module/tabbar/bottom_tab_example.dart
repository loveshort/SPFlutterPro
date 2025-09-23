/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: 底部Tab使用示例
 */
import 'package:flutter/material.dart';
import 'package:common_widgets_utils/common_widgets_utils.dart';

import '../cart/cart_page.dart';
import '../category/category_page.dart';
import '../home/home_page.dart';
import '../message/message_page.dart';
import '../my/profile_page.dart';

/// 底部Tab使用示例页面
class BottomTabExample extends StatelessWidget {
  const BottomTabExample({super.key});

  @override
  Widget build(BuildContext context) {
    // 定义Tab项列表
    final List<TabItem> tabs = [
      TabItem(
        title: '首页',
        unselectedIcon: Icons.home_outlined,
        selectedIcon: Icons.home,
        unselectedIconColor: Colors.grey.shade600,
        selectedIconColor: Colors.blue,
        unselectedTextColor: Colors.grey.shade600,
        selectedTextColor: Colors.blue,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        iconSize: 24.0,
        page: HomePage(),
      ),
      TabItem(
        title: '分类',
        unselectedIcon: Icons.category_outlined,
        selectedIcon: Icons.category,
        unselectedIconColor: Colors.grey.shade600,
        selectedIconColor: Colors.green,
        unselectedTextColor: Colors.grey.shade600,
        selectedTextColor: Colors.green,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        iconSize: 24.0,
        page: CategoryPage(),
      ),
      TabItem(
        title: '购物车',
        unselectedIcon: Icons.shopping_cart_outlined,
        selectedIcon: Icons.shopping_cart,
        unselectedIconColor: Colors.grey.shade600,
        selectedIconColor: Colors.orange,
        unselectedTextColor: Colors.grey.shade600,
        selectedTextColor: Colors.orange,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        iconSize: 24.0,
        page: CartPage(),
        showBadge: true,
        badgeText: '3',
        badgeColor: Colors.red,
      ),
      TabItem(
        title: '消息',
        unselectedIcon: Icons.message_outlined,
        selectedIcon: Icons.message,
        unselectedIconColor: Colors.grey.shade600,
        selectedIconColor: Colors.red,
        unselectedTextColor: Colors.grey.shade600,
        selectedTextColor: Colors.red,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        iconSize: 24.0,
        page: MessagePage(),
        showBadge: true,
        badgeText: '99+',
        badgeColor: Colors.red,
      ),
      TabItem(
        title: '我的',
        unselectedIcon: Icons.person_outline,
        selectedIcon: Icons.person,
        unselectedIconColor: Colors.grey.shade600,
        selectedIconColor: Colors.purple,
        unselectedTextColor: Colors.grey.shade600,
        selectedTextColor: Colors.purple,
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        iconSize: 24.0,
        page: ProfilePage(),
      ),
    ];

    return TabPageContainer(
      tabs: tabs,
      initialIndex: 0,
      keepAlive: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        tabs: tabs,
        backgroundColor: Colors.white,
        height: 70.0,
        showTopBorder: true,
        topBorderColor: Colors.grey.shade300,
        topBorderWidth: 0.5,
        itemSpacing: 4.0,
        enableAnimation: true,
        animationDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}

/// 高级自定义底部Tab示例
class AdvancedBottomTabExample extends StatelessWidget {
  const AdvancedBottomTabExample({super.key});

  @override
  Widget build(BuildContext context) {
    // 定义高级自定义Tab项列表
    final List<TabItem> tabs = [
      TabItem(
        title: '首页',
        unselectedIcon: Icons.home_outlined,
        selectedIcon: Icons.home,
        unselectedIconColor: Colors.grey.shade500,
        selectedIconColor: Colors.deepPurple,
        unselectedTextColor: Colors.grey.shade500,
        selectedTextColor: Colors.deepPurple,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        iconSize: 28.0,
        page: HomePage(),
      ),
      TabItem(
        title: '分类',
        unselectedIcon: Icons.category_outlined,
        selectedIcon: Icons.category,
        unselectedIconColor: Colors.grey.shade500,
        selectedIconColor: Colors.teal,
        unselectedTextColor: Colors.grey.shade500,
        selectedTextColor: Colors.teal,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        iconSize: 28.0,
        page: CategoryPage(),
      ),
      TabItem(
        title: '购物车',
        unselectedIcon: Icons.shopping_cart_outlined,
        selectedIcon: Icons.shopping_cart,
        unselectedIconColor: Colors.grey.shade500,
        selectedIconColor: Colors.amber,
        unselectedTextColor: Colors.grey.shade500,
        selectedTextColor: Colors.amber,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        iconSize: 28.0,
        page: CartPage(),
        showBadge: true,
        badgeText: '5',
        badgeColor: Colors.deepOrange,
      ),
      TabItem(
        title: '我的',
        unselectedIcon: Icons.person_outline,
        selectedIcon: Icons.person,
        unselectedIconColor: Colors.grey.shade500,
        selectedIconColor: Colors.indigo,
        unselectedTextColor: Colors.grey.shade500,
        selectedTextColor: Colors.indigo,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        iconSize: 28.0,
        page: ProfilePage(),
      ),
    ];

    return TabPageContainer(
      tabs: tabs,
      initialIndex: 0,
      keepAlive: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        tabs: tabs,
        backgroundColor: Colors.grey.shade50,
        height: 80.0,
        showTopBorder: true,
        topBorderColor: Colors.grey.shade200,
        topBorderWidth: 1.0,
        itemSpacing: 8.0,
        enableAnimation: true,
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
