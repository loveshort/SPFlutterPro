/*
 * @作者: 顾明次
 * @Date: 2025-01-27
 * @Email: gu271901088@gmail.com
 * @描述: 底部Tab数据模型
 */
import 'package:flutter/material.dart';

/// 底部Tab项数据模型
class TabItem {
  /// Tab标题
  final String title;

  /// 未选中状态的图标
  final IconData? unselectedIcon;

  /// 选中状态的图标
  final IconData? selectedIcon;

  /// 未选中状态的图标颜色
  final Color? unselectedIconColor;

  /// 选中状态的图标颜色
  final Color? selectedIconColor;

  /// 未选中状态的文字颜色
  final Color? unselectedTextColor;

  /// 选中状态的文字颜色
  final Color? selectedTextColor;

  /// 文字大小
  final double? fontSize;

  /// 文字字体粗细
  final FontWeight? fontWeight;

  /// 图标大小
  final double? iconSize;

  /// 对应的页面Widget
  final Widget page;

  /// 是否显示徽章
  final bool showBadge;

  /// 徽章内容
  final String? badgeText;

  /// 徽章颜色
  final Color? badgeColor;

  const TabItem({
    required this.title,
    this.unselectedIcon,
    this.selectedIcon,
    this.unselectedIconColor,
    this.selectedIconColor,
    this.unselectedTextColor,
    this.selectedTextColor,
    this.fontSize,
    this.fontWeight,
    this.iconSize,
    required this.page,
    this.showBadge = false,
    this.badgeText,
    this.badgeColor,
  });
}
