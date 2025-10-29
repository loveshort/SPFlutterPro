# GoRouter 完美封装

这是一个功能全面、类型安全、易于使用的GoRouter封装，提供了近乎完美的路由管理解决方案。

## 🚀 核心特性

### 📱 类型安全
- **强类型路由定义**: 所有路由路径和名称都有类型安全的常量定义
- **参数验证**: 自动验证路径参数和查询参数
- **编译时检查**: 在编译时就能发现路由错误

### 🛡️ 权限控制
- **路由守卫**: 支持全局和局部路由守卫
- **认证检查**: 自动检查用户登录状态
- **权限验证**: 支持细粒度的权限控制
- **重定向逻辑**: 智能的路由重定向

### 🎨 丰富动画
- **多种过渡效果**: 滑动、淡入淡出、缩放、旋转等
- **组合动画**: 支持多种动画效果组合
- **自定义动画**: 支持完全自定义的过渡动画
- **性能优化**: 优化的动画性能

### 🔧 开发工具
- **调试模式**: 完整的调试和日志功能
- **路由测试**: 自动化的路由测试工具
- **性能监控**: 路由性能分析和监控
- **错误追踪**: 详细的错误记录和分析

## 📁 项目结构

```
lib/router/
├── go_router_config.dart      # 路由配置
├── go_router_routes.dart      # 路由定义
├── go_router_guards.dart      # 路由守卫
├── go_router_transitions.dart # 过渡动画
├── go_router_utils.dart       # 工具类
├── go_router_debug.dart       # 调试工具
├── go_router_pages.dart       # 页面组件
└── README.md                  # 使用文档
```

## 🎯 快速开始

### 1. 初始化配置

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化GoRouter配置
  GoRouterConfig.instance.initialize();
  
  // 启用调试模式（可选）
  GoRouterDebug.enableDebug();
  
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}
```

### 2. 配置应用

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My App',
      routerConfig: GoRouterConfig.instance.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
```

### 3. 基础导航

```dart
// 使用工具类
GoRouterUtils.goHome();
GoRouterUtils.goLogin();
GoRouterUtils.goMainTab();

// 使用扩展方法
context.goHome();
context.goLogin();
context.goMainTab();

// 带参数导航
GoRouterUtils.goTodoDetail('todo-123');
GoRouterUtils.goProductDetail('product-456');
```

## 📖 详细使用

### 路由定义

```dart
// 在 go_router_routes.dart 中定义路由
class GoRouterRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String todoList = '/todos';
  static const String todoDetail = '/todos/detail/:todoId';
  
  // 构建带参数的路径
  static String todoDetailPath(String todoId) => '/todos/detail/$todoId';
}
```

### 路由守卫

```dart
// 在 go_router_guards.dart 中定义守卫
class GoRouterGuards {
  // 全局重定向
  static String? globalRedirect(BuildContext context, GoRouterState state) {
    if (_requiresAuth(state.location)) {
      return _checkAuthRedirect(context, state);
    }
    return null;
  }
  
  // 认证检查
  static String? authRequired(BuildContext context, GoRouterState state) {
    if (!_isUserLoggedIn()) {
      return '${GoRouterRoutes.login}?returnTo=${state.location}';
    }
    return null;
  }
}
```

### 过渡动画

```dart
// 使用预定义动画
GoRoute(
  path: '/example',
  pageBuilder: (context, state) => GoRouterTransitions.slideTransition(
    context: context,
    state: state,
    child: const ExamplePage(),
  ),
),

// 使用组合动画
GoRoute(
  path: '/example',
  pageBuilder: (context, state) => GoRouterTransitions.slideFadeTransition(
    context: context,
    state: state,
    child: const ExamplePage(),
  ),
),
```

### 工具类使用

