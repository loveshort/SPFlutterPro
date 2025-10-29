/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-29 10:34:55
 * @FilePath: /SPFlutterPro/lib/Riverpod/pages/product_detail_page.dart
 * @Description: 产品详情页面 - Riverpod状态管理
 */

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../providers/providers.dart';
import '../utils/color_manager.dart';
import 'river_pod_cart_page.dart';

class ProductDetailPage extends ConsumerWidget {
  final String productId;

  const ProductDetailPage({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailProvider(productId));
    final cartNotifier = ref.read(cartProvider.notifier);
    final isInCart = cartNotifier.isInCart(productId);
    final cartQuantity = cartNotifier.getQuantity(productId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('产品详情'),
        backgroundColor: ColorManager.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
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
        ],
      ),
      body: productAsync.when(
        data: (product) {
          if (product == null) {
            return _buildNotFound();
          }
          return _buildProductDetail(
              context, ref, product, isInCart, cartQuantity);
        },
        loading: () => _buildLoading(),
        error: (error, stackTrace) => _buildError(error.toString()),
      ),
    );
  }

  // 构建产品详情
  Widget _buildProductDetail(
    BuildContext context,
    WidgetRef ref,
    ProductModel product,
    bool isInCart,
    int cartQuantity,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 产品图片
          _buildProductImage(product),

          // 产品信息
          _buildProductInfo(context, ref, product, isInCart, cartQuantity),

          // 产品描述
          _buildProductDescription(product),

          // 产品规格
          _buildProductSpecs(product),

          // 用户评价
          _buildProductReviews(product),

          // 推荐产品
          _buildRecommendedProducts(ref),
        ],
      ),
    );
  }

  // 构建产品图片
  Widget _buildProductImage(ProductModel product) {
    return Container(
      height: 300,
      width: double.infinity,
      color: ColorManager.border,
      child: Stack(
        children: [
          Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(
                  Icons.image,
                  size: 80,
                  color: ColorManager.textSecondary,
                ),
              );
            },
          ),

          // 特价标签
          if (product.isOnSale)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorManager.error,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '特价',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // 评分标签
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${product.rating} (${product.reviewCount})',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建产品信息
  Widget _buildProductInfo(
    BuildContext context,
    WidgetRef ref,
    ProductModel product,
    bool isInCart,
    int cartQuantity,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 产品名称
          Text(
            product.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 8),

          // 产品分类
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: ColorManager.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              product.category,
              style: TextStyle(
                fontSize: 12,
                color: ColorManager.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // 价格信息
          Row(
            children: [
              Text(
                '¥${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.primary,
                ),
              ),
              if (product.isOnSale && product.originalPrice != null) ...[
                const SizedBox(width: 12),
                Text(
                  '¥${product.originalPrice!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorManager.textSecondary,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: ColorManager.error,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '省¥${(product.originalPrice! - product.price).toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),

          // 库存信息
          Row(
            children: [
              Icon(
                Icons.inventory,
                size: 16,
                color: product.stock > 0
                    ? ColorManager.success
                    : ColorManager.error,
              ),
              const SizedBox(width: 4),
              Text(
                product.stock > 0 ? '库存充足 (${product.stock}件)' : '库存不足',
                style: TextStyle(
                  fontSize: 14,
                  color: product.stock > 0
                      ? ColorManager.success
                      : ColorManager.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 操作按钮
          Row(
            children: [
              // 数量控制
              if (isInCart) ...[
                _buildQuantityControl(ref, product, cartQuantity),
                const SizedBox(width: 16),
              ],

              // 添加到购物车按钮
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: product.stock > 0
                      ? () {
                          ref.read(cartProvider.notifier).addToCart(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('已添加"${product.name}"到购物车'),
                              backgroundColor: ColorManager.success,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      : null,
                  icon: Icon(
                    isInCart ? Icons.check : Icons.add_shopping_cart,
                    size: 20,
                  ),
                  label: Text(
                    isInCart ? '已添加' : '加入购物车',
                    style: const TextStyle(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isInCart ? ColorManager.success : ColorManager.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 构建数量控制
  Widget _buildQuantityControl(
      WidgetRef ref, ProductModel product, int quantity) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // 减少按钮
          InkWell(
            onTap: () {
              if (quantity > 1) {
                ref
                    .read(cartProvider.notifier)
                    .updateQuantity(product.id, quantity - 1);
              } else {
                ref.read(cartProvider.notifier).removeFromCart(product.id);
              }
            },
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(8)),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(color: ColorManager.border),
                ),
              ),
              child: Icon(
                Icons.remove,
                color: ColorManager.textSecondary,
              ),
            ),
          ),

          // 数量显示
          Container(
            width: 60,
            height: 40,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: ColorManager.border),
              ),
            ),
            child: Center(
              child: Text(
                '$quantity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.textPrimary,
                ),
              ),
            ),
          ),

          // 增加按钮
          InkWell(
            onTap: () {
              if (quantity < product.stock) {
                ref
                    .read(cartProvider.notifier)
                    .updateQuantity(product.id, quantity + 1);
              } else {
                ScaffoldMessenger.of(ref.context).showSnackBar(
                  SnackBar(
                    content: Text('库存不足，最多只能购买 ${product.stock} 件'),
                    backgroundColor: ColorManager.warning,
                  ),
                );
              }
            },
            borderRadius:
                const BorderRadius.horizontal(right: Radius.circular(8)),
            child: Container(
              width: 40,
              height: 40,
              child: Icon(
                Icons.add,
                color: ColorManager.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 构建产品描述
  Widget _buildProductDescription(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '产品描述',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 16,
              color: ColorManager.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // 产品标签
          if (product.tags.isNotEmpty) ...[
            Text(
              '产品标签',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: product.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        backgroundColor: ColorManager.primary.withOpacity(0.1),
                        labelStyle: TextStyle(color: ColorManager.primary),
                      ))
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }

  // 构建产品规格
  Widget _buildProductSpecs(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '产品规格',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildSpecItem('产品ID', product.id),
          _buildSpecItem('分类', product.category),
          _buildSpecItem('评分', '${product.rating} 分'),
          _buildSpecItem('评价数量', '${product.reviewCount} 条'),
          _buildSpecItem('库存', '${product.stock} 件'),
          _buildSpecItem('特价', product.isOnSale ? '是' : '否'),
        ],
      ),
    );
  }

  // 构建规格项
  Widget _buildSpecItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: ColorManager.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: ColorManager.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // 构建用户评价
  Widget _buildProductReviews(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '用户评价',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 12),

          // 评分统计
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                '${product.rating}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '(${product.reviewCount} 条评价)',
                style: TextStyle(
                  fontSize: 14,
                  color: ColorManager.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 模拟评价列表
          _buildReviewItem('用户1', '产品质量很好，推荐购买！', 5),
          _buildReviewItem('用户2', '性价比很高，值得购买。', 4),
          _buildReviewItem('用户3', '包装精美，物流很快。', 5),
        ],
      ),
    );
  }

  // 构建评价项
  Widget _buildReviewItem(String userName, String content, int rating) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              ...List.generate(
                  5,
                  (index) => Icon(
                        index < rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 16,
                      )),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // 构建推荐产品
  Widget _buildRecommendedProducts(WidgetRef ref) {
    final recommendedProducts = ref.watch(recommendedProductsProvider);

    if (recommendedProducts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '推荐产品',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendedProducts.length,
              itemBuilder: (context, index) {
                final product = recommendedProducts[index];
                return Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 12),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailPage(productId: product.id),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8)),
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
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
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.textPrimary,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '¥${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 构建加载状态
  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  // 构建错误状态
  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: ColorManager.error,
          ),
          const SizedBox(height: 16),
          Text(
            '加载失败',
            style: TextStyle(
              fontSize: 18,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(
              fontSize: 14,
              color: ColorManager.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 构建未找到状态
  Widget _buildNotFound() {
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
            '产品不存在',
            style: TextStyle(
              fontSize: 18,
              color: ColorManager.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '请检查产品ID是否正确',
            style: TextStyle(
              fontSize: 14,
              color: ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
