/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: 颜色管理器 - 提供统一的颜色定义和管理
 */

import 'package:flutter/material.dart';

/// 颜色管理器
/// 提供统一的颜色定义，支持主题切换和颜色管理
class ColorManager {
  static ColorManager? _instance;
  static ColorManager get instance => _instance ??= ColorManager._();
  
  ColorManager._();

  // ==================== 主题颜色 ====================
  
  /// 主色调
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryLight = Color(0xFF64B5F6);
  static const Color primaryDark = Color(0xFF1976D2);
  
  /// 辅助色
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryLight = Color(0xFF66FFF9);
  static const Color secondaryDark = Color(0xFF00A896);
  
  /// 强调色
  static const Color accent = Color(0xFFFF4081);
  static const Color accentLight = Color(0xFFFF79B0);
  static const Color accentDark = Color(0xFFE91E63);
  
  // ==================== 语义化颜色 ====================
  
  /// 成功色
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);
  
  /// 警告色
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);
  
  /// 错误色
  static const Color error = Color(0xFFF44336);
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);
  
  /// 信息色
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);
  
  // ==================== 中性色 ====================
  
  /// 白色系
  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteSmoke = Color(0xFFF5F5F5);
  static const Color ghostWhite = Color(0xFFF8F8FF);
  static const Color snow = Color(0xFFFFFAFA);
  
  /// 黑色系
  static const Color black = Color(0xFF000000);
  static const Color charcoal = Color(0xFF36454F);
  static const Color darkGray = Color(0xFF2F2F2F);
  static const Color dimGray = Color(0xFF696969);
  
  /// 灰色系
  static const Color lightGray = Color(0xFFD3D3D3);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color gray = Color(0xFF808080);
  static const Color darkSlateGray = Color(0xFF2F4F4F);
  
  // ==================== 背景色 ====================
  
  /// 背景色
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  
  /// 卡片背景
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF2C2C2C);
  
  // ==================== 文本颜色 ====================
  
  /// 主要文本
  static const Color textPrimary = Color(0xFF212121);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  
  /// 次要文本
  static const Color textSecondary = Color(0xFF757575);
  static const Color textSecondaryDark = Color(0xFFB3B3B3);
  
  /// 禁用文本
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textDisabledDark = Color(0xFF666666);
  
  /// 提示文本
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textHintDark = Color(0xFF808080);
  
  // ==================== 边框颜色 ====================
  
  /// 边框色
  static const Color border = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFF424242);
  
  /// 分割线
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
  
  // ==================== 状态颜色 ====================
  
  /// 选中状态
  static const Color selected = Color(0xFF2196F3);
  static const Color selectedDark = Color(0xFF1976D2);
  
  /// 悬停状态
  static const Color hover = Color(0xFFE3F2FD);
  static const Color hoverDark = Color(0xFF1A237E);
  
  /// 按下状态
  static const Color pressed = Color(0xFFBBDEFB);
  static const Color pressedDark = Color(0xFF0D47A1);
  
  /// 禁用状态
  static const Color disabled = Color(0xFFF5F5F5);
  static const Color disabledDark = Color(0xFF424242);
  
  // ==================== 渐变色 ====================
  
  /// 主色调渐变
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  /// 彩虹渐变
  static const LinearGradient rainbowGradient = LinearGradient(
    colors: [
      Color(0xFFFF0000), // 红
      Color(0xFFFF8000), // 橙
      Color(0xFFFFFF00), // 黄
      Color(0xFF80FF00), // 绿
      Color(0xFF00FFFF), // 青
      Color(0xFF0080FF), // 蓝
      Color(0xFF8000FF), // 紫
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  /// 日落渐变
  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [
      Color(0xFFFF6B6B),
      Color(0xFFFFE66D),
      Color(0xFFFF8E53),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  
  /// 海洋渐变
  static const LinearGradient oceanGradient = LinearGradient(
    colors: [
      Color(0xFF667eea),
      Color(0xFF764ba2),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // ==================== 阴影颜色 ====================
  
  /// 阴影色
  static const Color shadow = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);
  
  /// 卡片阴影
  static const Color cardShadow = Color(0x0D000000);
  static const Color cardShadowDark = Color(0x1A000000);
  
  // ==================== 特殊颜色 ====================
  
  /// 透明色
  static const Color transparent = Color(0x00000000);
  
  /// 半透明黑色
  static const Color black26 = Color(0x42000000);
  static const Color black38 = Color(0x61000000);
  static const Color black54 = Color(0x8A000000);
  static const Color black87 = Color(0xDD000000);
  
  /// 半透明白色
  static const Color white26 = Color(0x42FFFFFF);
  static const Color white38 = Color(0x61FFFFFF);
  static const Color white54 = Color(0x8AFFFFFF);
  static const Color white87 = Color(0xDDFFFFFF);
  
  // ==================== 主题相关 ====================
  
  /// 当前主题模式
  static bool _isDarkMode = false;
  
  /// 设置主题模式
  static void setDarkMode(bool isDark) {
    _isDarkMode = isDark;
  }
  
  /// 获取当前主题模式
  static bool get isDarkMode => _isDarkMode;
  
  /// 根据主题获取背景色
  static Color getBackgroundColor() {
    return _isDarkMode ? backgroundDark : background;
  }
  
  /// 根据主题获取表面色
  static Color getSurfaceColor() {
    return _isDarkMode ? surfaceDark : surface;
  }
  
  /// 根据主题获取文本主色
  static Color getTextPrimaryColor() {
    return _isDarkMode ? textPrimaryDark : textPrimary;
  }
  
  /// 根据主题获取文本次色
  static Color getTextSecondaryColor() {
    return _isDarkMode ? textSecondaryDark : textSecondary;
  }
  
  /// 根据主题获取边框色
  static Color getBorderColor() {
    return _isDarkMode ? borderDark : border;
  }
  
  /// 根据主题获取分割线色
  static Color getDividerColor() {
    return _isDarkMode ? dividerDark : divider;
  }
  
  /// 根据主题获取卡片背景色
  static Color getCardBackgroundColor() {
    return _isDarkMode ? cardBackgroundDark : cardBackground;
  }
  
  // ==================== 颜色工具方法 ====================
  
  /// 创建带透明度的颜色
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
  
  /// 创建带透明度的主色
  static Color primaryWithOpacity(double opacity) {
    return primary.withOpacity(opacity);
  }
  
  /// 创建带透明度的辅助色
  static Color secondaryWithOpacity(double opacity) {
    return secondary.withOpacity(opacity);
  }
  
  /// 创建带透明度的强调色
  static Color accentWithOpacity(double opacity) {
    return accent.withOpacity(opacity);
  }
  
  /// 创建带透明度的成功色
  static Color successWithOpacity(double opacity) {
    return success.withOpacity(opacity);
  }
  
  /// 创建带透明度的警告色
  static Color warningWithOpacity(double opacity) {
    return warning.withOpacity(opacity);
  }
  
  /// 创建带透明度的错误色
  static Color errorWithOpacity(double opacity) {
    return error.withOpacity(opacity);
  }
  
  /// 创建带透明度的信息色
  static Color infoWithOpacity(double opacity) {
    return info.withOpacity(opacity);
  }
  
  // ==================== 颜色集合 ====================
  
  /// 获取所有主色调
  static List<Color> get primaryColors => [
    primary,
    primaryLight,
    primaryDark,
  ];
  
  /// 获取所有辅助色
  static List<Color> get secondaryColors => [
    secondary,
    secondaryLight,
    secondaryDark,
  ];
  
  /// 获取所有强调色
  static List<Color> get accentColors => [
    accent,
    accentLight,
    accentDark,
  ];
  
  /// 获取所有语义化颜色
  static List<Color> get semanticColors => [
    success,
    warning,
    error,
    info,
  ];
  
  /// 获取所有中性色
  static List<Color> get neutralColors => [
    white,
    lightGray,
    gray,
    darkGray,
    black,
  ];
  
  /// 获取所有渐变色
  static List<LinearGradient> get gradients => [
    primaryGradient,
    rainbowGradient,
    sunsetGradient,
    oceanGradient,
  ];
  
  // ==================== 颜色验证 ====================
  
  /// 检查颜色是否为深色
  static bool isDarkColor(Color color) {
    final luminance = color.computeLuminance();
    return luminance < 0.5;
  }
  
  /// 检查颜色是否为浅色
  static bool isLightColor(Color color) {
    return !isDarkColor(color);
  }
  
  /// 获取对比色（深色返回白色，浅色返回黑色）
  static Color getContrastColor(Color color) {
    return isDarkColor(color) ? white : black;
  }
  
  /// 获取适合的文本颜色（基于背景色）
  static Color getTextColorForBackground(Color backgroundColor) {
    return isDarkColor(backgroundColor) ? white : black;
  }
}
