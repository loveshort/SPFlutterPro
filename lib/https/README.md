# HttpsEngine 网络请求引擎

一个功能完整的Flutter网络请求封装库，基于Dio实现，提供缓存、文件上传下载等功能。

## 功能特性

- ✅ **基础HTTP请求**：支持GET、POST、PUT、DELETE
- ✅ **智能缓存**：自动缓存响应数据，支持过期时间设置
- ✅ **文件操作**：支持文件上传和下载，带进度回调
- ✅ **错误处理**：完善的错误处理和日志记录
- ✅ **请求拦截**：支持日志拦截器和认证拦截器
- ✅ **超时控制**：可配置的连接、接收、发送超时时间
- ✅ **缓存管理**：支持清除所有缓存或过期缓存

## 快速开始

### 1. 初始化

```dart
import 'package:your_app/https/https_engine.dart';

// 初始化网络请求引擎
await HttpsEngine.init();

// 设置基础URL
HttpsEngine.setBaseUrl('https://api.example.com');

// 设置请求头
HttpsEngine.setHeader('Content-Type', 'application/json');
HttpsEngine.setHeader('Authorization', 'Bearer your_token');
```

### 2. 基础请求

#### GET请求
```dart
// 不带缓存的GET请求
final response = await HttpsEngine.get<Map<String, dynamic>>(
  '/users',
  queryParameters: {
    'page': 1,
    'limit': 10,
  },
);
print('用户列表: ${response.data}');
```

#### POST请求
```dart
// POST请求
final response = await HttpsEngine.post<Map<String, dynamic>>(
  '/users',
  data: {
    'name': '张三',
    'email': 'zhangsan@example.com',
    'age': 25,
  },
);
print('创建用户: ${response.data}');
```

#### PUT请求
```dart
// PUT请求
final response = await HttpsEngine.put<Map<String, dynamic>>(
  '/users/123',
  data: {
    'name': '李四',
    'email': 'lisi@example.com',
  },
);
print('更新用户: ${response.data}');
```

#### DELETE请求
```dart
// DELETE请求
final response = await HttpsEngine.delete<Map<String, dynamic>>(
  '/users/123',
);
print('删除用户: ${response.data}');
```

### 3. 带缓存的请求

#### 带缓存的GET请求
```dart
// 带缓存的GET请求（默认5分钟过期）
final response = await HttpsEngine.getWithCache<Map<String, dynamic>>(
  '/products',
  queryParameters: {
    'category': 'electronics',
    'page': 1,
  },
  cacheKey: 'products_electronics_page1', // 自定义缓存键
  cacheExpiry: const Duration(minutes: 10), // 自定义缓存过期时间
);
print('产品列表: ${response.data}');
```

#### 强制刷新缓存
```dart
// 强制刷新缓存
final response = await HttpsEngine.getWithCache<Map<String, dynamic>>(
  '/products',
  queryParameters: {
    'category': 'electronics',
  },
  forceRefresh: true, // 强制刷新，忽略缓存
);
print('最新产品列表: ${response.data}');
```

#### 带缓存的POST请求
```dart
// 带缓存的POST请求
final response = await HttpsEngine.postWithCache<Map<String, dynamic>>(
  '/search',
  data: {
    'keyword': '手机',
    'category': 'electronics',
  },
  cacheExpiry: const Duration(minutes: 30),
);
print('搜索结果: ${response.data}');
```

### 4. 文件操作

#### 文件上传
```dart
// 文件上传
final response = await HttpsEngine.uploadFile<Map<String, dynamic>>(
  '/upload',
  '/path/to/local/file.jpg',
  fileName: 'avatar.jpg',
  data: {
    'userId': '123',
    'type': 'avatar',
  },
  onSendProgress: (sent, total) {
    final progress = (sent / total * 100).toStringAsFixed(1);
    print('上传进度: $progress%');
  },
);
print('上传结果: ${response.data}');
```

#### 文件下载
```dart
// 文件下载
final savePath = await HttpsEngine.downloadFile(
  'https://example.com/files/document.pdf',
  fileName: 'my_document.pdf',
  onReceiveProgress: (received, total) {
    if (total != -1) {
      final progress = (received / total * 100).toStringAsFixed(1);
      print('下载进度: $progress%');
    }
  },
);
print('文件下载完成，保存路径: $savePath');
```

### 5. 缓存管理

#### 清除所有缓存
```dart
// 清除所有缓存
await HttpsEngine.clearAllCache();
print('所有缓存已清除');
```

#### 清除过期缓存
```dart
// 清除过期缓存
await HttpsEngine.clearExpiredCache();
print('过期缓存已清除');
```

### 6. 配置选项

#### 设置超时时间
```dart
// 设置超时时间
HttpsEngine.setTimeout(
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  sendTimeout: const Duration(seconds: 30),
);
```

#### 动态设置请求头
```dart
// 设置请求头
HttpsEngine.setHeader('Authorization', 'Bearer new_token');

// 移除请求头
HttpsEngine.removeHeader('Authorization');
```

#### 动态设置基础URL
```dart
// 设置基础URL
HttpsEngine.setBaseUrl('https://new-api.example.com');
```

## 缓存机制

### 缓存策略
- **自动缓存**：成功的响应（状态码200）会自动缓存
- **过期检查**：每次访问缓存时都会检查是否过期
- **网络降级**：网络请求失败时，会尝试返回缓存数据
- **智能键生成**：基于请求路径、参数和数据自动生成缓存键

### 缓存配置
- **默认过期时间**：5分钟
- **自定义过期时间**：支持任意Duration设置
- **自定义缓存键**：支持手动指定缓存键
- **强制刷新**：支持忽略缓存强制请求最新数据

## 错误处理

### 异常类型
- **DioException**：网络请求异常
- **Exception**：文件不存在等业务异常

### 错误日志
所有错误都会通过LogUtils记录，包括：
- 请求失败信息
- 网络异常详情
- 缓存操作失败
- 文件操作错误

## 最佳实践

### 1. 初始化时机
```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 在应用启动时初始化
  await HttpsEngine.init();
  
  runApp(MyApp());
}
```

### 2. 缓存策略选择
- **频繁访问的数据**：使用带缓存的请求
- **实时性要求高的数据**：使用不带缓存的请求
- **大数据量请求**：设置较长的缓存时间
- **用户操作触发的请求**：使用强制刷新

### 3. 错误处理
```dart
try {
  final response = await HttpsEngine.get<Map<String, dynamic>>('/api/data');
  // 处理成功响应
  handleSuccess(response.data);
} on DioException catch (e) {
  // 处理网络错误
  handleNetworkError(e);
} catch (e) {
  // 处理其他错误
  handleOtherError(e);
}
```

### 4. 性能优化
- 合理设置缓存过期时间
- 定期清理过期缓存
- 使用适当的超时时间
- 避免频繁的强制刷新

## 依赖项

- `dio: ^5.9.0` - HTTP客户端
- `path_provider: ^2.1.4` - 文件路径管理
- `shared_preferences: ^2.5.3` - 本地存储

## 注意事项

1. **初始化顺序**：确保在使用前调用`HttpsEngine.init()`
2. **缓存存储**：缓存数据存储在SharedPreferences中
3. **文件路径**：下载文件默认保存在应用文档目录的downloads文件夹
4. **内存管理**：大量缓存数据可能影响应用性能，建议定期清理
5. **网络状态**：建议结合网络状态检测使用

## 更新日志

### v1.0.0
- 初始版本
- 支持基础HTTP请求
- 支持缓存功能
- 支持文件上传下载
- 支持错误处理和日志记录