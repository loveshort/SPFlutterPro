/*
 * @作者: 顾明次
 * @Date: 2025-10-30
 * @Email: gu271901088@gmail.com
 * @描述: Tab项组件
 */
import 'package:flutter/material.dart';
import 'tab_config.dart';

/// Tab项组件
class TabItemWidget extends StatelessWidget {
  /// Tab配置
  final TabConfig config;

  /// 是否选中
  final bool isSelected;

  /// 点击回调
  final VoidCallback? onTap;

  /// 样式配置
  final BottomTabBarStyle style;

  const TabItemWidget({
    super.key,
    required this.config,
    required this.isSelected,
    required this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 获取主题颜色
    final theme = Theme.of(context);

    // 确定图标颜色
    final iconColor = isSelected
        ? (config.selectedIconColor ?? theme.primaryColor)
        : (config.unselectedIconColor ?? Colors.grey.shade600);

    // 确定文本颜色
    final textColor = isSelected
        ? (config.selectedTextColor ?? theme.primaryColor)
        : (config.unselectedTextColor ?? Colors.grey.shade600);

    // 构建Tab内容
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 图标（带徽章）
        _buildIconWithBadge(iconColor),

        // 间距
        SizedBox(height: style.itemSpacing),

        // 标题
        Text(
          config.title,
          style: TextStyle(
            color: textColor,
            fontSize: config.fontSize ?? 12.0,
            fontWeight: config.fontWeight ?? FontWeight.normal,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );

    // 添加动画
    if (style.enableAnimation) {
      content = AnimatedScale(
        scale: isSelected ? 1.05 : 1.0,
        duration: style.animationDuration,
        child: content,
      );
    }

    // 构建可点击区域
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: config.enabled ? (onTap ?? config.onTap) : null,
          splashColor: style.enableRipple
              ? (style.rippleColor ?? iconColor.withOpacity(0.2))
              : Colors.transparent,
          highlightColor: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }

  /// 构建带徽章的图标
  Widget _buildIconWithBadge(Color iconColor) {
    final icon = Icon(
      isSelected ? config.selectedIcon : config.unselectedIcon,
      color: iconColor,
      size: config.iconSize ?? 24.0,
    );

    // 如果不显示徽章，直接返回图标
    if (!config.showBadge ||
        config.badgeText == null ||
        config.badgeText!.isEmpty) {
      return icon;
    }

    // 返回带徽章的图标
    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        Positioned(
          right: -8,
          top: -4,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: config.badgeColor ?? Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              config.badgeText!,
              style: TextStyle(
                color: config.badgeTextColor ?? Colors.white,
                fontSize: config.badgeFontSize ?? 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
