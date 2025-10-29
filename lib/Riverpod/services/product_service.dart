/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/Riverpod/services/product_service.dart
 * @Description: 产品服务层 - 处理数据操作
 */

import 'package:common_flutter_network/common_flutter_network.dart';
import '../models/product_model.dart';

class ProductService {
  // 模拟本地存储
  final List<ProductModel> _products = <ProductModel>[];
  final List<CartItem> _cartItems = <CartItem>[];

  // 获取所有产品
  List<ProductModel> get products => List.unmodifiable(_products);

  // 获取购物车项目
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  // 获取购物车总数量
  int get cartItemCount =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  // 获取购物车总金额
  double get cartTotal =>
      _cartItems.fold(0.0, (sum, item) => sum + item.subtotal);

  // 按分类获取产品
  List<ProductModel> getProductsByCategory(String category) =>
      _products.where((product) => product.category == category).toList();

  // 搜索产品
  List<ProductModel> searchProducts(String query) {
    if (query.isEmpty) return _products;

    return _products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase()) ||
            product.tags
                .any((tag) => tag.toLowerCase().contains(query.toLowerCase())))
        .toList();
  }

  // 排序产品
  List<ProductModel> sortProducts(
      List<ProductModel> products, SortOption sortOption) {
    switch (sortOption) {
      case SortOption.priceLowToHigh:
        return List.from(products)..sort((a, b) => a.price.compareTo(b.price));
      case SortOption.priceHighToLow:
        return List.from(products)..sort((a, b) => b.price.compareTo(a.price));
      case SortOption.rating:
        return List.from(products)
          ..sort((a, b) => b.rating.compareTo(a.rating));
      case SortOption.newest:
        return List.from(products)..sort((a, b) => b.id.compareTo(a.id));
      case SortOption.popularity:
        return List.from(products)
          ..sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
    }
  }

  // 添加产品到购物车
  Future<bool> addToCart(ProductModel product, {int quantity = 1}) async {
    try {
      // 模拟网络延迟
      await Future.delayed(const Duration(milliseconds: 300));

      final existingIndex =
          _cartItems.indexWhere((item) => item.product.id == product.id);

      if (existingIndex != -1) {
        // 更新数量
        _cartItems[existingIndex] = _cartItems[existingIndex].copyWith(
          quantity: _cartItems[existingIndex].quantity + quantity,
        );
      } else {
        // 添加新项目
        _cartItems.add(CartItem(product: product, quantity: quantity));
      }

      LogUtils.i('添加产品到购物车: ${product.name} x$quantity');
      return true;
    } catch (e) {
      LogUtils.e('添加产品到购物车失败: $e');
      return false;
    }
  }

  // 从购物车移除产品
  Future<bool> removeFromCart(String productId) async {
    try {
      _cartItems.removeWhere((item) => item.product.id == productId);
      LogUtils.i('从购物车移除产品: $productId');
      return true;
    } catch (e) {
      LogUtils.e('从购物车移除产品失败: $e');
      return false;
    }
  }

  // 更新购物车项目数量
  Future<bool> updateCartItemQuantity(String productId, int quantity) async {
    try {
      if (quantity <= 0) {
        return await removeFromCart(productId);
      }

      final index =
          _cartItems.indexWhere((item) => item.product.id == productId);
      if (index != -1) {
        _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
        LogUtils.i('更新购物车项目数量: $productId -> $quantity');
        return true;
      }
      return false;
    } catch (e) {
      LogUtils.e('更新购物车项目数量失败: $e');
      return false;
    }
  }

  // 清空购物车
  Future<bool> clearCart() async {
    try {
      _cartItems.clear();
      LogUtils.i('清空购物车');
      return true;
    } catch (e) {
      LogUtils.e('清空购物车失败: $e');
      return false;
    }
  }

  // 检查产品是否在购物车中
  bool isInCart(String productId) {
    return _cartItems.any((item) => item.product.id == productId);
  }

  // 获取购物车中产品的数量
  int getCartItemQuantity(String productId) {
    final item = _cartItems.firstWhere(
      (item) => item.product.id == productId,
      orElse: () => CartItem(
          product: ProductModel(
            id: '',
            name: '',
            description: '',
            price: 0,
            imageUrl: '',
            category: '',
            stock: 0,
            rating: 0,
            reviewCount: 0,
            tags: [],
          ),
          quantity: 0),
    );
    return item.quantity;
  }

  // 获取产品详情
  ProductModel? getProductById(String id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      LogUtils.e('获取产品详情失败: $e');
      return null;
    }
  }

  // 获取推荐产品
  List<ProductModel> getRecommendedProducts(String category, {int limit = 5}) {
    return _products
        .where((product) => product.category == category)
        .where((product) => product.rating >= 4.0)
        .take(limit)
        .toList();
  }

  // 获取热门产品
  List<ProductModel> getPopularProducts({int limit = 10}) {
    return _products.where((product) => product.reviewCount > 100).toList()
      ..sort((a, b) => b.reviewCount.compareTo(a.reviewCount))
      ..take(limit);
  }

  // 获取特价产品
  List<ProductModel> getSaleProducts() {
    return _products.where((product) => product.isOnSale).toList();
  }

  // 获取统计信息
  Map<String, dynamic> getStatistics() {
    return {
      'totalProducts': _products.length,
      'totalCartItems': cartItemCount,
      'cartTotal': cartTotal,
      'categories': ProductCategory.values.map((e) => e.label).toList(),
      'averageRating': _products.isNotEmpty
          ? _products.map((p) => p.rating).reduce((a, b) => a + b) /
              _products.length
          : 0.0,
    };
  }

  // 初始化示例数据
  Future<void> initializeSampleData() async {
    if (_products.isNotEmpty) return;

    final sampleProducts = [
      ProductModel(
        id: '1',
        name: 'iPhone 15 Pro',
        description: '最新款iPhone，搭载A17 Pro芯片，钛金属设计',
        price: 7999.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=iPhone+15+Pro',
        category: '电子产品',
        stock: 50,
        rating: 4.8,
        reviewCount: 1250,
        tags: ['手机', '苹果', '5G', '摄影'],
        isOnSale: false,
      ),
      ProductModel(
        id: '2',
        name: 'MacBook Pro 14"',
        description: 'M3 Pro芯片，14英寸Liquid Retina XDR显示屏',
        price: 15999.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=MacBook+Pro',
        category: '电子产品',
        stock: 30,
        rating: 4.9,
        reviewCount: 890,
        tags: ['笔记本', '苹果', 'M3', '专业'],
        isOnSale: true,
        originalPrice: 17999.0,
      ),
      ProductModel(
        id: '3',
        name: 'Nike Air Max 270',
        description: '舒适的运动鞋，适合日常穿着和运动',
        price: 899.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=Nike+Air+Max',
        category: '运动',
        stock: 100,
        rating: 4.5,
        reviewCount: 2100,
        tags: ['运动鞋', '耐克', '舒适', '时尚'],
        isOnSale: false,
      ),
      ProductModel(
        id: '4',
        name: 'Uniqlo 优衣库 基础T恤',
        description: '100%纯棉，舒适透气，多色可选',
        price: 79.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=Uniqlo+T-Shirt',
        category: '服装',
        stock: 200,
        rating: 4.3,
        reviewCount: 3500,
        tags: ['T恤', '优衣库', '纯棉', '基础款'],
        isOnSale: true,
        originalPrice: 99.0,
      ),
      ProductModel(
        id: '5',
        name: '《Flutter实战》',
        description: 'Flutter开发权威指南，从入门到精通',
        price: 89.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=Flutter+Book',
        category: '图书',
        stock: 150,
        rating: 4.7,
        reviewCount: 680,
        tags: ['编程', 'Flutter', '移动开发', '教程'],
        isOnSale: false,
      ),
      ProductModel(
        id: '6',
        name: '小米空气净化器4',
        description: '高效过滤PM2.5，智能控制，静音运行',
        price: 1299.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=Air+Purifier',
        category: '家居',
        stock: 80,
        rating: 4.4,
        reviewCount: 920,
        tags: ['空气净化', '小米', '智能', '健康'],
        isOnSale: true,
        originalPrice: 1499.0,
      ),
      ProductModel(
        id: '7',
        name: 'SK-II 神仙水',
        description: '经典护肤精华，改善肌肤质地',
        price: 1290.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=SK-II',
        category: '美妆',
        stock: 60,
        rating: 4.6,
        reviewCount: 1800,
        tags: ['护肤', '精华', 'SK-II', '经典'],
        isOnSale: false,
      ),
      ProductModel(
        id: '8',
        name: '三只松鼠坚果礼盒',
        description: '精选坚果组合，营养丰富，包装精美',
        price: 168.0,
        imageUrl: 'https://via.placeholder.com/300x300?text=Nuts+Gift+Box',
        category: '食品',
        stock: 120,
        rating: 4.2,
        reviewCount: 1500,
        tags: ['坚果', '礼盒', '三只松鼠', '健康'],
        isOnSale: true,
        originalPrice: 198.0,
      ),
    ];

    _products.addAll(sampleProducts);
    LogUtils.i('初始化示例数据: ${_products.length} 个产品');
  }
}
