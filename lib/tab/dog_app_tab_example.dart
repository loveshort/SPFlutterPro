/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: Dog APP 底部导航栏示例页面
 */
import 'package:flutter/material.dart';
import 'dog_app_bottom_nav_bar.dart';

/// Dog APP 底部导航栏示例
class DogAppTabExample extends StatelessWidget {
  const DogAppTabExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DogAppTabScaffold(
      items: [
        DogAppNavItem(
          title: 'Money',
          unselectedIcon: Icons.account_balance_wallet_outlined,
          selectedIcon: Icons.account_balance_wallet,
          page: _MoneyPage(),
        ),
        DogAppNavItem(
          title: 'Hub',
          unselectedIcon: Icons.credit_card_outlined,
          selectedIcon: Icons.credit_card,
          page: _HubPage(),
        ),
        DogAppNavItem(
          title: 'Earn',
          unselectedIcon: Icons.card_giftcard_outlined,
          selectedIcon: Icons.card_giftcard,
          page: _EarnPage(),
        ),
        DogAppNavItem(
          title: 'Profile',
          unselectedIcon: Icons.person_outline,
          selectedIcon: Icons.person,
          page: _ProfilePage(),
        ),
      ],
      initialIndex: 0,
      keepAlive: true,
    );
  }
}

/// Money 页面
class _MoneyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_balance_wallet,
              size: 64,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              'Money',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '钱包页面',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Hub 页面
class _HubPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.credit_card,
              size: 64,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              'Hub',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '金融中心页面',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Earn 页面
class _EarnPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.card_giftcard,
              size: 64,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              'Earn',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '收益页面',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Profile 页面
class _ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 64,
              color: Colors.white,
            ),
            const SizedBox(height: 16),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '个人中心页面',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
