# SharedPreferences 封装使用说明

## 概述

这是一个基于 `shared_preferences` 库的封装类，提供了便捷的本地存储功能，特别针对 token 存储和用户数据管理进行了优化。

## 主要功能

### 1. Token 管理
- 存储和获取访问令牌 (Access Token)
- 存储和获取刷新令牌 (Refresh Token)
- 存储和获取令牌过期时间
- 检查令牌是否过期
- 清除所有令牌

### 2. 用户数据管理
- 用户基本信息存储 (ID、用户名、邮箱、头像)
- 用户详细信息存储 (JSON 格式)
- 清除用户数据

### 3. 通用数据存储
- 支持多种数据类型：String、int、bool、double、List<String>
- 支持复杂对象存储 (JSON 格式)
- 键值对管理

### 4. 数据管理
- 移除指定键的数据
- 清除所有数据
- 检查键是否存在
- 获取所有键
- 重新加载数据

## 使用方法

### 1. 初始化

在 `main()` 函数中初始化：

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化 SharedPreferences
  await SharedPreferencesManager.init();
  
  runApp(const MyApp());
}
```

### 2. 基本使用

```dart
// 获取单例实例
final prefsManager = SharedPreferencesManager.instance;

// Token 操作
await prefsManager.setAccessToken('your_access_token');
String? token = prefsManager.getAccessToken();

// 用户数据操作
await prefsManager.setUserId('user_123');
await prefsManager.setUsername('张三');
String? userId = prefsManager.getUserId();

// 通用数据操作
await prefsManager.setString('app_version', '1.0.0');
await prefsManager.setInt('login_count', 5);
await prefsManager.setBool('first_launch', false);

// 复杂对象存储
Map<String, dynamic> userInfo = {
  'name': '张三',
  'age': 25,
  'email': 'zhangsan@example.com',
};
await prefsManager.setUserInfo(userInfo);
```

### 3. Token 管理示例

```dart
// 存储完整的认证信息
await prefsManager.setAccessToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...');
await prefsManager.setRefreshToken('refresh_token_123456');
await prefsManager.setTokenExpiry(DateTime.now().add(Duration(hours: 1)));

// 检查令牌是否过期
if (prefsManager.isTokenExpired()) {
  // 需要刷新令牌
  String? refreshToken = prefsManager.getRefreshToken();
  // 执行刷新逻辑...
}

// 清除所有令牌
await prefsManager.clearTokens();
```

### 4. 用户数据管理示例

```dart
// 存储用户基本信息
await prefsManager.setUserId('user_123456');
await prefsManager.setUsername('张三');
await prefsManager.setUserEmail('zhangsan@example.com');
await prefsManager.setUserAvatar('https://example.com/avatar.jpg');

// 存储用户详细信息
Map<String, dynamic> userInfo = {
  'id': 'user_123456',
  'name': '张三',
  'email': 'zhangsan@example.com',
  'phone': '13800138000',
  'age': 25,
  'city': '北京',
  'preferences': {
    'theme': 'dark',
    'language': 'zh-CN',
    'notifications': true,
  }
};
await prefsManager.setUserInfo(userInfo);

// 获取用户信息
Map<String, dynamic>? storedUserInfo = prefsManager.getUserInfo();
String? username = prefsManager.getUsername();

// 清除用户数据
await prefsManager.clearUserData();
```

### 5. 通用数据存储示例

```dart
// 存储不同类型的数据
await prefsManager.setString('app_version', '1.0.0');
await prefsManager.setInt('login_count', 5);
await prefsManager.setBool('first_launch', false);
await prefsManager.setDouble('user_rating', 4.5);
await prefsManager.setStringList('favorite_categories', ['科技', '体育', '娱乐']);

// 存储复杂对象
Map<String, dynamic> settings = {
  'theme': 'dark',
  'fontSize': 16,
  'autoSave': true,
  'lastSync': DateTime.now().toIso8601String(),
  'features': ['push', 'email', 'sms'],
};
await prefsManager.setObject('app_settings', settings);

// 获取数据
String? appVersion = prefsManager.getString('app_version');
int? loginCount = prefsManager.getInt('login_count');
bool? firstLaunch = prefsManager.getBool('first_launch');
double? userRating = prefsManager.getDouble('user_rating');
List<String>? categories = prefsManager.getStringList('favorite_categories');
Map<String, dynamic>? appSettings = prefsManager.getObject('app_settings');
```

### 6. 数据管理示例

```dart
// 检查键是否存在
bool exists = prefsManager.containsKey('user_id');

// 获取所有键
Set<String> allKeys = prefsManager.getKeys();

// 移除特定键
await prefsManager.remove('temp_data');

// 清除所有数据
await prefsManager.clearAll();

// 重新加载数据
await prefsManager.reload();
```

## 特性

1. **单例模式**: 使用单例模式确保全局只有一个实例
2. **错误处理**: 所有操作都包含完善的错误处理和日志记录
3. **类型安全**: 提供类型安全的存储和获取方法
4. **日志记录**: 集成日志系统，记录所有操作
5. **便捷方法**: 针对常用场景提供便捷方法
6. **数据验证**: 包含数据验证和初始化检查

## 注意事项

1. 使用前必须调用 `SharedPreferencesManager.init()` 进行初始化
2. 所有异步操作都会返回 `Future<bool>` 表示操作是否成功
3. 获取数据的方法可能返回 `null`，表示数据不存在
4. 建议在应用启动时进行初始化
5. 所有操作都会记录到日志中，便于调试

## 示例应用

运行应用后，点击 "SharedPreferences 示例" 按钮可以查看完整的使用示例和测试功能。
