# LogUtils - Flutter 日志工具封装

基于 `dart:developer` 的 Flutter 日志工具封装，提供统一的日志接口和丰富的功能。

## 功能特性

- 🎯 **多级别日志**: 支持 debug、info、warning、error 等多种日志级别
- 🌐 **网络日志**: 专门针对网络请求和API响应的日志记录
- 👤 **用户行为**: 记录用户操作和行为轨迹
- ⚡ **性能监控**: 记录操作耗时和性能指标
- 🎨 **美观输出**: 支持彩色输出和emoji图标
- 🔧 **灵活配置**: 支持动态开关和级别控制
- 📁 **文件输出**: 支持日志文件保存（可扩展）

## 快速开始

### 1. 初始化

```dart
import 'package:sp_flutter_shopping/log_utils/log_utils.dart';

void main() {
  // 初始化日志工具
  LogUtils.init(
    enabled: true,                    // 是否启用日志
    minLevel: LogLevel.debug,         // 最小日志级别
  );
  
  runApp(MyApp());
}
```

### 2. 基本使用

```dart
// 不同级别的日志
LogUtils.d('这是一条Debug日志');
LogUtils.i('这是一条Info日志');
LogUtils.w('这是一条Warning日志');
LogUtils.e('这是一条Error日志');

// 带错误和堆栈跟踪的日志
try {
  // 一些可能出错的代码
} catch (e, stackTrace) {
  LogUtils.e('捕获到异常', e, stackTrace);
}
```

### 3. 网络请求日志

```dart
// 记录网络请求
LogUtils.network(
  'GET',
  'https://api.example.com/users',
  headers: {'Authorization': 'Bearer token123'},
  data: {'page': 1, 'limit': 10},
  statusCode: 200,
  response: '{"users": []}',
);
```

### 4. API响应日志

```dart
// 成功的API响应
LogUtils.apiResponse(
  '/api/users',
  statusCode: 200,
  data: {'id': 1, 'name': '张三'},
);

// 失败的API响应
LogUtils.apiResponse(
  '/api/users',
  statusCode: 404,
  error: '用户不存在',
);
```

### 5. 用户行为日志

```dart
// 记录用户操作
LogUtils.userAction('用户登录', params: {
  'username': 'testuser',
  'loginTime': DateTime.now().toIso8601String(),
});

LogUtils.userAction('点击购买按钮', params: {
  'productId': '12345',
  'price': 99.99,
});
```

### 6. 性能监控日志

```dart
// 记录操作耗时
final stopwatch = Stopwatch()..start();
// 执行一些操作
stopwatch.stop();
LogUtils.performance('数据库查询', stopwatch.elapsed);
```

### 7. 动态控制

```dart
// 运行时禁用日志
LogUtils.setEnabled(false);

// 重新启用日志
LogUtils.setEnabled(true);

// 设置最小日志级别
    LogUtils.setMinLevel(LogLevel.warning);
```

## 日志级别

| 级别 | 方法 | 说明 |
|------|------|------|
| `LogLevel.debug` | `LogUtils.d()` | 调试信息，开发时使用 |
| `LogLevel.info` | `LogUtils.i()` | 一般信息，正常流程记录 |
| `LogLevel.warning` | `LogUtils.w()` | 警告信息，需要注意但不影响运行 |
| `LogLevel.error` | `LogUtils.e()` | 错误信息，需要处理的问题 |
| `LogLevel.trace` | `LogUtils.t()` | 跟踪信息，详细的执行路径 |
| `LogLevel.fatal` | `LogUtils.f()` | 致命错误，程序无法继续运行 |

## 与HTTP拦截器集成

LogUtils 已经与项目中的 HTTP 拦截器集成，自动记录网络请求和响应：

```dart
// lib/https/log_interceptor.dart
class LogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    LogUtils.network(
      options.method,
      options.uri.toString(),
      headers: options.headers,
      data: options.data,
    );
    super.onRequest(options, handler);
  }
  
  // ... 其他方法
}
```

## 配置选项

### 初始化参数

- `enabled`: 是否启用日志输出
- `minLevel`: 最小日志级别，低于此级别的日志将被过滤

### 输出格式

日志输出包含以下信息：
- 📅 时间戳
- 🏷️ 日志级别
- 📍 调用位置（文件名和行号）
- 💬 日志消息
- 🎨 彩色输出和emoji图标

## 示例输出

```
🌐 网络请求
├─ 方法: GET
├─ URL: https://api.example.com/users
├─ 状态码: 200
├─ 请求头: {Authorization: Bearer token123}
├─ 请求数据: {page: 1, limit: 10}
└─ 响应数据: {"users": []}

✅ API响应
├─ 端点: /api/users
├─ 状态码: 200
├─ 数据: {"id": 1, "name": "张三"}
└─ 错误: N/A

👤 用户行为
├─ 动作: 用户登录
└─ 参数: {username: testuser, loginTime: 2025-01-27T10:30:00.000Z}

⚡ 性能监控
├─ 操作: 数据库查询
└─ 耗时: 150ms
```

## 最佳实践

1. **开发环境**: 使用 `LogLevel.debug` 记录详细的调试信息
2. **生产环境**: 使用 `LogLevel.warning` 或 `LogLevel.error` 只记录重要信息
3. **性能敏感**: 在生产环境中可以禁用日志以提高性能
4. **错误处理**: 总是记录异常和堆栈跟踪信息
5. **用户行为**: 记录关键的用户操作以便分析用户行为
6. **网络请求**: 利用集成的拦截器自动记录网络请求

## 扩展功能

当前版本基于 `dart:developer` 实现，提供了简洁高效的日志功能。如需更多高级功能，可以考虑：

1. **文件输出**: 可以扩展支持日志文件保存
2. **远程日志**: 可以集成远程日志服务
3. **日志分析**: 可以添加日志分析功能

## 注意事项

1. 确保在生产环境中适当配置日志级别
2. 避免在日志中记录敏感信息（如密码、token等）
3. 文件输出功能需要额外的权限和存储空间
4. 大量日志输出可能影响应用性能

## 更新日志

- **v1.0.0**: 初始版本，基于 logger 库的封装
- **v1.1.0**: 简化版本，基于 dart:developer 实现
- 支持多级别日志输出
- 集成网络请求日志记录
- 支持用户行为和性能监控日志
- 提供动态配置和开关控制
- 更轻量级，无外部依赖
