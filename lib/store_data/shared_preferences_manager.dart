/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: SharedPreferences 封装类，提供便捷的本地存储功能
 */

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../log_utils/log_utils.dart';

/// SharedPreferences 管理器
/// 提供便捷的本地存储功能，包括 token、用户数据等
class SharedPreferencesManager {
  static SharedPreferencesManager? _instance;
  static SharedPreferences? _prefs;

  // 私有构造函数
  SharedPreferencesManager._();

  /// 获取单例实例
  static SharedPreferencesManager get instance {
    _instance ??= SharedPreferencesManager._();
    return _instance!;
  }

  /// 初始化 SharedPreferences
  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      LogUtils.i('SharedPreferences 初始化成功');
    } catch (e) {
      LogUtils.e('SharedPreferences 初始化失败: $e');
      rethrow;
    }
  }

  /// 确保 SharedPreferences 已初始化
  void _ensureInitialized() {
    if (_prefs == null) {
      throw Exception('SharedPreferences 未初始化，请先调用 SharedPreferencesManager.init()');
    }
  }

  // ==================== Token 相关方法 ====================

  /// 存储访问令牌
  Future<bool> setAccessToken(String token) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setString('access_token', token);
      LogUtils.d('存储访问令牌: ${token.substring(0, 10)}...');
      return result;
    } catch (e) {
      LogUtils.e('存储访问令牌失败: $e');
      return false;
    }
  }

  /// 获取访问令牌
  String? getAccessToken() {
    _ensureInitialized();
    try {
      final token = _prefs!.getString('access_token');
      LogUtils.d('获取访问令牌: ${token != null ? '${token.substring(0, 10)}...' : 'null'}');
      return token;
    } catch (e) {
      LogUtils.e('获取访问令牌失败: $e');
      return null;
    }
  }

  /// 存储刷新令牌
  Future<bool> setRefreshToken(String token) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setString('refresh_token', token);
      LogUtils.d('存储刷新令牌: ${token.substring(0, 10)}...');
      return result;
    } catch (e) {
      LogUtils.e('存储刷新令牌失败: $e');
      return false;
    }
  }

  /// 获取刷新令牌
  String? getRefreshToken() {
    _ensureInitialized();
    try {
      final token = _prefs!.getString('refresh_token');
      LogUtils.d('获取刷新令牌: ${token != null ? '${token.substring(0, 10)}...' : 'null'}');
      return token;
    } catch (e) {
      LogUtils.e('获取刷新令牌失败: $e');
      return null;
    }
  }

  /// 存储令牌过期时间
  Future<bool> setTokenExpiry(DateTime expiryTime) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setString('token_expiry', expiryTime.toIso8601String());
      LogUtils.d('存储令牌过期时间: ${expiryTime.toIso8601String()}');
      return result;
    } catch (e) {
      LogUtils.e('存储令牌过期时间失败: $e');
      return false;
    }
  }

  /// 获取令牌过期时间
  DateTime? getTokenExpiry() {
    _ensureInitialized();
    try {
      final expiryString = _prefs!.getString('token_expiry');
      if (expiryString != null) {
        final expiry = DateTime.parse(expiryString);
        LogUtils.d('获取令牌过期时间: ${expiry.toIso8601String()}');
        return expiry;
      }
      return null;
    } catch (e) {
      LogUtils.e('获取令牌过期时间失败: $e');
      return null;
    }
  }

  /// 检查令牌是否过期
  bool isTokenExpired() {
    final expiry = getTokenExpiry();
    if (expiry == null) return true;
    return DateTime.now().isAfter(expiry);
  }

  /// 清除所有令牌
  Future<bool> clearTokens() async {
    _ensureInitialized();
    try {
      final results = await Future.wait([
        _prefs!.remove('access_token'),
        _prefs!.remove('refresh_token'),
        _prefs!.remove('token_expiry'),
      ]);
      final success = results.every((result) => result);
      LogUtils.d('清除令牌: ${success ? '成功' : '失败'}');
      return success;
    } catch (e) {
      LogUtils.e('清除令牌失败: $e');
      return false;
    }
  }

  // ==================== 用户数据相关方法 ====================

  /// 存储用户ID
  Future<bool> setUserId(String userId) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setString('user_id', userId);
      LogUtils.d('存储用户ID: $userId');
      return result;
    } catch (e) {
      LogUtils.e('存储用户ID失败: $e');
      return false;
    }
  }

  /// 获取用户ID
  String? getUserId() {
    _ensureInitialized();
    try {
      final userId = _prefs!.getString('user_id');
      LogUtils.d('获取用户ID: $userId');
      return userId;
    } catch (e) {
      LogUtils.e('获取用户ID失败: $e');
      return null;
    }
  }

  /// 存储用户名
  Future<bool> setUsername(String username) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setString('username', username);
      LogUtils.d('存储用户名: $username');
      return result;
    } catch (e) {
      LogUtils.e('存储用户名失败: $e');
      return false;
    }
  }

  /// 获取用户名
  String? getUsername() {
    _ensureInitialized();
    try {
      final username = _prefs!.getString('username');
      LogUtils.d('获取用户名: $username');
      return username;
    } catch (e) {
      LogUtils.e('获取用户名失败: $e');
      return null;
    }
  }

  /// 存储用户邮箱
  Future<bool> setUserEmail(String email) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setString('user_email', email);
      LogUtils.d('存储用户邮箱: $email');
      return result;
    } catch (e) {
      LogUtils.e('存储用户邮箱失败: $e');
      return false;
    }
  }

  /// 获取用户邮箱
  String? getUserEmail() {
    _ensureInitialized();
    try {
      final email = _prefs!.getString('user_email');
      LogUtils.d('获取用户邮箱: $email');
      return email;
    } catch (e) {
      LogUtils.e('获取用户邮箱失败: $e');
      return null;
    }
  }

  /// 存储用户头像URL
  Future<bool> setUserAvatar(String avatarUrl) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setString('user_avatar', avatarUrl);
      LogUtils.d('存储用户头像: $avatarUrl');
      return result;
    } catch (e) {
      LogUtils.e('存储用户头像失败: $e');
      return false;
    }
  }

  /// 获取用户头像URL
  String? getUserAvatar() {
    _ensureInitialized();
    try {
      final avatar = _prefs!.getString('user_avatar');
      LogUtils.d('获取用户头像: $avatar');
      return avatar;
    } catch (e) {
      LogUtils.e('获取用户头像失败: $e');
      return null;
    }
  }

  /// 存储用户信息（JSON格式）
  Future<bool> setUserInfo(Map<String, dynamic> userInfo) async {
    _ensureInitialized();
    try {
      final jsonString = jsonEncode(userInfo);
      final result = await _prefs!.setString('user_info', jsonString);
      LogUtils.d('存储用户信息: ${userInfo.keys.join(', ')}');
      return result;
    } catch (e) {
      LogUtils.e('存储用户信息失败: $e');
      return false;
    }
  }

  /// 获取用户信息（JSON格式）
  Map<String, dynamic>? getUserInfo() {
    _ensureInitialized();
    try {
      final jsonString = _prefs!.getString('user_info');
      if (jsonString != null) {
        final userInfo = jsonDecode(jsonString) as Map<String, dynamic>;
        LogUtils.d('获取用户信息: ${userInfo.keys.join(', ')}');
        return userInfo;
      }
      return null;
    } catch (e) {
      LogUtils.e('获取用户信息失败: $e');
      return null;
    }
  }

  // ==================== 通用存储方法 ====================

  /// 存储字符串
  Future<bool> setString(String key, String value) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setString(key, value);
      LogUtils.d('存储字符串 [$key]: ${value.length > 50 ? '${value.substring(0, 50)}...' : value}');
      return result;
    } catch (e) {
      LogUtils.e('存储字符串 [$key] 失败: $e');
      return false;
    }
  }

  /// 获取字符串
  String? getString(String key) {
    _ensureInitialized();
    try {
      final value = _prefs!.getString(key);
      LogUtils.d('获取字符串 [$key]: ${value != null ? (value.length > 50 ? '${value.substring(0, 50)}...' : value) : 'null'}');
      return value;
    } catch (e) {
      LogUtils.e('获取字符串 [$key] 失败: $e');
      return null;
    }
  }

  /// 存储整数
  Future<bool> setInt(String key, int value) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setInt(key, value);
      LogUtils.d('存储整数 [$key]: $value');
      return result;
    } catch (e) {
      LogUtils.e('存储整数 [$key] 失败: $e');
      return false;
    }
  }

  /// 获取整数
  int? getInt(String key) {
    _ensureInitialized();
    try {
      final value = _prefs!.getInt(key);
      LogUtils.d('获取整数 [$key]: $value');
      return value;
    } catch (e) {
      LogUtils.e('获取整数 [$key] 失败: $e');
      return null;
    }
  }

  /// 存储布尔值
  Future<bool> setBool(String key, bool value) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setBool(key, value);
      LogUtils.d('存储布尔值 [$key]: $value');
      return result;
    } catch (e) {
      LogUtils.e('存储布尔值 [$key] 失败: $e');
      return false;
    }
  }

  /// 获取布尔值
  bool? getBool(String key) {
    _ensureInitialized();
    try {
      final value = _prefs!.getBool(key);
      LogUtils.d('获取布尔值 [$key]: $value');
      return value;
    } catch (e) {
      LogUtils.e('获取布尔值 [$key] 失败: $e');
      return null;
    }
  }

  /// 存储双精度浮点数
  Future<bool> setDouble(String key, double value) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setDouble(key, value);
      LogUtils.d('存储双精度浮点数 [$key]: $value');
      return result;
    } catch (e) {
      LogUtils.e('存储双精度浮点数 [$key] 失败: $e');
      return false;
    }
  }

  /// 获取双精度浮点数
  double? getDouble(String key) {
    _ensureInitialized();
    try {
      final value = _prefs!.getDouble(key);
      LogUtils.d('获取双精度浮点数 [$key]: $value');
      return value;
    } catch (e) {
      LogUtils.e('获取双精度浮点数 [$key] 失败: $e');
      return null;
    }
  }

  /// 存储字符串列表
  Future<bool> setStringList(String key, List<String> value) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.setStringList(key, value);
      LogUtils.d('存储字符串列表 [$key]: ${value.length} 项');
      return result;
    } catch (e) {
      LogUtils.e('存储字符串列表 [$key] 失败: $e');
      return false;
    }
  }

  /// 获取字符串列表
  List<String>? getStringList(String key) {
    _ensureInitialized();
    try {
      final value = _prefs!.getStringList(key);
      LogUtils.d('获取字符串列表 [$key]: ${value?.length ?? 0} 项');
      return value;
    } catch (e) {
      LogUtils.e('获取字符串列表 [$key] 失败: $e');
      return null;
    }
  }

  /// 存储对象（JSON格式）
  Future<bool> setObject(String key, Map<String, dynamic> object) async {
    _ensureInitialized();
    try {
      final jsonString = jsonEncode(object);
      final result = await _prefs!.setString(key, jsonString);
      LogUtils.d('存储对象 [$key]: ${object.keys.join(', ')}');
      return result;
    } catch (e) {
      LogUtils.e('存储对象 [$key] 失败: $e');
      return false;
    }
  }

  /// 获取对象（JSON格式）
  Map<String, dynamic>? getObject(String key) {
    _ensureInitialized();
    try {
      final jsonString = _prefs!.getString(key);
      if (jsonString != null) {
        final object = jsonDecode(jsonString) as Map<String, dynamic>;
        LogUtils.d('获取对象 [$key]: ${object.keys.join(', ')}');
        return object;
      }
      return null;
    } catch (e) {
      LogUtils.e('获取对象 [$key] 失败: $e');
      return null;
    }
  }

  // ==================== 清除数据方法 ====================

  /// 移除指定键的数据
  Future<bool> remove(String key) async {
    _ensureInitialized();
    try {
      final result = await _prefs!.remove(key);
      LogUtils.d('移除数据 [$key]: ${result ? '成功' : '失败'}');
      return result;
    } catch (e) {
      LogUtils.e('移除数据 [$key] 失败: $e');
      return false;
    }
  }

  /// 清除所有用户数据
  Future<bool> clearUserData() async {
    _ensureInitialized();
    try {
      final keys = [
        'user_id',
        'username',
        'user_email',
        'user_avatar',
        'user_info',
      ];
      
      final results = await Future.wait(
        keys.map((key) => _prefs!.remove(key)),
      );
      
      final success = results.every((result) => result);
      LogUtils.d('清除用户数据: ${success ? '成功' : '失败'}');
      return success;
    } catch (e) {
      LogUtils.e('清除用户数据失败: $e');
      return false;
    }
  }

  /// 清除所有数据
  Future<bool> clearAll() async {
    _ensureInitialized();
    try {
      final result = await _prefs!.clear();
      LogUtils.d('清除所有数据: ${result ? '成功' : '失败'}');
      return result;
    } catch (e) {
      LogUtils.e('清除所有数据失败: $e');
      return false;
    }
  }

  /// 检查键是否存在
  bool containsKey(String key) {
    _ensureInitialized();
    try {
      final exists = _prefs!.containsKey(key);
      LogUtils.d('检查键 [$key] 是否存在: $exists');
      return exists;
    } catch (e) {
      LogUtils.e('检查键 [$key] 是否存在失败: $e');
      return false;
    }
  }

  /// 获取所有键
  Set<String> getKeys() {
    _ensureInitialized();
    try {
      final keys = _prefs!.getKeys();
      LogUtils.d('获取所有键: ${keys.length} 个');
      return keys;
    } catch (e) {
      LogUtils.e('获取所有键失败: $e');
      return <String>{};
    }
  }

  /// 重新加载数据
  Future<void> reload() async {
    _ensureInitialized();
    try {
      await _prefs!.reload();
      LogUtils.d('重新加载数据: 成功');
    } catch (e) {
      LogUtils.e('重新加载数据失败: $e');
    }
  }
}