```dart
// 基础导航
GoRouterUtils.go('/path');
GoRouterUtils.push('/path');
GoRouterUtils.pop();

// 便捷导航
GoRouterUtils.goHome();
GoRouterUtils.goLogin(returnTo: '/profile');
GoRouterUtils.goTodoDetail('todo-123');

// 查询参数
final path = GoRouterUtils.addQueryParameters(
  '/search',
  {'q': 'flutter', 'category': 'tech'},
);

// 路径参数
final path = GoRouterUtils.buildPathWithParams(
  '/products/:id',
  {'id': '123'},
);
```

### 扩展方法

```dart
// BuildContext 扩展
context.goHome();
context.goLogin();
context.goTodoDetail('todo-123');
context.popRoute();
context.canPop;

// 获取当前路由信息
final currentPath = context.currentPath;
final currentName = context.currentRouteName;
final isHome = context.isCurrentPath('/');
```

### 调试工具

```dart
// 启用调试模式
GoRouterDebug.enableDebug();

// 打印路由信息
GoRouterUtils.printCurrentRoute();
GoRouterUtils.printRouteHistory();

// 测试路由
await GoRouterDebug.testAllRoutes();
GoRouterDebug.testRoute('/example');

// 生成报告
final report = GoRouterDebug.generateRouteReport();
print(report);

// 添加监控器
GoRouterDebug.addMonitor(PerformanceMonitor());
GoRouterDebug.addMonitor(UsageMonitor());
```

## 🎨 过渡动画

### 基础动画

```dart
// 滑动动画
GoRouterTransitions.slideTransition(
  context: context,
  state: state,
  child: const Page(),
  direction: AxisDirection.left,
);

// 淡入淡出动画
GoRouterTransitions.fadeTransition(
  context: context,
  state: state,
  child: const Page(),
);

// 缩放动画
GoRouterTransitions.scaleTransition(
  context: context,
  state: state,
  child: const Page(),
  beginScale: 0.8,
  endScale: 1.0,
);

// 旋转动画
GoRouterTransitions.rotationTransition(
  context: context,
  state: state,
  child: const Page(),
);
```

### 组合动画

```dart
// 滑动 + 淡入淡出
GoRouterTransitions.slideFadeTransition(
  context: context,
  state: state,
  child: const Page(),
);

// 缩放 + 淡入淡出
GoRouterTransitions.scaleFadeTransition(
  context: context,
  state: state,
  child: const Page(),
);

// 滑动 + 缩放
GoRouterTransitions.slideScaleTransition(
  context: context,
  state: state,
  child: const Page(),
);
```

### 特殊动画

```dart
// 翻转动画
GoRouterTransitions.flipTransition(
  context: context,
  state: state,
  child: const Page(),
);

// 弹性动画
GoRouterTransitions.elasticTransition(
  context: context,
  state: state,
  child: const Page(),
);

// 波浪动画
GoRouterTransitions.waveTransition(
  context: context,
  state: state,
  child: const Page(),
);
```

## 🛡️ 路由守卫

### 全局守卫

```dart
// 全局重定向
static String? globalRedirect(BuildContext context, GoRouterState state) {
  // 检查认证
  if (_requiresAuth(state.location)) {
    return _checkAuthRedirect(context, state);
  }
  
  // 检查权限
  if (_requiresPermission(state.location)) {
    return _checkPermissionRedirect(context, state);
  }
  
  return null;
}
```

### 局部守卫

```dart
// 认证守卫
static String? authRequired(BuildContext context, GoRouterState state) {
  if (!_isUserLoggedIn()) {
    return '${GoRouterRoutes.login}?returnTo=${state.location}';
  }
  return null;
}

// 权限守卫
static String? permissionRequired(BuildContext context, GoRouterState state) {
  if (!_hasPermission(state.location)) {
    return GoRouterRoutes.home;
  }
  return null;
}
```

### 中间件

```dart
// 日志中间件
class LoggingMiddleware extends RouteMiddleware {
  @override
  String? execute(BuildContext context, GoRouterState state) {
    debugPrint('访问路由: ${state.location}');
    return null;
  }
}

// 分析中间件
class AnalyticsMiddleware extends RouteMiddleware {
  @override
  String? execute(BuildContext context, GoRouterState state) {
    // 发送分析数据
    Analytics.track('route_visit', {'path': state.location});
    return null;
  }
}
```

