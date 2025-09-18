/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: SharedPreferencesManager 使用示例
 */

import 'package:flutter/material.dart';
import 'shared_preferences_manager.dart';
import '../log_utils/log_utils.dart';

/// SharedPreferencesManager 使用示例
class SharedPreferencesExample extends StatefulWidget {
  const SharedPreferencesExample({super.key});

  @override
  State<SharedPreferencesExample> createState() => _SharedPreferencesExampleState();
}

class _SharedPreferencesExampleState extends State<SharedPreferencesExample> {
  final SharedPreferencesManager _prefsManager = SharedPreferencesManager.instance;
  
  String _statusText = '准备就绪';
  String? _accessToken;
  String? _userId;
  String? _username;

  @override
  void initState() {
    super.initState();
    _loadStoredData();
  }

  /// 加载已存储的数据
  void _loadStoredData() {
    setState(() {
      _accessToken = _prefsManager.getAccessToken();
      _userId = _prefsManager.getUserId();
      _username = _prefsManager.getUsername();
    });
  }

  /// 更新状态文本
  void _updateStatus(String text) {
    setState(() {
      _statusText = text;
    });
  }

  /// 测试 Token 存储
  Future<void> _testTokenStorage() async {
    _updateStatus('测试 Token 存储...');
    
    try {
      // 存储访问令牌
      final accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
      await _prefsManager.setAccessToken(accessToken);
      
      // 存储刷新令牌
      final refreshToken = 'refresh_token_123456789';
      await _prefsManager.setRefreshToken(refreshToken);
      
      // 存储令牌过期时间（1小时后）
      final expiryTime = DateTime.now().add(const Duration(hours: 1));
      await _prefsManager.setTokenExpiry(expiryTime);
      
      // 获取并验证
      final storedAccessToken = _prefsManager.getAccessToken();
      final storedRefreshToken = _prefsManager.getRefreshToken();
      final storedExpiry = _prefsManager.getTokenExpiry();
      final isExpired = _prefsManager.isTokenExpired();
      
      LogUtils.i('Token 存储测试完成');
      LogUtils.d('访问令牌: ${storedAccessToken?.substring(0, 20)}...');
      LogUtils.d('刷新令牌: ${storedRefreshToken?.substring(0, 20)}...');
      LogUtils.d('过期时间: ${storedExpiry?.toIso8601String()}');
      LogUtils.d('是否过期: $isExpired');
      
      _updateStatus('Token 存储测试完成');
      _loadStoredData();
    } catch (e) {
      LogUtils.e('Token 存储测试失败: $e');
      _updateStatus('Token 存储测试失败: $e');
    }
  }

  /// 测试用户数据存储
  Future<void> _testUserDataStorage() async {
    _updateStatus('测试用户数据存储...');
    
    try {
      // 存储用户基本信息
      await _prefsManager.setUserId('user_123456');
      await _prefsManager.setUsername('张三');
      await _prefsManager.setUserEmail('zhangsan@example.com');
      await _prefsManager.setUserAvatar('https://example.com/avatar.jpg');
      
      // 存储用户详细信息
      final userInfo = {
        'id': 'user_123456',
        'name': '张三',
        'email': 'zhangsan@example.com',
        'phone': '13800138000',
        'age': 25,
        'city': '北京',
        'avatar': 'https://example.com/avatar.jpg',
        'createdAt': DateTime.now().toIso8601String(),
        'preferences': {
          'theme': 'dark',
          'language': 'zh-CN',
          'notifications': true,
        }
      };
      await _prefsManager.setUserInfo(userInfo);
      
      // 获取并验证
      final storedUserId = _prefsManager.getUserId();
      final storedUsername = _prefsManager.getUsername();
      final storedUserInfo = _prefsManager.getUserInfo();
      
      LogUtils.i('用户数据存储测试完成');
      LogUtils.d('用户ID: $storedUserId');
      LogUtils.d('用户名: $storedUsername');
      LogUtils.d('用户信息: ${storedUserInfo?.keys.join(', ')}');
      
      _updateStatus('用户数据存储测试完成');
      _loadStoredData();
    } catch (e) {
      LogUtils.e('用户数据存储测试失败: $e');
      _updateStatus('用户数据存储测试失败: $e');
    }
  }

