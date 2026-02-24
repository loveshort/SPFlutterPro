/*
 * @Description: 内购封装 - 基于 in_app_purchase 的应用内购买管理
 */

import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

/// 内购结果状态（对上层简化）
enum AppPurchaseResult {
  /// 购买/恢复成功
  success,

  /// 用户取消
  canceled,

  /// 待处理（如家长确认）
  pending,

  /// 错误
  error,
}

/// 内购结果（封装给业务层使用）
class AppPurchaseResultData {
  final AppPurchaseResult result;
  final String? productId;
  final String? message;
  final String? purchaseId;

  const AppPurchaseResultData({
    required this.result,
    this.productId,
    this.message,
    this.purchaseId,
  });

  bool get isSuccess => result == AppPurchaseResult.success;
  bool get isCanceled => result == AppPurchaseResult.canceled;
  bool get isPending => result == AppPurchaseResult.pending;
  bool get isError => result == AppPurchaseResult.error;
}

/// 内购管理器 - 封装 in_app_purchase 第三方库
///
/// 使用方式：
/// 1. 在 App 启动时调用 [initialize]，并监听 [purchaseUpdates] 或 [purchaseResultController]
/// 2. 调用 [loadProducts] 拉取商品信息
/// 3. 调用 [buyProduct] / [buyConsumable] 发起购买
/// 4. 在购买流中收到结果后需对 [PurchaseStatus.purchased] / [restored] 调用 [completePurchase]
class AppPurchaseManager {
  AppPurchaseManager._();

  static final AppPurchaseManager _instance = AppPurchaseManager._();

  /// 单例
  static AppPurchaseManager get instance => _instance;

  final InAppPurchase _iap = InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _purchaseSubscription;

  /// 购买更新流（原始 PurchaseDetails 列表）
  Stream<List<PurchaseDetails>> get purchaseStream => _iap.purchaseStream;

  /// 简化后的购买结果流（业务层可直接监听）
  final StreamController<AppPurchaseResultData> _purchaseResultController =
      StreamController<AppPurchaseResultData>.broadcast();

  Stream<AppPurchaseResultData> get purchaseResultStream =>
      _purchaseResultController.stream;

  /// 是否已初始化（已监听购买流）
  bool _initialized = false;

  /// 缓存的商品详情（由 [loadProducts] 拉取）
  List<ProductDetails> _products = [];

  List<ProductDetails> get products => List.unmodifiable(_products);

  /// 初始化：检查可用性并监听购买流，建议在 App 启动时调用一次
  ///
  /// [onPurchaseUpdated] 可选，用于在收到购买更新时做 UI 或业务处理；
  /// 若不传，仍可通过 [purchaseResultStream] 监听。
  Future<bool> initialize({
    void Function(List<PurchaseDetails>)? onPurchaseUpdated,
  }) async {
    if (_initialized) return await isAvailable();

    final available = await isAvailable();
    if (!available) return false;

    _purchaseSubscription = _iap.purchaseStream.listen(
      (List<PurchaseDetails> purchaseDetailsList) {
        onPurchaseUpdated?.call(purchaseDetailsList);
        for (final purchase in purchaseDetailsList) {
          _handlePurchaseDetail(purchase);
        }
      },
      onError: (Object e) {
        _purchaseResultController.add(AppPurchaseResultData(
          result: AppPurchaseResult.error,
          message: e.toString(),
        ));
      },
    );

    _initialized = true;
    return true;
  }

  void _handlePurchaseDetail(PurchaseDetails purchase) {
    switch (purchase.status) {
      case PurchaseStatus.pending:
        _purchaseResultController.add(AppPurchaseResultData(
          result: AppPurchaseResult.pending,
          productId: purchase.productID,
          purchaseId: purchase.purchaseID,
        ));
        break;
      case PurchaseStatus.purchased:
      case PurchaseStatus.restored:
        _purchaseResultController.add(AppPurchaseResultData(
          result: AppPurchaseResult.success,
          productId: purchase.productID,
          purchaseId: purchase.purchaseID,
        ));
        if (purchase.pendingCompletePurchase) {
          completePurchase(purchase);
        }
        break;
      case PurchaseStatus.canceled:
        _purchaseResultController.add(AppPurchaseResultData(
          result: AppPurchaseResult.canceled,
          productId: purchase.productID,
        ));
        break;
      case PurchaseStatus.error:
        _purchaseResultController.add(AppPurchaseResultData(
          result: AppPurchaseResult.error,
          productId: purchase.productID,
          message: purchase.error?.message ?? 'Purchase error',
        ));
        if (purchase.pendingCompletePurchase) {
          completePurchase(purchase);
        }
        break;
    }
  }

  /// 内购是否可用（商店可用）
  Future<bool> isAvailable() => _iap.isAvailable();

  /// 根据商品 ID 拉取商品详情，结果会缓存在 [products]
  ///
  /// [productIds] 需与 App Store / Google Play 后台配置一致
  Future<ProductDetailsResponse> loadProducts(Set<String> productIds) async {
    final response = await _iap.queryProductDetails(productIds);
    if (response.notFoundIDs.isNotEmpty) {
      // 可选：日志或上报未找到的 id
    }
    _products = response.productDetails;
    return response;
  }

  /// 根据 id 从缓存中取商品详情
  ProductDetails? getProductById(String productId) {
    try {
      return _products.firstWhere((p) => p.id == productId);
    } catch (_) {
      return null;
    }
  }

  /// 购买非消耗型商品或订阅
  ///
  /// [productId] 需已通过 [loadProducts] 拉取到；[applicationUserName] 可选，用于恢复购买关联用户
  Future<bool> buyProduct(
    String productId, {
    String? applicationUserName,
  }) async {
    final product = getProductById(productId);
    if (product == null) return false;

    return _iap.buyNonConsumable(
      purchaseParam: PurchaseParam(
        productDetails: product,
        applicationUserName: applicationUserName,
      ),
    );
  }

  /// 购买消耗型商品
  ///
  /// [autoConsume] 为 true 时购买成功后会自动消耗，无需再调 completePurchase 做消耗
  Future<bool> buyConsumable(
    String productId, {
    String? applicationUserName,
    bool autoConsume = true,
  }) async {
    final product = getProductById(productId);
    if (product == null) return false;

    return _iap.buyConsumable(
      purchaseParam: PurchaseParam(
        productDetails: product,
        applicationUserName: applicationUserName,
      ),
      autoConsume: autoConsume,
    );
  }

  /// 完成购买（交付内容后调用，用于 purchased/restored/error 且 pendingCompletePurchase 为 true 的订单）
  Future<void> completePurchase(PurchaseDetails purchase) {
    return _iap.completePurchase(purchase);
  }

  /// 恢复购买
  Future<void> restorePurchases({String? applicationUserName}) async {
    await _iap.restorePurchases(applicationUserName: applicationUserName);
  }

  /// 获取用户所在国家/地区代码
  Future<String> countryCode() => _iap.countryCode();

  /// 释放资源（如 App 退出时取消订阅）
  void dispose() {
    _purchaseSubscription?.cancel();
    _purchaseSubscription = null;
    _purchaseResultController.close();
    _initialized = false;
  }
}
