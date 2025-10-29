/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/Riverpod/providers/providers.dart
 * @Description: Riverpod提供者 - 状态管理
 */

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:common_flutter_network/common_flutter_network.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

// 服务提供者
final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

// 产品列表提供者
final productsProvider = FutureProvider<List<ProductModel>>((ref) async {
  final service = ref.read(productServiceProvider);
  await service.initializeSampleData();
  return service.products;
});

// 购物车提供者
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final service = ref.read(productServiceProvider);
  return CartNotifier(service);
});

// 购物车数量提供者
final cartItemCountProvider = Provider<int>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0, (sum, item) => sum + item.quantity);
});

// 购物车总金额提供者
final cartTotalProvider = Provider<double>((ref) {
  final cartItems = ref.watch(cartProvider);
  return cartItems.fold(0.0, (sum, item) => sum + item.subtotal);
});

// 搜索查询提供者
final searchQueryProvider = StateProvider<String>((ref) => '');

// 排序选项提供者
final sortOptionProvider =
    StateProvider<SortOption>((ref) => SortOption.newest);

// 分类过滤提供者
final categoryFilterProvider = StateProvider<String>((ref) => '');

// 过滤后的产品提供者
final filteredProductsProvider = Provider<List<ProductModel>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final searchQuery = ref.watch(searchQueryProvider);
  final sortOption = ref.watch(sortOptionProvider);
  final categoryFilter = ref.watch(categoryFilterProvider);

  return productsAsync.when(
    data: (products) {
      List<ProductModel> filtered = products;

      // 按分类过滤
      if (categoryFilter.isNotEmpty) {
        filtered = filtered
            .where((product) => product.category == categoryFilter)
            .toList();
      }

      // 按搜索查询过滤
      if (searchQuery.isNotEmpty) {
        filtered = filtered
            .where((product) =>
                product.name
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) ||
                product.description
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) ||
                product.tags.any((tag) =>
                    tag.toLowerCase().contains(searchQuery.toLowerCase())))
            .toList();
      }

      // 排序
      final service = ref.read(productServiceProvider);
      return service.sortProducts(filtered, sortOption);
    },
    loading: () => [],
    error: (_, __) => [],
  );
});

// 产品详情提供者
final productDetailProvider =
    FutureProvider.family<ProductModel?, String>((ref, productId) async {
  final productsAsync = ref.watch(productsProvider);
  return productsAsync.when(
    data: (products) {
      try {
        return products.firstWhere((product) => product.id == productId);
      } catch (e) {
        return null;
      }
    },
    loading: () => null,
    error: (_, __) => null,
  );
});

// 推荐产品提供者
final recommendedProductsProvider = Provider<List<ProductModel>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final service = ref.read(productServiceProvider);

  return productsAsync.when(
    data: (products) => service.getRecommendedProducts('电子产品'),
    loading: () => [],
    error: (_, __) => [],
  );
});

// 热门产品提供者
final popularProductsProvider = Provider<List<ProductModel>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final service = ref.read(productServiceProvider);

  return productsAsync.when(
    data: (products) => service.getPopularProducts(),
    loading: () => [],
    error: (_, __) => [],
  );
});

// 特价产品提供者
final saleProductsProvider = Provider<List<ProductModel>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final service = ref.read(productServiceProvider);

  return productsAsync.when(
    data: (products) => service.getSaleProducts(),
    loading: () => [],
    error: (_, __) => [],
  );
});

// 统计信息提供者
final statisticsProvider = Provider<Map<String, dynamic>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final cartItems = ref.watch(cartProvider);

  return productsAsync.when(
    data: (products) => {
      'totalProducts': products.length,
      'totalCartItems': cartItems.fold(0, (sum, item) => sum + item.quantity),
      'cartTotal': cartItems.fold(0.0, (sum, item) => sum + item.subtotal),
      'categories': ProductCategory.values.map((e) => e.label).toList(),
      'averageRating': products.isNotEmpty
          ? products.map((p) => p.rating).reduce((a, b) => a + b) /
              products.length
          : 0.0,
    },
    loading: () => {
      'totalProducts': 0,
      'totalCartItems': 0,
      'cartTotal': 0.0,
      'categories': <String>[],
      'averageRating': 0.0,
    },
    error: (_, __) => {
      'totalProducts': 0,
      'totalCartItems': 0,
      'cartTotal': 0.0,
      'categories': <String>[],
      'averageRating': 0.0,
    },
  );
});

// 购物车状态通知器
class CartNotifier extends StateNotifier<List<CartItem>> {
  final ProductService _service;

  CartNotifier(this._service) : super([]) {
    _loadCartItems();
  }

  // 加载购物车项目
  void _loadCartItems() {
    state = _service.cartItems;
  }

  // 添加产品到购物车
  Future<void> addToCart(ProductModel product, {int quantity = 1}) async {
    final success = await _service.addToCart(product, quantity: quantity);
    if (success) {
      _loadCartItems();
      LogUtils.i('添加产品到购物车成功: ${product.name}');
    }
  }

  // 从购物车移除产品
  Future<void> removeFromCart(String productId) async {
    final success = await _service.removeFromCart(productId);
    if (success) {
      _loadCartItems();
      LogUtils.i('从购物车移除产品成功: $productId');
    }
  }

  // 更新购物车项目数量
  Future<void> updateQuantity(String productId, int quantity) async {
    final success = await _service.updateCartItemQuantity(productId, quantity);
    if (success) {
      _loadCartItems();
      LogUtils.i('更新购物车项目数量成功: $productId -> $quantity');
    }
  }

  // 清空购物车
  Future<void> clearCart() async {
    final success = await _service.clearCart();
    if (success) {
      _loadCartItems();
      LogUtils.i('清空购物车成功');
    }
  }

  // 检查产品是否在购物车中
  bool isInCart(String productId) {
    return _service.isInCart(productId);
  }

  // 获取购物车中产品的数量
  int getQuantity(String productId) {
    return _service.getCartItemQuantity(productId);
  }
}

// 主题提供者
final themeProvider = StateProvider<bool>((ref) => false);

// 语言提供者
final languageProvider = StateProvider<String>((ref) => 'zh');

// 用户偏好提供者
final userPreferencesProvider =
    StateNotifierProvider<UserPreferencesNotifier, Map<String, dynamic>>((ref) {
  return UserPreferencesNotifier();
});

// 用户偏好状态通知器
class UserPreferencesNotifier extends StateNotifier<Map<String, dynamic>> {
  UserPreferencesNotifier()
      : super({
          'theme': 'light',
          'language': 'zh',
          'notifications': true,
          'autoSync': true,
        });

  void updateTheme(String theme) {
    state = {...state, 'theme': theme};
    LogUtils.i('更新主题: $theme');
  }

  void updateLanguage(String language) {
    state = {...state, 'language': language};
    LogUtils.i('更新语言: $language');
  }

  void updateNotifications(bool enabled) {
    state = {...state, 'notifications': enabled};
    LogUtils.i('更新通知设置: $enabled');
  }

  void updateAutoSync(bool enabled) {
    state = {...state, 'autoSync': enabled};
    LogUtils.i('更新自动同步设置: $enabled');
  }
}
