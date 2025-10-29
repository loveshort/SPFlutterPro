/*
 * @Author: mingci gu271901088@gmail.com
 * @Date: 2025-01-27
 * @LastEditors: mingci gu271901088@gmail.com
 * @LastEditTime: 2025-01-27
 * @FilePath: /SPFlutterPro/lib/Riverpod/utils/color_manager.dart
 * @Description: 颜色管理器
 */

import 'package:flutter/material.dart';

class ColorManager {
  // 私有构造函数
  ColorManager._();

  // 主题颜色
  static const Color primary = Color(0xFF2196F3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color accent = Color(0xFFFF4081);

  // 状态颜色
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // 文本颜色
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // 背景颜色
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);

  // 边框颜色
  static const Color border = Color(0xFFE0E0E0);

  // 设置暗色模式
  static void setDarkMode(bool isDark) {
    // 这里可以实现暗色模式逻辑
    // 目前只是占位符
  }
}
