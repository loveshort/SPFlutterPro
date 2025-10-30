/*
 * @作者: 顾明次
 * @Date: 2025-10-30
 * @Email: gu271901088@gmail.com
 * @描述: Tab配置模型
 */
import 'package:flutter/material.dart';

/// Tab项配置
class TabConfig {
  /// Tab标题
  final String title;

  /// 未选中时的图标
  final IconData unselectedIcon;

  /// 选中时的图标
  final IconData selectedIcon;

  /// Tab页面
  final Widget page;

  /// 未选中时的图标颜色
  final Color? unselectedIconColor;

  /// 选中时的图标颜色
  final Color? selectedIconColor;

  /// 未选中时的文本颜色
  final Color? unselectedTextColor;

  /// 选中时的文本颜色
  final Color? selectedTextColor;

  /// 字体大小
  final double? fontSize;

  /// 字体粗细
  final FontWeight? fontWeight;

  /// 图标大小
  final double? iconSize;

  /// 是否显示徽章
  final bool showBadge;

  /// 徽章文本
  final String? badgeText;

  /// 徽章背景色
  final Color? badgeColor;

  /// 徽章文本颜色
  final Color? badgeTextColor;

  /// 徽章字体大小
  final double? badgeFontSize;

  /// 是否启用
  final bool enabled;

  /// 点击回调
  final VoidCallback? onTap;

  const TabConfig({
    required this.title,
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.page,
    this.unselectedIconColor,
    this.selectedIconColor,
    this.unselectedTextColor,
    this.selectedTextColor,
    this.fontSize,
    this.fontWeight,
    this.iconSize,
    this.showBadge = false,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
    this.badgeFontSize,
    this.enabled = true,
    this.onTap,
  });

  /// 复制并更新配置
  TabConfig copyWith({
    String? title,
    IconData? unselectedIcon,
    IconData? selectedIcon,
    Widget? page,
    Color? unselectedIconColor,
    Color? selectedIconColor,
    Color? unselectedTextColor,
    Color? selectedTextColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? iconSize,
    bool? showBadge,
    String? badgeText,
    Color? badgeColor,
    Color? badgeTextColor,
    double? badgeFontSize,
    bool? enabled,
    VoidCallback? onTap,
  }) {
    return TabConfig(
      title: title ?? this.title,
      unselectedIcon: unselectedIcon ?? this.unselectedIcon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      page: page ?? this.page,
      unselectedIconColor: unselectedIconColor ?? this.unselectedIconColor,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      unselectedTextColor: unselectedTextColor ?? this.unselectedTextColor,
      selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      iconSize: iconSize ?? this.iconSize,
      showBadge: showBadge ?? this.showBadge,
      badgeText: badgeText ?? this.badgeText,
      badgeColor: badgeColor ?? this.badgeColor,
      badgeTextColor: badgeTextColor ?? this.badgeTextColor,
      badgeFontSize: badgeFontSize ?? this.badgeFontSize,
      enabled: enabled ?? this.enabled,
      onTap: onTap ?? this.onTap,
    );
  }
}

/// 底部导航栏样式配置
class BottomTabBarStyle {
  /// 背景颜色
  final Color? backgroundColor;

  /// 高度
  final double height;

  /// 是否显示顶部边框
  final bool showTopBorder;

  /// 顶部边框颜色
  final Color? topBorderColor;

  /// 顶部边框宽度
  final double topBorderWidth;

  /// Tab项间距
  final double itemSpacing;

  /// 是否启用动画
  final bool enableAnimation;

  /// 动画时长
  final Duration animationDuration;

  /// 是否启用水波纹效果
  final bool enableRipple;

  /// 水波纹颜色
  final Color? rippleColor;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 阴影
  final List<BoxShadow>? boxShadow;

  const BottomTabBarStyle({
    this.backgroundColor,
    this.height = 60.0,
    this.showTopBorder = false,
    this.topBorderColor,
    this.topBorderWidth = 0.5,
    this.itemSpacing = 4.0,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.enableRipple = true,
    this.rippleColor,
    this.padding,
    this.boxShadow,
  });

  BottomTabBarStyle copyWith({
    Color? backgroundColor,
    double? height,
    bool? showTopBorder,
    Color? topBorderColor,
    double? topBorderWidth,
    double? itemSpacing,
    bool? enableAnimation,
    Duration? animationDuration,
    bool? enableRipple,
    Color? rippleColor,
    EdgeInsetsGeometry? padding,
    List<BoxShadow>? boxShadow,
  }) {
    return BottomTabBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      height: height ?? this.height,
      showTopBorder: showTopBorder ?? this.showTopBorder,
      topBorderColor: topBorderColor ?? this.topBorderColor,
      topBorderWidth: topBorderWidth ?? this.topBorderWidth,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      enableAnimation: enableAnimation ?? this.enableAnimation,
      animationDuration: animationDuration ?? this.animationDuration,
      enableRipple: enableRipple ?? this.enableRipple,
      rippleColor: rippleColor ?? this.rippleColor,
      padding: padding ?? this.padding,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }
}
