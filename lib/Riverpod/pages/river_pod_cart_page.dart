/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-29 10:33:45
 * @FilePath: /SPFlutterPro/lib/Riverpod/pages/cart_page.dart
 * @Description: 购物车页面 - Riverpod状态管理
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/providers.dart';
import '../utils/color_manager.dart';
import 'product_detail_page.dart';

class RiverpodCartPage extends ConsumerWidget {
  const RiverpodCartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartTotal = ref.watch(cartTotalProvider);
    final cartItemCount = ref.watch(cartItemCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('购物车'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () => _showClearCartDialog(context, ref),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                // 购物车统计
                _buildCartSummary(cartItemCount, cartTotal),

                // 购物车列表
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return _buildCartItem(context, ref, item);
                    },
                  ),
                ),

                // 底部操作栏
                _buildBottomBar(context, ref, cartTotal),
              ],
            ),
    );
  }

  // 构建空购物车
  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: ColorManager.textSecondary,
          ),
          const SizedBox(height: 20),
          Text(
            '购物车是空的',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '快去添加一些商品吧！',
            style: TextStyle(
              fontSize: 16,
              color: ColorManager.textSecondary,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              // 导航到产品列表页面
              Navigator.pop(context);
            },
            icon: const Icon(Icons.shopping_bag),
            label: const Text('去购物'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // 构建购物车统计
  Widget _buildCartSummary(int itemCount, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.primary.withOpacity(0.1),
        border: Border(
          bottom: BorderSide(color: ColorManager.border),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '共 $itemCount 件商品',
                style: TextStyle(
                  fontSize: 16,
                  color: ColorManager.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '合计: ¥${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
          Icon(
            Icons.shopping_cart,
            size: 32,
            color: ColorManager.primary,
          ),
        ],
      ),
    );
  }

  // 构建购物车项目
  Widget _buildCartItem(BuildContext context, WidgetRef ref, CartItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailPage(productId: item.product.id),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // 产品图片
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: ColorManager.border,
                  child: Image.network(
                    item.product.imageUrl,
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

              const SizedBox(width: 12),

              // 产品信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 产品名称
                    Text(
                      item.product.name,
                      style: TextStyle(
                        fontSize: 16,
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
                          '¥${item.product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorManager.primary,
                          ),
                        ),
                        if (item.product.isOnSale &&
                            item.product.originalPrice != null) ...[
                          const SizedBox(width: 8),
                          Text(
                            '¥${item.product.originalPrice!.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: ColorManager.textSecondary,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),

                    // 数量控制
                    Row(
                      children: [
                        Text(
                          '数量: ',
                          style: TextStyle(
                            fontSize: 14,
                            color: ColorManager.textSecondary,
                          ),
                        ),
                        _buildQuantityControl(ref, item),
                      ],
                    ),
                  ],
                ),
              ),

              // 小计和删除按钮
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '¥${item.subtotal.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  IconButton(
                    onPressed: () => _showRemoveItemDialog(context, ref, item),
                    icon: Icon(
                      Icons.delete_outline,
                      color: ColorManager.error,
                    ),
                    tooltip: '删除',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 构建数量控制
  Widget _buildQuantityControl(WidgetRef ref, CartItem item) {
    return Row(
      children: [
        // 减少按钮
        InkWell(
          onTap: () {
            if (item.quantity > 1) {
              ref
                  .read(cartProvider.notifier)
                  .updateQuantity(item.product.id, item.quantity - 1);
            } else {
              ref.read(cartProvider.notifier).removeFromCart(item.product.id);
            }
          },
          borderRadius: BorderRadius.circular(4),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.border),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.remove,
              size: 16,
              color: ColorManager.textSecondary,
            ),
          ),
        ),

        // 数量显示
        Container(
          width: 50,
          height: 32,
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.border),
          ),
          child: Center(
            child: Text(
              '${item.quantity}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
        ),

        // 增加按钮
        InkWell(
          onTap: () {
            if (item.quantity < item.product.stock) {
              ref
                  .read(cartProvider.notifier)
                  .updateQuantity(item.product.id, item.quantity + 1);
            } else {
              ScaffoldMessenger.of(ref.context).showSnackBar(
                SnackBar(
                  content: Text('库存不足，最多只能购买 ${item.product.stock} 件'),
                  backgroundColor: ColorManager.warning,
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(4),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(color: ColorManager.border),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(
              Icons.add,
              size: 16,
              color: ColorManager.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  // 构建底部操作栏
  Widget _buildBottomBar(BuildContext context, WidgetRef ref, double total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: ColorManager.border),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // 全选和总价
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '合计',
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorManager.textSecondary,
                  ),
                ),
                Text(
                  '¥${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.primary,
                  ),
                ),
              ],
            ),
          ),

          // 结算按钮
          ElevatedButton(
            onPressed: () => _showCheckoutDialog(context, ref, total),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '结算',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 显示删除商品确认对话框
  void _showRemoveItemDialog(
      BuildContext context, WidgetRef ref, CartItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认删除'),
        content: Text('确定要从购物车中删除"${item.product.name}"吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(cartProvider.notifier).removeFromCart(item.product.id);
            },
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

  // 显示清空购物车确认对话框
  void _showClearCartDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('确认清空'),
        content: const Text('确定要清空购物车吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(cartProvider.notifier).clearCart();
            },
            style: TextButton.styleFrom(foregroundColor: ColorManager.error),
            child: const Text('清空'),
          ),
        ],
      ),
    );
  }

  // 显示结算对话框
  void _showCheckoutDialog(BuildContext context, WidgetRef ref, double total) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('结算'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('订单总金额: ¥${total.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            const Text('感谢您的购买！'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(cartProvider.notifier).clearCart();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('订单提交成功！'),
                  backgroundColor: ColorManager.success,
                ),
              );
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }
}
