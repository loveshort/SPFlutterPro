/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-29 10:34:21
 * @FilePath: /SPFlutterPro/lib/Riverpod/pages/riverpod_example_page.dart
 * @Description: Riverpod示例入口页面 - 展示Riverpod功能特性
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';
import '../utils/color_manager.dart';
import 'product_list_page.dart';
import 'river_pod_cart_page.dart';

class RiverpodExamplePage extends ConsumerWidget {
  const RiverpodExamplePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statistics = ref.watch(statisticsProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);
    final cartTotal = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod 完美示例'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // 购物车按钮
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RiverpodCartPage()),
                  );
                },
              ),
              if (cartItemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: ColorManager.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$cartItemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 介绍卡片
            _buildIntroCard(),

            const SizedBox(height: 20),

            // 功能特性卡片
            _buildFeaturesCard(),

            const SizedBox(height: 20),

            // 示例演示卡片
            _buildDemoCard(context),

            const SizedBox(height: 20),

            // 技术架构卡片
            _buildArchitectureCard(),

            const SizedBox(height: 20),

            // 统计信息卡片
            _buildStatisticsCard(statistics, cartItemCount, cartTotal),

            const SizedBox(height: 20),

            // 开始体验按钮
            _buildStartButton(context),
          ],
        ),
      ),
    );
  }

  // 构建介绍卡片
  Widget _buildIntroCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              ColorManager.primary.withOpacity(0.1),
              ColorManager.primary.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.shopping_bag,
                  size: 32,
                  color: ColorManager.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Riverpod 完美示例',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              '这是一个完整的Riverpod状态管理示例，展示了Provider、StateNotifier、Consumer等核心功能。通过购物车应用，您可以学习到Riverpod的最佳实践。',
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.textSecondary,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 构建功能特性卡片
  Widget _buildFeaturesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '核心特性',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureItem(
              icon: Icons.speed,
              title: 'Provider状态管理',
              description: '使用Provider、StateNotifier实现响应式状态管理',
            ),
            _buildFeatureItem(
              icon: Icons.integration_instructions,
              title: '依赖注入',
              description: '通过Provider实现自动依赖注入和生命周期管理',
            ),
            _buildFeatureItem(
              icon: Icons.refresh,
              title: 'Consumer监听',
              description: 'Consumer自动监听Provider变化并重建UI',
            ),
            _buildFeatureItem(
              icon: Icons.sync,
              title: '异步处理',
              description: 'FutureProvider、AsyncValue处理异步数据',
            ),
            _buildFeatureItem(
              icon: Icons.build,
              title: '服务层架构',
              description: '分离业务逻辑和数据操作，代码更清晰',
            ),
          ],
        ),
      ),
    );
  }

  // 构建示例演示卡片
  Widget _buildDemoCard(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.play_circle,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '示例演示',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDemoItem(
              icon: Icons.list,
              title: '产品列表',
              description: '展示Provider、Consumer、搜索过滤功能',
              onTap: _navigateToProductList,
              context: context,
            ),
            _buildDemoItem(
              icon: Icons.shopping_cart,
              title: '购物车管理',
              description: '演示StateNotifier、状态更新、数量控制',
              onTap: _navigateToCart,
              context: context,
            ),
            _buildDemoItem(
              icon: Icons.info,
              title: '产品详情',
              description: '展示FutureProvider、异步数据加载',
              onTap: _navigateToProductList,
              context: context,
            ),
            _buildDemoItem(
              icon: Icons.analytics,
              title: '统计功能',
              description: '演示Provider组合、计算属性',
              onTap: _showStatistics,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  // 构建技术架构卡片
  Widget _buildArchitectureCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.architecture,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '技术架构',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildArchitectureItem(
              'Model层',
              'ProductModel - 数据模型定义',
              Icons.data_object,
            ),
            _buildArchitectureItem(
              'Service层',
              'ProductService - 业务逻辑处理',
              Icons.business,
            ),
            _buildArchitectureItem(
              'Provider层',
              'Providers - 状态管理和依赖注入',
              Icons.settings,
            ),
            _buildArchitectureItem(
              'View层',
              'Pages - UI界面展示',
              Icons.view_module,
            ),
          ],
        ),
      ),
    );
  }

  // 构建统计信息卡片
  Widget _buildStatisticsCard(
      Map<String, dynamic> statistics, int cartItemCount, double cartTotal) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.analytics,
                  color: ColorManager.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '实时统计',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '产品总数',
                    '${statistics['totalProducts']}',
                    Icons.inventory,
                    ColorManager.primary,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '购物车',
                    '$cartItemCount',
                    Icons.shopping_cart,
                    ColorManager.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    '购物车总额',
                    '¥${cartTotal.toStringAsFixed(2)}',
                    Icons.monetization_on,
                    ColorManager.warning,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    '平均评分',
                    '${statistics['averageRating'].toStringAsFixed(1)}',
                    Icons.star,
                    Colors.amber,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 构建开始体验按钮
  Widget _buildStartButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () => _navigateToProductList(context),
        icon: const Icon(Icons.play_arrow),
        label: const Text('开始体验 Riverpod 示例'),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // 构建功能项
  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: ColorManager.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建演示项
  Widget _buildDemoItem({
    required IconData icon,
    required String title,
    required String description,
    required Function(BuildContext) onTap,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () => onTap(context),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: ColorManager.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorManager.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: ColorManager.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // 构建架构项
  Widget _buildArchitectureItem(
      String title, String description, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: ColorManager.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 构建统计项
  Widget _buildStatItem(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: ColorManager.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 导航到产品列表
  void _navigateToProductList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductListPage()),
    );
  }

  // 导航到购物车
  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RiverpodCartPage()),
    );
  }

  // 显示统计信息
  void _showStatistics(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('统计信息'),
        content: const Text('这里可以显示更详细的统计信息'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }
}
