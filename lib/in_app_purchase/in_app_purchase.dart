import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'app_purchase_manager.dart';

final _selectedProductIdProvider = StateProvider<String?>((ref) => null);

class InAppPurchasePage extends ConsumerStatefulWidget {
  const InAppPurchasePage({super.key});

  @override
  ConsumerState<InAppPurchasePage> createState() => _InAppPurchasePageState();
}

class _InAppPurchasePageState extends ConsumerState<InAppPurchasePage> {
  static const List<String> _androidProductIds = [
    'android_premium_monthly',
    'android_premium_yearly',
    'android_coin_100',
  ];

  static const List<String> _iosProductIds = [
    'ios_premium_monthly',
    'ios_premium_yearly',
    'ios_coin_100',
    'year_vip_one',
  ];

  final AppPurchaseManager _manager = AppPurchaseManager.instance;
  StreamSubscription<AppPurchaseResultData>? _purchaseSub;

  bool _available = false;
  bool _loading = true;
  bool _buying = false;
  String? _statusText;

  @override
  void initState() {
    super.initState();
    _initPurchase();
  }

  Future<void> _initPurchase() async {
    final available = await _manager.initialize();
    if (!mounted) return;

    setState(() => _available = available);

    if (available) {
      final ids = <String>{..._androidProductIds, ..._iosProductIds};
      await _manager.loadProducts(ids);
    }

    if (!mounted) return;
    setState(() => _loading = false);

    _purchaseSub = _manager.purchaseResultStream.listen(_onPurchaseResult);
  }

  void _onPurchaseResult(AppPurchaseResultData result) {
    if (!mounted) return;

    final msg = switch (result.result) {
      AppPurchaseResult.success => '购买成功：${result.productId ?? ''}',
      AppPurchaseResult.canceled => '用户已取消购买',
      AppPurchaseResult.pending => '订单处理中，请稍候…',
      AppPurchaseResult.error => '购买失败：${result.message ?? '未知错误'}',
    };

    setState(() {
      _statusText = msg;
      _buying = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _purchaseSub?.cancel();
    super.dispose();
  }

  Future<void> _buy(String productId) async {
    if (!_available) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('内购服务不可用，请检查商店配置')));
      return;
    }

    setState(() {
      _buying = true;
      _statusText = '正在发起购买：$productId';
    });

    final ok = await _manager.buyProduct(productId);
    if (!mounted) return;

    if (!ok) {
      setState(() {
        _buying = false;
        _statusText = '下单失败，商品未找到或请求异常';
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('下单失败，请稍后重试')));
    }
  }

  Future<void> _restore() async {
    if (!_available) return;
    setState(() => _statusText = '正在恢复购买…');
    await _manager.restorePurchases();
  }

  @override
  Widget build(BuildContext context) {
    final selectedId = ref.watch(_selectedProductIdProvider);
    final isAndroid = Platform.isAndroid;
    final isIOS = Platform.isIOS;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('内购示例'),
        actions: [
          TextButton(
            onPressed: _available ? _restore : null,
            child: const Text('恢复购买', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---- 状态信息 ----
          Card(
            color: _available ? Colors.green.shade50 : Colors.red.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.phone_iphone,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '平台：${isAndroid ? 'Android' : isIOS ? 'iOS' : '其他'}',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const Spacer(),
                      if (_loading)
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      else
                        Icon(
                          _available ? Icons.check_circle : Icons.error_outline,
                          size: 18,
                          color: _available ? Colors.green : Colors.red,
                        ),
                      const SizedBox(width: 4),
                      Text(
                        _loading ? '初始化中…' : (_available ? '内购可用' : '内购不可用'),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  if (_statusText != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      _statusText!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // ---- Android 产品 ----
          _buildProductCard(
            title: 'Android 产品',
            icon: Icons.android,
            iconColor: Colors.green,
            productIds: _androidProductIds,
            selectedId: selectedId,
          ),
          const SizedBox(height: 12),

          // ---- iOS 产品 ----
          _buildProductCard(
            title: 'iOS 产品',
            icon: Icons.apple,
            iconColor: Colors.black87,
            productIds: _iosProductIds,
            selectedId: selectedId,
          ),
          const SizedBox(height: 24),

          // ---- 购买按钮 ----
          ElevatedButton.icon(
            onPressed:
                selectedId == null || _buying ? null : () => _buy(selectedId),
            icon: _buying
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.shopping_cart_checkout),
            label: Text(
              selectedId == null ? '请先选择一个产品' : (_buying ? '正在购买…' : '确认购买'),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<String> productIds,
    required String? selectedId,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: iconColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 4),
            ...productIds.map(
              (id) => RadioListTile<String>(
                title: Text(id, style: const TextStyle(fontSize: 14)),
                subtitle: Text(
                  _productLabel(id),
                  style: const TextStyle(fontSize: 12),
                ),
                value: id,
                groupValue: selectedId,
                onChanged: (value) {
                  ref.read(_selectedProductIdProvider.notifier).state = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _productLabel(String id) {
    if (id.contains('monthly')) return '月度会员订阅';
    if (id.contains('yearly')) return '年度会员订阅';
    if (id.contains('coin')) return '100 金币（消耗型）';
    return '示例商品';
  }
}