## 🔍 调试和测试

### 调试模式

```dart
// 启用调试模式
GoRouterDebug.enableDebug();

// 调试日志会自动输出
// GoRouter Debug [Navigation] [2025-01-27T10:00:00.000Z]: 导航: / -> /login
```

### 路由测试

```dart
// 测试所有路由
await GoRouterDebug.testAllRoutes();

// 测试指定路由
await GoRouterDebug.testRoute('/example');

// 测试路由参数
GoRouterDebug.testRouteParameters();
```

### 性能监控

```dart
// 添加性能监控器
final performanceMonitor = PerformanceMonitor();
GoRouterDebug.addMonitor(performanceMonitor);

// 获取性能数据
final performanceData = performanceMonitor.getPerformanceData();
```

### 使用情况分析

```dart
// 添加使用情况监控器
final usageMonitor = UsageMonitor();
GoRouterDebug.addMonitor(usageMonitor);

// 获取使用情况数据
final usageData = usageMonitor.getUsageData();
```

## 📊 最佳实践

### 1. 路由命名规范

```dart
// 使用描述性的路由名称
static const String userProfile = '/user/profile';
static const String productDetail = '/products/:id';
static const String orderHistory = '/orders/history';
```

### 2. 参数传递

```dart
// 使用类型安全的参数传递
GoRouterUtils.goTodoDetail('todo-123');
GoRouterUtils.goProductDetail('product-456');

// 使用查询参数
final path = GoRouterUtils.addQueryParameters(
  '/search',
  {'q': 'flutter', 'category': 'tech'},
);
```

### 3. 错误处理

```dart
// 在路由配置中提供错误页面
GoRouter(
  errorBuilder: (context, state) => ErrorPage(
    error: state.error,
    location: state.location,
  ),
)
```

### 4. 性能优化

```dart
// 使用懒加载
GoRoute(
  path: '/heavy-page',
  builder: (context, state) => const HeavyPage(),
  // 页面会在需要时才构建
),
```

### 5. 调试和监控

```dart
// 在开发环境启用调试
if (kDebugMode) {
  GoRouterDebug.enableDebug();
}

// 添加监控器
GoRouterDebug.addMonitor(PerformanceMonitor());
GoRouterDebug.addMonitor(UsageMonitor());
```

## 🎯 高级功能

### 1. 路由拦截器

```dart
// 权限拦截器
class PermissionInterceptor extends RouteInterceptor {
  @override
  bool beforeRoute(BuildContext context, GoRouterState state) {
    return _hasPermission(state.location);
  }
  
  @override
  void afterRoute(BuildContext context, GoRouterState state) {
    _trackRouteVisit(state.location);
  }
}
```

### 2. 数据预加载

```dart
// 数据预加载拦截器
class DataPreloadInterceptor extends RouteInterceptor {
  @override
  bool beforeRoute(BuildContext context, GoRouterState state) {
    _preloadData(state.location);
    return true;
  }
}
```

### 3. 路由缓存

```dart
// 缓存中间件
class CacheMiddleware extends RouteMiddleware {
  @override
  String? execute(BuildContext context, GoRouterState state) {
    _cacheRouteData(state.location);
    return null;
  }
}
```

## 🚀 总结

这个GoRouter封装提供了：

- ✅ **类型安全**: 编译时检查，减少运行时错误
- ✅ **权限控制**: 完整的认证和权限管理
- ✅ **丰富动画**: 多种过渡效果和自定义动画
- ✅ **开发工具**: 调试、测试、监控工具
- ✅ **易于使用**: 简洁的API和扩展方法
- ✅ **高性能**: 优化的性能和内存使用
- ✅ **可扩展**: 支持中间件和拦截器
- ✅ **完整文档**: 详细的使用说明和示例

这是一个近乎完美的GoRouter封装，适合各种规模的Flutter应用使用！
