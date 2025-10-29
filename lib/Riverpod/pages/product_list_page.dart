/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-29 10:34:35
 * @FilePath: /SPFlutterPro/lib/Riverpod/pages/product_list_page.dart
 * @Description: 产品列表页面 - Riverpod状态管理
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/providers.dart';
import '../utils/color_manager.dart';
import 'product_detail_page.dart';
import 'river_pod_cart_page.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredProducts = ref.watch(filteredProductsProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('产品列表'),
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
          // 过滤器按钮
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          _buildSearchBar(ref),

          // 过滤器标签
          _buildFilterTags(ref),

          // 产品列表
          Expanded(
            child: filteredProducts.isEmpty
                ? _buildEmptyState(ref)
                : RefreshIndicator(
                    onRefresh: () async {
                      // 刷新产品数据
                      ref.invalidate(productsProvider);
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return _buildProductCard(context, ref, product);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // 构建搜索栏
  Widget _buildSearchBar(WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) {
          ref.read(searchQueryProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: '搜索产品...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorManager.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: ColorManager.primary, width: 2),
          ),
        ),
      ),
    );
  }

  // 构建过滤器标签
  Widget _buildFilterTags(WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final categoryFilter = ref.watch(categoryFilterProvider);
    final sortOption = ref.watch(sortOptionProvider);

    final hasFilters = searchQuery.isNotEmpty ||
        categoryFilter.isNotEmpty ||
        sortOption != SortOption.newest;

    if (!hasFilters) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        children: [
          if (searchQuery.isNotEmpty)
            Chip(
              label: Text('搜索: $searchQuery'),
              onDeleted: () {
                ref.read(searchQueryProvider.notifier).state = '';
              },
              deleteIcon: const Icon(Icons.close, size: 18),
            ),
          if (categoryFilter.isNotEmpty)
            Chip(
              label: Text('分类: $categoryFilter'),
              onDeleted: () {
                ref.read(categoryFilterProvider.notifier).state = '';
              },
              deleteIcon: const Icon(Icons.close, size: 18),
            ),
          if (sortOption != SortOption.newest)
            Chip(
              label: Text('排序: ${sortOption.label}'),
              onDeleted: () {
                ref.read(sortOptionProvider.notifier).state = SortOption.newest;
              },
              deleteIcon: const Icon(Icons.close, size: 18),
            ),
          Chip(
            label: const Text('清除所有'),
            onDeleted: () {
              ref.read(searchQueryProvider.notifier).state = '';
              ref.read(categoryFilterProvider.notifier).state = '';
              ref.read(sortOptionProvider.notifier).state = SortOption.newest;
            },
            backgroundColor: ColorManager.error.withOpacity(0.1),
            deleteIcon:
                Icon(Icons.clear_all, size: 18, color: ColorManager.error),
          ),
        ],
      ),
    );
  }

  // 构建空状态
  Widget _buildEmptyState(WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: ColorManager.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            searchQuery.isNotEmpty ? '没有找到匹配的产品' : '暂无产品',
            style: TextStyle(
              fontSize: 18,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            searchQuery.isNotEmpty ? '尝试调整搜索条件' : '请稍后再试',
            style: TextStyle(
              fontSize: 14,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // 构建产品卡片
  Widget _buildProductCard(
      BuildContext context, WidgetRef ref, ProductModel product) {
    final cartNotifier = ref.read(cartProvider.notifier);
    final isInCart = cartNotifier.isInCart(product.id);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(productId: product.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 产品图片
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Container(
                      width: double.infinity,
                      color: ColorManager.border,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.image,
                            size: 40,
                            color: ColorManager.textSecondary,
                          );
                        },
                      ),
                    ),
                  ),

                  // 特价标签
                  if (product.isOnSale)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: ColorManager.error,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '特价',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  // 评分标签
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            product.rating.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 产品信息
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 产品名称
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // 产品价格
                    Row(
                      children: [
                        Text(
                          '¥${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary,
                          ),
                        ),
                        if (product.isOnSale &&
                            product.originalPrice != null) ...[
                          const SizedBox(width: 4),
                          Text(
                            '¥${product.originalPrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorManager.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),

                    // 添加到购物车按钮
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          cartNotifier.addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('已添加"${product.name}"到购物车'),
                              backgroundColor: ColorManager.success,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: Icon(
                          isInCart ? Icons.check : Icons.add_shopping_cart,
                          size: 16,
                        ),
                        label: Text(
                          isInCart ? '已添加' : '加入购物车',
                          style: const TextStyle(fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInCart
                              ? ColorManager.success
                              : ColorManager.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 显示过滤器底部弹窗
  void _showFilterBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '过滤器',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 20),

            // 分类过滤
            Text(
              '分类',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Consumer(
              builder: (context, ref, child) {
                final categoryFilter = ref.watch(categoryFilterProvider);
                return Wrap(
                  spacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('全部'),
                      selected: categoryFilter.isEmpty,
                      onSelected: (selected) {
                        ref.read(categoryFilterProvider.notifier).state = '';
                      },
                    ),
                    ...ProductCategory.values.map((category) => FilterChip(
                          label: Text(category.label),
                          selected: categoryFilter == category.label,
                          onSelected: (selected) {
                            ref.read(categoryFilterProvider.notifier).state =
                                selected ? category.label : '';
                          },
                        )),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            // 排序选项
            Text(
              '排序',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Consumer(
              builder: (context, ref, child) {
                final sortOption = ref.watch(sortOptionProvider);
                return Wrap(
                  spacing: 8,
                  children: SortOption.values
                      .map((option) => FilterChip(
                            label: Text(option.label),
                            selected: sortOption == option,
                            onSelected: (selected) {
                              ref.read(sortOptionProvider.notifier).state =
                                  option;
                            },
                          ))
                      .toList(),
                );
              },
            ),

            const SizedBox(height: 20),

            // 操作按钮
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref.read(searchQueryProvider.notifier).state = '';
                      ref.read(categoryFilterProvider.notifier).state = '';
                      ref.read(sortOptionProvider.notifier).state =
                          SortOption.newest;
                    },
                    child: const Text('清除所有'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('确定'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
