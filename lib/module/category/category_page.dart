/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-09-23 16:56:21
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-23 17:06:21
 * @FilePath: /SPFlutterPro/lib/module/category/category_page.dart
 * @Description: 分类
 */
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: Center(
        child: Text('分类'),
      ),
    );
  }
}
