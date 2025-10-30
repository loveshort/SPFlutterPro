/*
 * @作者: 顾明次
 * @Date: 2025-10-30
 * @Email: gu271901088@gmail.com
 * @描述: Tab封装使用示例
 */
import 'package:flutter/material.dart';
import 'tab.dart';
import '../module/cart/cart_page.dart';
import '../module/category/category_page.dart';
import '../module/home/home_page.dart';
import '../module/message/message_page.dart';
import '../module/my/profile_page.dart';

/// 基础Tab示例
class BasicTabExample extends StatelessWidget {
  const BasicTabExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TabScaffold(
      tabs: [
        TabConfig(
          title: '首页',
          unselectedIcon: Icons.home_outlined,
          selectedIcon: Icons.home,
          selectedIconColor: Colors.blue,
          selectedTextColor: Colors.blue,
          page: const HomePage(),
        ),
        TabConfig(
          title: '分类',
          unselectedIcon: Icons.category_outlined,
          selectedIcon: Icons.category,
          selectedIconColor: Colors.green,
          selectedTextColor: Colors.green,
          page: const CategoryPage(),
        ),
        TabConfig(
          title: '我的',
          unselectedIcon: Icons.person_outline,
          selectedIcon: Icons.person,
          selectedIconColor: Colors.purple,
          selectedTextColor: Colors.purple,
          page: const ProfilePage(),
        ),
      ],
    );
  }
}

/// 高级Tab示例（带徽章、自定义样式）
class AdvancedTabExample extends StatelessWidget {
  const AdvancedTabExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TabScaffold(
      tabs: [
        TabConfig(
          title: '首页',
          unselectedIcon: Icons.home_outlined,
          selectedIcon: Icons.home,
          unselectedIconColor: Colors.grey.shade600,
          selectedIconColor: Colors.blue,
          unselectedTextColor: Colors.grey.shade600,
          selectedTextColor: Colors.blue,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          iconSize: 26.0,
          page: const HomePage(),
        ),
        TabConfig(
          title: '分类',
          unselectedIcon: Icons.category_outlined,
          selectedIcon: Icons.category,
          unselectedIconColor: Colors.grey.shade600,
          selectedIconColor: Colors.green,
          unselectedTextColor: Colors.grey.shade600,
          selectedTextColor: Colors.green,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          iconSize: 26.0,
          page: const CategoryPage(),
        ),
        TabConfig(
          title: '购物车',
          unselectedIcon: Icons.shopping_cart_outlined,
          selectedIcon: Icons.shopping_cart,
          unselectedIconColor: Colors.grey.shade600,
          selectedIconColor: Colors.orange,
          unselectedTextColor: Colors.grey.shade600,
          selectedTextColor: Colors.orange,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          iconSize: 26.0,
          page: const CartPage(),
          showBadge: true,
          badgeText: '3',
          badgeColor: Colors.red,
        ),
        TabConfig(
          title: '消息',
          unselectedIcon: Icons.message_outlined,
          selectedIcon: Icons.message,
          unselectedIconColor: Colors.grey.shade600,
          selectedIconColor: Colors.red,
          unselectedTextColor: Colors.grey.shade600,
          selectedTextColor: Colors.red,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          iconSize: 26.0,
          page: const MessagePage(),
          showBadge: true,
          badgeText: '99+',
          badgeColor: Colors.red,
        ),
        TabConfig(
          title: '我的',
          unselectedIcon: Icons.person_outline,
          selectedIcon: Icons.person,
          unselectedIconColor: Colors.grey.shade600,
          selectedIconColor: Colors.purple,
          unselectedTextColor: Colors.grey.shade600,
          selectedTextColor: Colors.purple,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          iconSize: 26.0,
          page: const ProfilePage(),
        ),
      ],
      initialIndex: 0,
      keepAlive: true,
      barStyle: BottomTabBarStyle(
        backgroundColor: Colors.white,
        height: 70.0,
        showTopBorder: true,
        topBorderColor: Colors.grey.shade300,
        topBorderWidth: 0.5,
        itemSpacing: 4.0,
        enableAnimation: true,
        animationDuration: const Duration(milliseconds: 200),
        enableRipple: true,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      onIndexChanged: (index) {
        debugPrint('Tab切换到: $index');
      },
    );
  }
}

/// 自定义控制器示例
class CustomControllerTabExample extends StatefulWidget {
  const CustomControllerTabExample({super.key});

  @override
  State<CustomControllerTabExample> createState() =>
      _CustomControllerTabExampleState();
}

class _CustomControllerTabExampleState
    extends State<CustomControllerTabExample> {
  late CustomTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CustomTabController(
      length: 3,
      initialIndex: 0,
      onIndexChanged: (index) {
        debugPrint('Tab切换到: $index');
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义控制器示例'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _controller.previousTab(),
            tooltip: '上一个',
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => _controller.nextTab(),
            tooltip: '下一个',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _controller.jumpToIndex(0),
                  child: const Text('跳转到首页'),
                ),
                ElevatedButton(
                  onPressed: () => _controller.jumpToIndex(1),
                  child: const Text('跳转到分类'),
                ),
                ElevatedButton(
                  onPressed: () => _controller.jumpToIndex(2),
                  child: const Text('跳转到我的'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabPageView(
              controller: _controller,
              tabs: const [
                TabConfig(
                  title: '首页',
                  unselectedIcon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  page: HomePage(),
                ),
                TabConfig(
                  title: '分类',
                  unselectedIcon: Icons.category_outlined,
                  selectedIcon: Icons.category,
                  page: CategoryPage(),
                ),
                TabConfig(
                  title: '我的',
                  unselectedIcon: Icons.person_outline,
                  selectedIcon: Icons.person,
                  page: ProfilePage(),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomTabBar(
        controller: _controller,
        tabs: const [
          TabConfig(
            title: '首页',
            unselectedIcon: Icons.home_outlined,
            selectedIcon: Icons.home,
            selectedIconColor: Colors.blue,
            selectedTextColor: Colors.blue,
            page: HomePage(),
          ),
          TabConfig(
            title: '分类',
            unselectedIcon: Icons.category_outlined,
            selectedIcon: Icons.category,
            selectedIconColor: Colors.green,
            selectedTextColor: Colors.green,
            page: CategoryPage(),
          ),
          TabConfig(
            title: '我的',
            unselectedIcon: Icons.person_outline,
            selectedIcon: Icons.person,
            selectedIconColor: Colors.purple,
            selectedTextColor: Colors.purple,
            page: ProfilePage(),
          ),
        ],
      ),
    );
  }
}
