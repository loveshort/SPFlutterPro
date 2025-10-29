/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-29 11:23:21
 * @FilePath: /SPFlutterPro/lib/router/go_router_config.dart
 * @Description: GoRouter 完美封装 - 基础配置
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sp_flutter_shopping/router/go_router/go_router_guards.dart';
import 'package:sp_flutter_shopping/router/go_router/go_router_pages.dart';
import 'package:sp_flutter_shopping/router/go_router/go_router_routes.dart';
import 'package:sp_flutter_shopping/router/go_router/go_router_transitions.dart';
import '../getX/pages/getx_example_page.dart';
import '../getX/pages/todo_list_page.dart';
import '../getX/pages/todo_detail_page.dart';
import '../getX/pages/todo_form_page.dart';
import '../getX/models/todo_model.dart';
import '../Riverpod/pages/riverpod_example_page.dart';
import '../Riverpod/pages/product_list_page.dart';
import '../Riverpod/pages/product_detail_page.dart';
import '../Riverpod/pages/river_pod_cart_page.dart';
import '../module/tabbar/bottom_tab_example.dart';

/// GoRouter 配置类
/// 提供类型安全的路由管理
class GoRouterConfig {
  static GoRouterConfig? _instance;
  static GoRouterConfig get instance => _instance ??= GoRouterConfig._();

  GoRouterConfig._();

  late final GoRouter _router;
  GoRouter get router => _router;

  /// 初始化路由配置
  void initialize() {
    _router = GoRouter(
      // 初始路由
      initialLocation: GoRouterRoutes.home,

      // 调试模式
      debugLogDiagnostics: true,

      // 错误处理
      errorBuilder: (context, state) => _buildErrorPage(context, state),

      // 重定向逻辑
      redirect: GoRouterGuards.globalRedirect,

      // 路由配置
      routes: _buildRoutes(),

      // 路由观察者
      observers: [
        GoRouterObserver(),
      ],
    );
  }

