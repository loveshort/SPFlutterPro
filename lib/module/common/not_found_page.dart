import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sp_flutter_shopping/getX/utils/color_manager.dart';
import 'package:sp_flutter_shopping/router/routes.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('页面未找到'),
        backgroundColor: ColorManager.error,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 100,
              color: ColorManager.error,
            ),
            const SizedBox(height: 20),
            Text(
              '页面未找到',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              '您访问的页面不存在',
              style: TextStyle(
                fontSize: 16,
                color: ColorManager.textSecondary,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Get.until((route) => route.settings.name == Routes.home);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 12,
                ),
              ),
              child: const Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}
