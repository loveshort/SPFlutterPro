/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-10-30 16:53:24
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-10-30 16:55:32
 * @FilePath: /SPFlutterPro/lib/common/local_storage.dart
 * @Description: 本地存储工具类
 */
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage._();

  static Future<bool> setString(String key, String value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }

  static Future<bool> setInt(String key, int value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setInt(key, value);
  }

  static Future<int?> getInt(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }

  static Future<bool> setDouble(String key, double value) async {
    final sp = await SharedPreferences.getInstance();
    return sp.setDouble(key, value);
  }

  static Future<double?> getDouble(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }

  static Future<bool> setJson(String key, Object value) async {
    return setString(key, jsonEncode(value));
  }

  static Future<T?> getJson<T>(String key, T Function(dynamic) fromJson) async {
    final str = await getString(key);
    if (str == null) return null;
    return fromJson(jsonDecode(str));
  }

  static Future<bool> remove(String key) async {
    final sp = await SharedPreferences.getInstance();
    return sp.remove(key);
  }

  static Future<bool> clear() async {
    final sp = await SharedPreferences.getInstance();
    return sp.clear();
  }
}
