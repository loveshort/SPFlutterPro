/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-09-23 16:57:24
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-09-23 17:06:41
 * @FilePath: /SPFlutterPro/lib/module/my/profile_page.dart
 * @Description: 我的页面
 */
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: Center(
        child: Text('我的'),
      ),
    );
  }
}