  /// 测试通用数据存储
  Future<void> _testGenericStorage() async {
    _updateStatus('测试通用数据存储...');
    
    try {
      // 存储不同类型的数据
      await _prefsManager.setString('app_version', '1.0.0');
      await _prefsManager.setInt('login_count', 5);
      await _prefsManager.setBool('first_launch', false);
      await _prefsManager.setDouble('user_rating', 4.5);
      await _prefsManager.setStringList('favorite_categories', ['科技', '体育', '娱乐']);
      
      // 存储复杂对象
      final settings = {
        'theme': 'dark',
        'fontSize': 16,
        'autoSave': true,
        'lastSync': DateTime.now().toIso8601String(),
        'features': ['push', 'email', 'sms'],
      };
      await _prefsManager.setObject('app_settings', settings);
      
      // 获取并验证
      final appVersion = _prefsManager.getString('app_version');
      final loginCount = _prefsManager.getInt('login_count');
      final firstLaunch = _prefsManager.getBool('first_launch');
      final userRating = _prefsManager.getDouble('user_rating');
      final favoriteCategories = _prefsManager.getStringList('favorite_categories');
      final appSettings = _prefsManager.getObject('app_settings');
      
      LogUtils.i('通用数据存储测试完成');
      LogUtils.d('应用版本: $appVersion');
      LogUtils.d('登录次数: $loginCount');
      LogUtils.d('首次启动: $firstLaunch');
      LogUtils.d('用户评分: $userRating');
      LogUtils.d('收藏分类: ${favoriteCategories?.join(', ')}');
      LogUtils.d('应用设置: ${appSettings?.keys.join(', ')}');
      
      _updateStatus('通用数据存储测试完成');
    } catch (e) {
      LogUtils.e('通用数据存储测试失败: $e');
      _updateStatus('通用数据存储测试失败: $e');
    }
  }

  /// 测试数据清除
  Future<void> _testDataClearing() async {
    _updateStatus('测试数据清除...');
    
    try {
      // 清除令牌
      await _prefsManager.clearTokens();
      
      // 清除用户数据
      await _prefsManager.clearUserData();
      
      // 清除特定键
      await _prefsManager.remove('app_version');
      await _prefsManager.remove('login_count');
      
      LogUtils.i('数据清除测试完成');
      _updateStatus('数据清除测试完成');
      _loadStoredData();
    } catch (e) {
      LogUtils.e('数据清除测试失败: $e');
      _updateStatus('数据清除测试失败: $e');
    }
  }

  /// 显示所有存储的键
  void _showAllKeys() {
    final keys = _prefsManager.getKeys();
    LogUtils.i('所有存储的键: ${keys.join(', ')}');
    _updateStatus('显示所有键: ${keys.length} 个');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreferences 示例'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 状态显示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '当前状态: $_statusText',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('访问令牌: ${_accessToken != null ? '${_accessToken!.substring(0, 20)}...' : '未设置'}'),
                    Text('用户ID: ${_userId ?? '未设置'}'),
                    Text('用户名: ${_username ?? '未设置'}'),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 测试按钮
            ElevatedButton(
              onPressed: _testTokenStorage,
              child: const Text('测试 Token 存储'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: _testUserDataStorage,
              child: const Text('测试用户数据存储'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: _testGenericStorage,
              child: const Text('测试通用数据存储'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: _testDataClearing,
              child: const Text('测试数据清除'),
            ),
            
            const SizedBox(height: 8),
            
            ElevatedButton(
              onPressed: _showAllKeys,
              child: const Text('显示所有存储的键'),
            ),
            
            const SizedBox(height: 16),
            
            // 说明文本
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '使用说明:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    const Text('1. 点击各个测试按钮来测试不同的存储功能'),
                    const Text('2. 查看控制台日志了解详细操作信息'),
                    const Text('3. 状态区域会显示当前存储的数据'),
                    const Text('4. 所有操作都会记录到日志中'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
