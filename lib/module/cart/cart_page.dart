/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-09-23 16:56:50
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-23 17:06:30
 * @FilePath: /SPFlutterPro/lib/module/cart/cart_page.dart
 * @Description: 购物车
 */
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
      ),
      body: Center(
        child: Text('购物车'),
      ),
    );
  }
}