  /// 构建路由配置
  List<RouteBase> _buildRoutes() {
    return [
      // 主路由
      GoRoute(
        path: GoRouterRoutes.home,
        name: GoRouterRoutes.homeName,
        builder: (context, state) => const HomePage(),
        redirect: GoRouterGuards.homeRedirect,
      ),

      // 登录路由
      GoRoute(
        path: GoRouterRoutes.login,
        name: GoRouterRoutes.loginName,
        builder: (context, state) => const LoginPage(),
        redirect: GoRouterGuards.authRedirect,
      ),

      // 主Tab路由
      GoRoute(
        path: GoRouterRoutes.mainTab,
        name: GoRouterRoutes.mainTabName,
        builder: (context, state) => const MainTabPage(),
        redirect: GoRouterGuards.authRequired,
        routes: [
          // Tab子路由
          GoRoute(
            path: 'home',
            name: 'tab-home',
            builder: (context, state) => const TabHomePage(),
          ),
          GoRoute(
            path: 'category',
            name: 'tab-category',
            builder: (context, state) => const TabCategoryPage(),
          ),
          GoRoute(
            path: 'cart',
            name: 'tab-cart',
            builder: (context, state) => const TabCartPage(),
          ),
          GoRoute(
            path: 'message',
            name: 'tab-message',
            builder: (context, state) => const TabMessagePage(),
          ),
          GoRoute(
            path: 'profile',
            name: 'tab-profile',
            builder: (context, state) => const TabProfilePage(),
          ),
        ],
      ),

      // GetX示例路由
      GoRoute(
        path: GoRouterRoutes.getxExample,
        name: GoRouterRoutes.getxExampleName,
        builder: (context, state) => const GetXExamplePage(),
        pageBuilder: (context, state) => GoRouterTransitions.slideTransition(
          context: context,
          state: state,
          child: const GetXExamplePage(),
        ),
      ),

      // GetX Todo路由组
      GoRoute(
        path: GoRouterRoutes.todoList,
        name: GoRouterRoutes.todoListName,
        builder: (context, state) => const TodoListPage(),
        routes: [
          GoRoute(
            path: 'detail/:todoId',
            name: 'todo-detail',
            builder: (context, state) {
              final todoId = state.pathParameters['todoId']!;
              return TodoDetailPage(todoId: todoId);
            },
            pageBuilder: (context, state) => GoRouterTransitions.fadeTransition(
              context: context,
              state: state,
              child: TodoDetailPage(todoId: state.pathParameters['todoId']!),
            ),
          ),
          GoRoute(
            path: 'form',
            name: 'todo-form',
            builder: (context, state) {
              final todo = state.extra as TodoModel?;
              return TodoFormPage(todo: todo);
            },
            pageBuilder: (context, state) =>
                GoRouterTransitions.scaleTransition(
              context: context,
              state: state,
              child: TodoFormPage(todo: state.extra as TodoModel?),
            ),
          ),
        ],
      ),

      // Riverpod示例路由
      GoRoute(
        path: GoRouterRoutes.riverpodExample,
        name: GoRouterRoutes.riverpodExampleName,
        builder: (context, state) => const RiverpodExamplePage(),
        pageBuilder: (context, state) => GoRouterTransitions.slideTransition(
          context: context,
          state: state,
          child: const RiverpodExamplePage(),
        ),
      ),

      // Riverpod产品路由组
      GoRoute(
        path: GoRouterRoutes.riverpodProductList,
        name: GoRouterRoutes.riverpodProductListName,
        builder: (context, state) => const ProductListPage(),
        routes: [
          GoRoute(
            path: 'detail/:productId',
            name: 'product-detail',
            builder: (context, state) {
              final productId = state.pathParameters['productId']!;
              return ProductDetailPage(productId: productId);
            },
            pageBuilder: (context, state) => GoRouterTransitions.fadeTransition(
              context: context,
              state: state,
              child: ProductDetailPage(
                  productId: state.pathParameters['productId']!),
            ),
          ),
        ],
      ),

      // Riverpod购物车路由
      GoRoute(
        path: GoRouterRoutes.riverpodCart,
        name: GoRouterRoutes.riverpodCartName,
        builder: (context, state) => const RiverpodCartPage(),
        pageBuilder: (context, state) => GoRouterTransitions.slideTransition(
          context: context,
          state: state,
          child: const RiverpodCartPage(),
        ),
      ),

      // 其他功能路由
      GoRoute(
        path: GoRouterRoutes.search,
        name: GoRouterRoutes.searchName,
        builder: (context, state) => const SearchPage(),
      ),

      GoRoute(
        path: GoRouterRoutes.settings,
        name: GoRouterRoutes.settingsName,
        builder: (context, state) => const SettingsPage(),
        redirect: GoRouterGuards.authRequired,
      ),

      GoRoute(
        path: GoRouterRoutes.about,
        name: GoRouterRoutes.aboutName,
        builder: (context, state) => const AboutPage(),
      ),

      // 示例路由
      GoRoute(
        path: GoRouterRoutes.bottomTabExample,
        name: GoRouterRoutes.bottomTabExampleName,
        builder: (context, state) => const BottomTabExample(),
      ),

      GoRoute(
        path: GoRouterRoutes.advancedBottomTabExample,
        name: GoRouterRoutes.advancedBottomTabExampleName,
        builder: (context, state) => const BottomTabExample(),
      ),

      GoRoute(
        path: GoRouterRoutes.colorExample,
        name: GoRouterRoutes.colorExampleName,
        builder: (context, state) => const ColorExamplePage(),
      ),

      GoRoute(
        path: GoRouterRoutes.bottomSheetExample,
        name: GoRouterRoutes.bottomSheetExampleName,
        builder: (context, state) => const BottomSheetExamplePage(),
      ),

      GoRoute(
        path: GoRouterRoutes.centerDialogExample,
        name: GoRouterRoutes.centerDialogExampleName,
        builder: (context, state) => const CenterDialogExamplePage(),
      ),
    ];
  }

  /// 构建错误页面
  Widget _buildErrorPage(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('页面错误'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              '页面未找到',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              '路径: ${state.uri.path}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(GoRouterRoutes.home),
              child: const Text('返回首页'),
            ),
          ],
        ),
      ),
    );
  }
}

/// GoRouter 观察者
class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint('GoRouter: 推入路由 ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    debugPrint('GoRouter: 弹出路由 ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    debugPrint(
        'GoRouter: 替换路由 ${oldRoute?.settings.name} -> ${newRoute?.settings.name}');
  }
}
