/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 14:11:05
 * @FilePath: /SPFlutterPro/lib/app/app.dart
 * @Description: 应用主入口
 */
import 'package:common_flutter_network/common_flutter_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sp_flutter_shopping/module/common/not_found_page.dart';

// 导入路由配置
import '../router/app_pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // 应用标题
      title: 'SP Flutter Shopping',

      // 主题配置
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorManager.primary,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorManager.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),

      // 暗色主题配置
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorManager.primary,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
      ),

      // 主题模式
      themeMode: ThemeMode.system,

      // 初始路由
      initialRoute: AppPages.initial,

      // 路由配置
      getPages: AppPages.pages,

      // 未知路由处理
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const NotFoundPage(),
      ),

      // 路由观察器
      routingCallback: (routing) {
        // LogUtils.d('路由变化: ${routing?.current} -> ${routing?.previous}');
      },

      // 默认转场动画
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),

      // 国际化配置
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('zh', 'CN'),

      // 调试模式
      debugShowCheckedModeBanner: false,
    );
  }
}

/// 404页面
