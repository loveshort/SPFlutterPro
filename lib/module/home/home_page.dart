/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-09-23 16:55:15
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-23 17:06:02
 * @FilePath: /SPFlutterPro/lib/module/home/home_page.dart
 * @Description: 首页
 */
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: Center(
        child: Text('首页'),
      ),
    );
  }
}
